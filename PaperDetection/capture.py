import cv2
import numpy as np
import requests
import json
import time
import sys

from communication import Communication

### A CONFIGURER !

class Capture():

    selected_color = (0, 0, 0)

    width = 0
    height = 0
    detection_size = 50
    detection_delta = 50

    etalonnage_top_left = 0
    etalonnage_bottom_right = 0

    cap, com = (None,)*2
    upper_bound, lower_bound = (None,)*2

    def __init__(self):
        self.com = Communication()
        self.com.start()

        self.cap = cv2.VideoCapture(1)
        _, frame = self.cap.read()
        self.height, self.width, _ = frame.shape
        self.etalonnage_top_left = (self.width/2 - self.detection_size, self.height / 2 - self.detection_size)
        self.etalonnage_bottom_right = (self.width/2 + self.detection_size, self.height / 2 + self.detection_size)

    ### Etalonnage
    def etalonnage(self):
        print("--- ETALONNAGE ---")
        while True:
            _, frame = self.cap.read()
            cv2.rectangle(frame, self.etalonnage_top_left, self.etalonnage_bottom_right, (255, 0, 0), 5)
            # @TODO @IMPROVEMENT Moyenner sur plein d'images
            detect_blue, detect_green, detect_red, count_pix = (0,)*4
            for i in range(self.etalonnage_top_left[0]+1, self.etalonnage_bottom_right[0]):
                for j in range(self.etalonnage_top_left[1]+1, self.etalonnage_bottom_right[1]):
                    detect_blue += frame[j][i][0]
                    detect_green += frame[j][i][1]
                    detect_red += frame[j][i][2]
                    count_pix += 1

            self.selected_color = ( \
                detect_blue / count_pix, \
                detect_green / count_pix, \
                detect_red / count_pix, \
            )

            self.com.send("ETA "+str(self.selected_color[2])+" "+str(self.selected_color[1])+" "+str(self.selected_color[0])+"\n")

            if not self.com.receive().empty():
                self.calculate_bounds()
                return self.com.receive().get()

    def calculate_bounds(self):
        # define range of blue color in BGR format
        self.lower_bound = np.array([ \
                max(self.selected_color[0] - self.detection_delta, 0), \
                max(self.selected_color[1] - self.detection_delta, 0), \
                max(self.selected_color[2] - self.detection_delta, 0) \
            ], dtype=np.uint8)

        self.upper_bound = np.array([ \
                min(self.selected_color[0] + self.detection_delta, 255), \
                min(self.selected_color[1] + self.detection_delta, 255), \
                min(self.selected_color[2] + self.detection_delta, 255) \
            ], dtype=np.uint8)

    #### Capture
    def capture(self):
        print("--- CAPTURE ---")
        old_white_pixel_count = 0
        old_centroid = (0, 0)
        while True:
            _, frame = self.cap.read()

            mask = cv2.inRange(frame, self.lower_bound, self.upper_bound)
            white_pixel_count = cv2.countNonZero(mask)
            moments = cv2.moments(mask, False)
            try:
                centroid = (moments['m10']/moments['m00'], moments['m01']/moments['m00'])
            except:
                centroid = old_centroid

            movement_size = white_pixel_count - old_white_pixel_count
            movement_position = (centroid[0] - old_centroid[0], centroid[1] - old_centroid[1])

            data = "CAP "+ \
                          str(self.width)+" "+ \
                          str(self.height)+" "+ \
                          str(white_pixel_count)+" "+ \
                          str(movement_size)+" "+ \
                          str(centroid[0])+" "+ \
                          str(centroid[1])+" "+ \
                          str(movement_position[0])+" "+ \
                          str(movement_position[1])+"\n"

            self.com.send(data)

            ######### AFTER
            old_white_pixel_count = white_pixel_count
            old_centroid = centroid

            if not self.com.receive().empty():
                return self.com.receive().get()

    def run(self):
        while True:
            self.etalonnage()
            self.capture()

    def terminate(self):
        self.com.terminate()


