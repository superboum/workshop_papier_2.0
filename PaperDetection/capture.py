import cv2
import numpy as np
import requests
import json
import time

### A CONFIGURER !

DELTA = 50
SIZE = 50
DETECT_RED = 0
DETECT_BLUE = 0
DETECT_GREEN = 0

### CODE

cap = cv2.VideoCapture(0)

#### Etalonnage
_, frame = cap.read()
height, width, channels = frame.shape
etalonnage_top_left = (width/2 - SIZE, height / 2 - SIZE)
etalonnage_bottom_right = (width/2 + SIZE, height / 2 + SIZE)

start_time = time.time()
while start_time+4 > time.time():
    _, frame = cap.read()
    cv2.rectangle(frame, etalonnage_top_left, etalonnage_bottom_right, (255, 0, 0), 5)
    cv2.imshow('frame',frame)
    k = cv2.waitKey(5) & 0xFF

# Moyenner sur plein d'images
count_pix = 0
for i in range (etalonnage_top_left[0]+1, etalonnage_bottom_right[0]):
    for j in range(etalonnage_top_left[1]+1, etalonnage_bottom_right[1]):
        DETECT_BLUE += frame[j][i][0]
        DETECT_GREEN += frame[j][i][1]
        DETECT_RED += frame[j][i][2]
        count_pix += 1

DETECT_BLUE /= count_pix
DETECT_GREEN /= count_pix
DETECT_RED /= count_pix

while start_time+6 > time.time():
    _, frame = cap.read()
    cv2.rectangle(frame, etalonnage_top_left, etalonnage_bottom_right, (DETECT_BLUE, DETECT_GREEN, DETECT_RED), 10)
    cv2.imshow('frame',frame)
    k = cv2.waitKey(5) & 0xFF

cv2.destroyAllWindows()

#### Capture
i = 0
old_white_pixel_count = 0
old_centroid = (0,0)
while(1):

    # Take each frame
    _, frame = cap.read()

    # Convert BGR to HSV
    # hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    # define range of blue color in BGR format
    lower_blue = np.array([max(DETECT_BLUE-DELTA, 0), max(DETECT_GREEN-DELTA, 0), max(DETECT_RED-DELTA, 0)], dtype=np.uint8)
    upper_blue = np.array([min(DETECT_BLUE+DELTA, 255), min(DETECT_GREEN+DELTA, 255), min(DETECT_RED+DELTA, 255)],  dtype=np.uint8)


    # Threshold the HSV image to get only blue colors
    mask = cv2.inRange(frame, lower_blue, upper_blue)

    # Bitwise-AND mask and original image
    # res = cv2.bitwise_and(frame,frame, mask= mask)

    cv2.imshow('mask',mask)
    cv2.imshow('frame',frame)

    white_pixel_count = cv2.countNonZero(mask)

    moments = cv2.moments(mask, False)
    centroid = (moments['m10']/moments['m00'], moments['m01']/moments['m00'])

    movement_size = white_pixel_count - old_white_pixel_count
    movement_position = (centroid[0] - old_centroid[0], centroid[1] - old_centroid[1])

    print width, height, white_pixel_count, movement_size, centroid[0], centroid[1], movement_position[0], movement_position[1]

    ######### AFTER
    old_white_pixel_count = white_pixel_count
    old_centroid = centroid

    k = cv2.waitKey(5) & 0xFF
    if k == 27:
      break

cv2.destroyAllWindows()
