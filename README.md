Selfiebot
=========
This is a modified version of the [original selfiebot project](https://github.com/nodebox/selfiebot). Selfiebot is a drawing robot that draws quick selfie images. This is a Processing sketch that converts the images to G-code using a canny edge detection. See some examples in the `Samples` folder.

![Demo selfiebot output](./g/selfie.jpg)

Modifications
=============
At the moment it has been added a `.png` image for fab modules and soon it will write directly a `.camm` file for the Roland Vinyl Cutters.

> WIP porting the G-Code to the Roland CAMM-GL III file format.

Usage
=====
1. Download [Processing](http://processing.org/download/).
2. Download and install the [controlP5 library](http://www.sojamo.de/libraries/controlP5/) and the video library.
3. Open the sketch and run it.
4. Stand in front of the webcam.
5. Press the spacebar to export the current image to G-code, image (in the future `.camm` file).
6. Load the Roland Vinyl Cutter with a piece of paper and replace the blade with the [penholder adapter](https://github.com/TheBeachLab/Roland_VinylDraw) and your favourite bic pen, pencil or marker.
7. Import the `.png` file into Fab Modules and proceed as if you were cutting vinyl.

Credits
=======
* Original sketch by [TODO](http://www.todo.to.it/)
* [Canny edge detection](http://www.tomgibara.com/computer-vision/canny-edge-detector) algoritm by Tom Gibara.
* Selfiebot uses a [Makelangelo Kit](https://github.com/MarginallyClever/Makelangelo)

License
=======
Selfiebot is released under the [Creative Commons Attribution-NonCommercial-ShareAlike 3.0 license](http://creativecommons.org/licenses/by-nc-sa/3.0/).
