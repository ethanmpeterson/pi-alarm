class OnClickListener {

private Util u = new Util(); // gives access to util functions in case they are needed
private Resource r = new Resource(); // gives class access to variables stored in Resource class

color highColor;

  void OnClickListener(color highlight) { // takes color the button should be when the user is hovering over it
    highlight = this.highColor; // will change depending on the instance of the class by using this
    // each instance of OnClickListner can have a unique value as oppose to other objects of the same type inheriting it
  }
}
