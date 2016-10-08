import cv2
import numpy as np
import requests
import json
import time

### A CONFIGURER !

DETECT_RED = 255
DETECT_GREEN = 166
DETECT_BLUE = 132
DELTA = 50
SIZE = 50

### CODE

cap = cv2.VideoCapture(0)

#### Etalonnage
_, frame = cap.read()
height, width, channels = frame.shape

start_time = time.time()
while start_time+10 > time.time():
    _, frame = cap.read()
    cv2.rectangle(frame, (width/2 - SIZE, height / 2 - SIZE), (width/2 + SIZE, height / 2 + SIZE), (255,0,0), 5)
    cv2.imshow('frame',frame)
    k = cv2.waitKey(5) & 0xFF

cv2.destroyAllWindows()

#### Capture
i = 0
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
    k = cv2.waitKey(5) & 0xFF
    if k == 27:
      break

cv2.destroyAllWindows()
