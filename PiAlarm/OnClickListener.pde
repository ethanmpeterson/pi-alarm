class OnClickListener implements Triangle, Rectangle, Circle {

  private Util u = new Util(); // gives access to util functions in case they are needed
  private Resource r = new Resource(); // gives class access to variables stored in Resource class

  color highColor;
  // arrays to hold coordinates from the shapes being inputted into their respective function
  float triangle[] = new float[5];
  float rectangle[] = new float[3];
  float circle[] = new float[2];
  public boolean[] = new boolean[2]; // public boolean array to check if the


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

  }

  void rect(float x, float y, float width, float height) {

  }
  void rectListen(OnClickListener r) {

  }

  void circle(float x, float y, float diameter) {

  }
  void circleListen(OnClickListener c) {

  }
}
