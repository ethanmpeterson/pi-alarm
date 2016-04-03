interface Triangle {
  void tri(float x1, float y1, float x2, float y2, float x3, float y3);
  void triListen(OnClickListener t);
}

interface Rectangle {
  void rect(float x, float y, float width, float height)
  void rectListen(OnClickListener r);
}

interface Circle {
  void circle(float x, float y, float diameter);
  void circleListen(OnClickListener c);
}
