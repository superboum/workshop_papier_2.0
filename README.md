workshop
========

We use a webcam to detect a colored paper with opencv and python.
We detect the position and the size of the detected paper.
When we manipulate the paper, the position and the size detected is modified.
We use this data to control the display and fairy lights.


PaperDetecttion/example_data.txt
--------------------------------

Values are in the following order :
 * width
 * height (with the width you can calculate the number of pixel)
 * number of detected pixel (the paper)
 * difference of detected pixel between 2 pictures
 * x position of the center of the paper
 * y position of the center of the paper
 * x movement of the center of the paper
 * y movement of the center of the paper

Data could be normalized with the width and the height
