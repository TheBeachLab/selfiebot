Selfiebot
=========
This is a modified version of the [original selfiebot project](https://github.com/nodebox/selfiebot). Selfiebot is a drawing robot that draws quick selfie images. This is a Processing sketch that converts the images to [Roland CAMM-GL III](./pnc900_user.pdf) using a canny edge detection. See some examples in the `Samples` folder.

![Demo selfiebot output](./g/selfie.jpg)

Modifications
=============
At the moment it has been added a `.png` image for fab modules and it writes directly a `.camm` file for the Roland Vinyl Cutters.

> WIP porting the vectors to the Roland CAMM-GL III file format. Units are not correct.

>At this moment I am debugging:
* Footer does not appear
* There are some vectors with PU and no PD (Points?)

Usage
=====
1. Download [Processing](http://processing.org/download/).
2. Download and install the [controlP5 library](http://www.sojamo.de/libraries/controlP5/) and the video library.
3. Open the sketch and run it.
4. Stand in front of the webcam.
5. Press the spacebar to export the current image to a `.png` image and a `.camm` file.
6. Load the Roland Vinyl Cutter with a piece of paper and replace the blade with the [penholder adapter](https://github.com/TheBeachLab/Roland_VinylDraw) and your favourite bic pen, pencil or marker.
7. Option 1. Import the `.png` file into Fab Modules and proceed as if you were cutting vinyl. ~~Option 2: Send the `.camm` file to the vinyl cutter~~

Credits
=======
* Original sketch by [TODO](http://www.todo.to.it/)
* [Canny edge detection](http://www.tomgibara.com/computer-vision/canny-edge-detector) algoritm by Tom Gibara.
* Selfiebot uses a [Makelangelo Kit](https://github.com/MarginallyClever/Makelangelo)
* CAMM-GL III port by [Francisco Sanchez](http://beachlab.org)

License
=======
Selfiebot is released under the [Creative Commons Attribution-NonCommercial-ShareAlike 3.0 license](http://creativecommons.org/licenses/by-nc-sa/3.0/).
