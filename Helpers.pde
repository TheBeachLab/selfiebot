// TODO Remove
float fromPixelToPaperValue(float pixelValue, float sr_) {
  // normalize the pixel X,Y coordinates to the real paper sheet dimensions expressed in mm
  float paperValue = (pixelValue/sr_);
  ;
  return paperValue;
}

// TODO Remove
void convertPixelLinesToPaperLines() {

  //  for (int i=0; i<pixelLines.size(); i++) {
  //    // converts the coordinates from pixel to paper values, adjusting for a different origin
  //    Line2D currentLine = pixelLines.get(i);
  //    float paperX1 = fromPixelToPaperValue(currentLine.a.x, sr)-pW/sr;
  //    float paperY1 = fromPixelToPaperValue(currentLine.a.y, sr)-pH/sr;
  //    float paperX2  = fromPixelToPaperValue(currentLine.b.x, sr)-pW/sr;
  //    float paperY2  = fromPixelToPaperValue(currentLine.b.y, sr)-pH/sr;
  //    Line2D linePaper = new Line2D(new Vec2D(paperX1, paperY1), new Vec2D(paperX2, paperY2));
  //    paperLines.add(linePaper);
  //  }
}

void exportToGcode(ArrayList<ArrayList<PVector>> lines) {
  float scaleRatio = 1.0 / sketchWidth * paperWidth;

  String outputFolder = "Export/";
  String prefix = "selfie-";
  String timeStamp = dateNow();
  String fileName = outputFolder + prefix + timeStamp + ".camm";
  PrintWriter output = createWriter(fileName);
  writeHeader(output);

  for (ArrayList<PVector>line: lines) {
    boolean first = true;
    for (PVector pt: line) {
      pt.mult(scaleRatio);
      pt.sub(paperHeight/ 2, paperWidth/2, 0);
      if (first) {
        output.println("// first");  // draw line
        output.println("PU" + pt.x + "," + -(pt.y) + ";");  // draw line
        output.println("PU" + pt.x + "," + -(pt.y) + ";");  // draw line
        first = false;
      }
      else {
        output.println("PD" + pt.x + "," + -(pt.y) + ";");  // draw line
        output.println("PD" + pt.x + "," + -(pt.y) + ";");  // draw line
      }
    }
  }
  writeFooter(output);
  println("Roland .camm file: Exported to " + fileName);
}

void writeHeader(PrintWriter output) {
  // writes an header with the required setup instructions for the CAMM-GL output file
  // output.println("( Made with Processing. Paper size: "  + paperWidth + "x" + paperHeight + "mm )");
  output.println("PA;PA;!ST1;!FS" + force + ";VS" + velocity + ";");
  output.println("// end of header");
}

void writeFooter(PrintWriter output) {
  // writes a footer with the end instructions for the CAMM-GL output file
  output.println("// footer start ");
  // PU0,0: => go home
  output.println("PU0,0;");
}

// Return a string containing the current date/time.
String dateNow() {
  return String.format("%4d%02d%02d-%02d%02d%02d", year(), month(), day(), hour(), minute(), second());
  //  return(year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second());
}