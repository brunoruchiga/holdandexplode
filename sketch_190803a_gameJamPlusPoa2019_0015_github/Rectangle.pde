class Rectangle {
  float x, y, w, h;
  
  Rectangle(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  void update(float _x, float _y) {
    x = _x;
    y = _y;
  }
  
   void update(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  void update(PVector pos) {
    x = pos.x;
    y = pos.y;
  }
  
  boolean intersects(Rectangle other) {
    return (other.x < this.x  + this.w &&
            other.x + other.w > this.x &&
            other.y < this.y  + this.h &&
            other.y + other.h > this.y );
  }
}
