class OnClickListener implements Triangle, Rectangle, Circle {

  private Util u = new Util(); // gives access to util functions in case they are needed
  private Resource r = new Resource(); // gives class access to variables stored in Resource class

  color highColor;
  // arrays to hold coordinates from the shapes being inputted into their respective function
  float triangle[] = new float[6];
  float triAreas[] = new float[4]; // will store area values for calculating if the the mouse is inside any given triangle
  float rectangle[] = new float[4];
  float circle[] = new float[3];
  public boolean overShape[] = new boolean[3]; // public boolean array to check if the cursor is hovering over a certain shape depending on the position in the array
  // ex. first position is true if the cursor is hovering over a triangle


  void OnClickListener(color highlight) { // takes color the button should be when the user is hovering over it
    highlight = this.highColor; // will change depending on the instance of the class by using this
    // each instance of OnClickListner can have a unique value as oppose to other objects of the same type inheriting it
  }
  // interface methods (program does not compile unless methods from the interfaces I have implemented in the class are within it)

  void tri(float x1, float y1, float x2, float y2, float x3, float y3) {
    this.triangle[0] = x1;
    this.triangle[1] = y1;
    this.triangle[2] = x2;
    this.triangle[3] = y2;
    this.triangle[4] = x3;
    this.triangle[5] = y3;
  }

  //function listens for button presses and does something if the given triangle has been pressed (same applies for the following shapes)
  void triListen(OnClickListener t) { // takes OnClickListener as input to check the variables of that particular object
    // get area of the triangle given in this object
    triAreas[0] = triArea(t.triangle[0], t.triangle[1], t.triangle[2], t.triangle[3], t.triangle[4], t.triangle[5]);
    // collect area substiting each point of the triangle with the mouse coordinates and storing them in a float array
    triAreas[1] = triArea(mouseX, mouseY, t.triangle[2], t.triangle[3], t.triangle[4], t.triangle[5]);
    triAreas[2] = triArea(t.triangle[0], t.triangle[1], mouseX, mouseY, t.triangle[4], t.triangle[5]);
    triAreas[3] = triArea(t.triangle[0], t.triangle[1], t.triangle[2], t.triangle[3], mouseX, mouseY);
    if (triAreas[0] == triAreas[1] + triAreas[2] + triAreas[3]) {
      overShape[0] = true;
    } else {
      overShape[0] = false;
    }
  }


  void rect(float x, float y, float width, float height) {

  }

  void rectListen(OnClickListener r) {

  }


  void circle(float x, float y, float diameter) {

  }

  void circleListen(OnClickListener c) {

  }


  // extra class functions
  float triArea(float x1, float y1, float x2, float y2, float x3, float y3) {
    return abs((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2))/2.0); // return absolute value (whole number) of the area
  }
}
