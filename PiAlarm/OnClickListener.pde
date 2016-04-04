class OnClickListener implements Triangle, Rectangle, Circle { // implements methods within each of those interfaces

  private Util u = new Util(); // gives access to util functions in case they are needed
  private Resource r = new Resource(); // gives class access to variables stored in Resource class

  // arrays to hold coordinates from the shapes being inputted into their respective function
  float triangle[] = new float[6];
  float triAreas[] = new float[4]; // will store area values for calculating if the the mouse is inside any given triangle
  float rectangle[] = new float[4];
  float circle[] = new float[3];
  public boolean overShape[] = new boolean[3]; // public boolean array to check if the cursor is hovering over a certain shape depending on the position in the array
  // ex. first position is true if the cursor is hovering over a triangle


  void OnClickListener() {/*Nothing to Construct*/}
  // interface methods (program does not compile unless methods from the interfaces I have implemented in the class are within it)

  void tri(float x1, float y1, float x2, float y2, float x3, float y3) {
    this.triangle[0] = x1; // use this to make the value unique to the particular instance of the OnClickListener class
    this.triangle[1] = y1;
    this.triangle[2] = x2;
    this.triangle[3] = y2;
    this.triangle[4] = x3;
    this.triangle[5] = y3;
  }


  void rect(float x, float y, float width, float height) {
    // fill the rectangle array with values inputted into the function using this to make it unique to the particular instance of the class
    this.rectangle[0] = x;
    this.rectangle[1] = y;
    this.rectangle[2] = width;
    this.rectangle[3] = height;
  }


  void circle(float x, float y, float diameter) {
    this.circle[0] = x;
    this.circle[1] = y;
    this.circle[2] = diameter;
  }


  //function listens for button presses and does something if the given shape has been pressed
  void listen(OnClickListener button, String shape) { // takes OnClickListener as input to check the variables of that particular object
    if (shape == "TRIANGLE") {
      // get area of the triangle given in this object
      triAreas[0] = triArea(button.triangle[0], button.triangle[1], button.triangle[2], button.triangle[3], button.triangle[4], button.triangle[5]);
      // collect area substiting each point of the triangle with the mouse coordinates and storing them in a float array
      triAreas[1] = triArea(mouseX, mouseY, button.triangle[2], button.triangle[3], button.triangle[4], button.triangle[5]);
      triAreas[2] = triArea(button.triangle[0], button.triangle[1], mouseX, mouseY, button.triangle[4], button.triangle[5]);
      triAreas[3] = triArea(button.triangle[0], button.triangle[1], button.triangle[2], button.triangle[3], mouseX, mouseY);
      if (triAreas[0] == triAreas[1] + triAreas[2] + triAreas[3]) {
        overShape[0] = true;
      } else {
        overShape[0] = false;
      }
    } else if (shape == "RECTANGLE") {
      if (mouseX >= button.rectangle[0] && mouseX <= button.rectangle[0] + button.rectangle[2] && mouseY >= button.rectangle[1] && mouseY <= button.rectangle[3]) {
        overShape[1] = true;
      } else {
        overShape[1] = false;
      }
    } else if (shape == "CIRCLE") {
      if (sqrt(sq(button.circle[0] - mouseX) + sq(button.circle[1] - mouseY) < button.circle[2])) {
        overShape[2] = true;
      } else {
        overShape[2] = false;
      }
    }
  }

  public boolean over() { // returns true if the cursor is hovering over a shape given to the class
    if (!this.overShape[0] && !this.overShape[1] && !this.overShape[2]) {
      return false;
    } else {
      return true;
    }
  }
  // extra class functions
  float triArea(float x1, float y1, float x2, float y2, float x3, float y3) {
    return abs((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2))/2.0); // return absolute value (positive val) of the area
  }
}
