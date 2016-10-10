workshop
========

We use a webcam to detect a colored paper with opencv and python.
We detect the position and the size of the detected paper.
When we manipulate the paper, the position and the size detected is modified.
We use this data to control the display and fairy lights.

protocol
--------

An example :

```
--> ETA 125 230 126
--> ETA 126 233 128
<-- OK
--> CAP 800 600 25263 0 230.0 126.0 0.0 0.0
--> CAP 800 600 25262 -1 220.0 120.0 -10.0 -6.0
<-- OK
--> ETA 126 233 122
...
```

### ETA (Server sends to Client)

ETA means "etalonnage" (calibration). The three numbers are the RGB color (0 to 255).

```
ETA red(int, 0-255) green(int, 0-255) blue(int, 0-255)
```

### CAP (Server sends to Client)

CAP means "capture".

```
CAP width(int) height(int) detected_pixel_count(int) detected_pixel_count_delta(int) paper_position_x(float) paper_position_y(float) paper_position_x_delta(float) paper_position_y_delta(float)
```

### OK (Client sends to Server)

OK means... OK
Just to switch betwean ETA and CAP...

