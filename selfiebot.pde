/*
 *** Selfiebot ***
 *** This sketch converts a webcam image to Roland CAMM-GL III using canny edge detection.
 *** Original code Written by TODO.TO.IT / Giorgio Olivero
 *** Heavily modified by Lieven Menschaert and Frederik De Bleser, EMRG (www.emrg.be)
 *** Further modified by Francisco Sanchez (www.beachlab.org) to incorporate CAMM-GL III Instructions list
 *** This software is released under
 *** Creative Commons Attribution-NonCommercial-ShareAlike 3.0 CC BY-NC-SA
 *** http://creativecommons.org/licenses/by-nc-sa/3.0/
 */

import processing.video.*;
import controlP5.*;
import java.awt.image.BufferedImage;
import java.util.Arrays;

Capture video;
ControlP5 cp5;
int seg;
CannyEdgeDetector detector;
PImage inputImage, edgesImage;
ArrayList<ArrayList<PVector>> lines;

// Dimensions of the input video.
int videoWidth = 1280;
int videoHeight = 720;

// Dimensions of the paper (in millimeters).
int paperWidth = 297;  // A4
int paperHeight = 210;

// Dimensions of the Processing applet.
int sketchWidth = videoWidth;
int sketchHeight = videoHeight;

// Define pen UP and DOWN positions
float penUp = 90.0;
float penDown = 0.0;

// Define Feed rate (stepper motors speed)
float motorFeedSlow = 100.0;
float motorFeedFast = 1000.0;

// Define Roland Vinyl Cutter Velocity and Force (GS-24 GX-24)
float velocity = 10.0; // cm/s
float force = 120.0;   // g

int divider = 1;
PImage test;
int complexity = 1;

void setup() {
  frameRate(30);
  size(1280, 720);
  video = new Capture(this, videoWidth, videoHeight);
  video.start();
  cp5 = new ControlP5(this);

  cp5.addSlider("complexity")
     .setPosition(20,height-20)
     .setRange(1,4)
     .setColorBackground(color(200))
     .setColorCaptionLabel(color(0))
     ;

  seg = 5;
  background(255); // white background
  noFill(); // shapes will have no fill
  stroke(0); // stroke color set as black
  //smooth(); // set anti-aliasing
  detector = new CannyEdgeDetector();

  detector.setLowThreshold(1.0f);
  detector.setHighThreshold(2.0f);
}

void draw() {
  background(240);
  seg = complexity;//control object

  if (video.available()) {
    video.read();
  }

  inputImage = video;
  detector.setSourceImage((java.awt.image.BufferedImage)inputImage.getImage());
  detector.process();
  edgesImage = new PImage(detector.getEdgesImage());

  //image(inputImage, 0, 0, sketchWidth, sketchHeight); // uncomment to show the video
  //image(edgesImage, 0, 0, sketchWidth, sketchHeight); // uncomment to seed the edge detect image

  lines = findLines(edgesImage);
  stroke(0);
  for (ArrayList<PVector>line: lines) {
    beginShape();
    for (PVector pt: line) {
      vertex(pt.x, pt.y);
    }
    endShape();
  }
}

void keyPressed() {
  if (key == ' ') {                     // On spacebar press
    exportToCAMM(lines);                 // export to .camm format
    exportToGcode(lines);                 // export to Gcode format
    saveFrame("./Export/selfie-" + dateNow() + ".png");  // and save the .png image
  }
}

ArrayList<ArrayList<PVector>> findLines(PImage edges) {
  ArrayList<ArrayList<PVector>> lines = new ArrayList<ArrayList<PVector>>();
  for (int y = 0; y < edgesImage.height-1; y+=seg) {
    for (int x = 0; x < edgesImage.width-1; x+=seg) {
      ArrayList<PVector> line = findLine(edgesImage, x, y);
      if (line != null) {
        lines.add(line);
      }
    }
  }
  return lines;
}

// Find the line and return an arraylist of points.
ArrayList<PVector> findLine(PImage edges, int startX, int startY) {
  color c = edges.get(startX, startY);
  if (c == #ffffff) {
    ArrayList<PVector> line = new ArrayList<PVector>();
    line.add(new PVector(startX, startY));
    edges.set(startX, startY, #000000);
    int x = startX;
    int y = startY;
    while (true) {
      PVector p = nextPoint(edges, x, y);
      if (p == null) break;
      line.add(p);
      edges.set((int)p.x, (int) p.y, #000000);
      x = (int) p.x;
      y = (int) p.y;
    }
    return line;
  }
  else {
    return null;
  }
}

// Find the next point, or null if no point could be found.
PVector nextPoint(PImage edges, int x, int y) {
  for (int dx = -seg; dx <= seg; dx++) {
    for (int dy = -seg; dy <= seg; dy++) {
      color c = edges.get(x + dx, y + dy);
      if (c == #ffffff) {
        return new PVector(x + dx, y + dy);
      }
    }
  }
  return null;
}
