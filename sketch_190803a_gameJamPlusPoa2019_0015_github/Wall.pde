class Wall {
  PVector pos;
  float w, h;
  Rectangle area;
  boolean active;
  int type;

  Wall(float x, float y, float _w, float _h, int _type) {
    pos = new PVector(x, y);
    w = _w;
    h = _h;
    area = new Rectangle(pos.x, pos.y, w, h);
    active = true;
    type = _type;
  }

  Wall(int x, int y, int _type) {
    pos = new PVector(x*em, y*em);
    w = ceil(random(3))*em;
    h = ceil(random(3))*em;
    area = new Rectangle(pos.x, pos.y, w, h);
    active = true;
    type = _type;
  }

  void display() {
    if (isVisibleInsideScreen(pos.x, pos.y)) {
      if (active) {
        strokeWeight(1);
        if (type == 0) {
          stroke(150);
          fill(150);
        } else if (type == 1) {
          stroke(100);
          fill(100);
        }
        rect(pos.x, pos.y, w, h);

        //noStroke();
        //fill(100);
        //rect(pos.x, pos.y - em, w, h);
      }
    }
  }

  void intersect(PVector pos, PVector prevPos, Rectangle area) {
    if (active) {

      //Prevent jumping over over if too fast
      if (prevPos.y + area.h > this.pos.y && prevPos.y < this.pos.y + this.h) {
        if (prevPos.x + area.w/2 < this.pos.x + this.w/2 && pos.x + area.w/2 > this.pos.x + this.w/2) {
          pos.x = this.pos.x - area.w;
        }
        if (prevPos.x + area.w/2 > this.pos.x + this.w/2 && pos.x + area.w/2 < this.pos.x + this.w/2) {
          pos.x = this.pos.x + this.w;
        }
      }
      if (prevPos.x + area.w > this.pos.x && prevPos.x < this.pos.x + this.w) {
        if (prevPos.y + area.h/2 < this.pos.y + this.h/2 && pos.y + area.h/2 > this.pos.y + this.h/2) {
          pos.y = this.pos.y - area.h;
        }
        if (prevPos.y + area.h/2 > this.pos.y + this.h/2 && pos.y + area.h/2 < this.pos.y + this.h/2) {
          pos.y = this.pos.y + this.h;
        }
      }

      if (area.intersects(this.area)) {
        //Was on left or right
        //if (p.prevPos.x + p.w < this.pos.x + this.w) {
        if (prevPos.y + area.h > this.pos.y && prevPos.y < this.pos.y + this.h) {
          //Comming from left
          if (pos.x > prevPos.x) {
            pos.x = this.pos.x - area.w;
          }
          //Comming from right
          if (pos.x < prevPos.x) {
            pos.x = this.pos.x + this.w;
          }
        }

        //Was on top or bottom
        if (prevPos.x + area.w > this.pos.x && prevPos.x < this.pos.x + this.w) {
          //Comming from top
          if (pos.y > prevPos.y) {
            pos.y = this.pos.y - area.h;
          }
          //Comming from bottom
          if (pos.y < prevPos.y) {
            pos.y = this.pos.y + this.h;
          }
        }
      }
    }
  }
}
