class OnClickListener implements Triangle, Rectangle, Circle { // implements methods within each of those interfaces

  private Util u = new Util(); // gives access to util functions in case they are needed
  private Resource r = new Resource(); // gives class access to variables stored in Resource class

  // arrays to hold coordinates from the shapes being inputted into their respective function
  float triangle[] = new float[6];
  float triAreas[] = new float[4]; // will store area values for calculating if the the mouse is inside any given triangle
  float rectangle[] = new float[4];
  float circle[] = new float[3];
  private boolean overShape[] = new boolean[3]; // public boolean array to check if the cursor is hovering over a certain shape depending on the position in the array
  // ex. first position is true if the cursor is hovering over a triangle
  // private class variables

  void OnClickListener() { // Nothing to Construct
  
  }
  
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
  void listen(String shape) { // takes OnClickListener as input to check the variables of that particular object
    if (shape == "TRIANGLE") { // function should be called in a loop
      // get area of the triangle given in this object
      // using this keyword is able to replace the OnClickListener object parameter by implying the current object that the function was called from
      this.triAreas[0] = triArea(this.triangle[0], this.triangle[1], this.triangle[2], this.triangle[3], this.triangle[4], this.triangle[5]); // use this to only assign the area to the particular instance of the class the function is being used in
      // collect area substiting each point of the triangle with the mouse coordinates and storing them in a float array
      this.triAreas[1] = triArea(mouseX, mouseY, this.triangle[2], this.triangle[3], this.triangle[4], this.triangle[5]);
      this.triAreas[2] = triArea(this.triangle[0], this.triangle[1], mouseX, mouseY, this.triangle[4], this.triangle[5]);
      this.triAreas[3] = triArea(this.triangle[0], this.triangle[1], this.triangle[2], this.triangle[3], mouseX, mouseY);
      if (this.triAreas[0] == this.triAreas[1] + this.triAreas[2] + this.triAreas[3]) {
        this.overShape[0] = true;
      } else {
        this.overShape[0] = false;
      }
      if (this.over() && mousePressed) {
        fill(r.buttonHighlight);
        triangle(this.triangle[0], this.triangle[1], this.triangle[2], this.triangle[3], this.triangle[4], this.triangle[5]);
      } else {
        fill(255);
        triangle(this.triangle[0], this.triangle[1], this.triangle[2], this.triangle[3], this.triangle[4], this.triangle[5]);
      }
    } else if (shape == "RECTANGLE") {
      if (mouseX >= this.rectangle[0] && mouseX <= this.rectangle[0] + this.rectangle[2] && mouseY >= this.rectangle[1] && mouseY <= this.rectangle[1] + this.rectangle[3]) {
        this.overShape[1] = true;
      } else {
        this.overShape[1] = false;
      }
      if (this.over() && mousePressed) {
        fill(r.buttonHighlight);
        rect(this.rectangle[0], this.rectangle[1], this.rectangle[2], this.rectangle[3]);
      } else {
        fill(255);
        rect(this.rectangle[0], this.rectangle[1], this.rectangle[2], this.rectangle[3]);
      }
    } else if (shape == "CIRCLE") {
      if (sqrt(sq(this.circle[0] - mouseX) + sq(this.circle[1] - mouseY)) < this.circle[2]) {
        this.overShape[2] = true;
      } else {
        this.overShape[2] = false;
      }
      if (this.over() && mousePressed) {
        fill(r.buttonHighlight);
        ellipse(this.circle[0], this.circle[1], this.circle[2], this.circle[2]);
      } else {
        fill(255);
        ellipse(this.circle[0], this.circle[1], this.circle[2], this.circle[2]);
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