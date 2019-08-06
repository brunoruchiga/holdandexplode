class Enemy {
  PVector pos;
  PVector vel;
  PVector prevPos;
  float w, h;
  Rectangle area;
  int animationState = 0;
  float maxVel;
  boolean active;

  Enemy(float x, float y) {
    w = em*1.5;
    h = 2*em*1.5;
    pos = new PVector(x - w/2, y - h/2);
    prevPos = new PVector(pos.x, pos.y);
    area = new Rectangle(pos.x, pos.y, w, h);
    maxVel = 0.06*em;
    vel = new PVector(0, maxVel);
    active = true;
  }

  void update() {
    prevPos.set(pos);
    move();
    area.update(pos.x, pos.y, w, h);
  }

  void reset() {
    pos.set(p.pos.x + random(-playArea.w, 2*playArea.w), deathWallY - em);
  }

  void move() {
    vel.rotate(random(-TWO_PI/180, TWO_PI/180));
    pos.add(vel);
  }

  void display() {
    if (isVisibleInsideScreen(pos.x, pos.y)) {
      if (time.realFrameCount % 30 > 15) {
        animationState = 0;
      } else {
        animationState = 1;
      }
      if (active) {
        pushMatrix(); 
        {
          translate(pos.x + em/4, pos.y + 1.5*em);
          noStroke();
          fill(32, 128, 0); //verde
          if (animationState == 0) {
            //pessoinha
            rect(em/2 - em*0.5/2, -em, em*0.5, 0.5*em); //cabeça
            rect(0, 0.6*em - em, em, em - 0.3*em); //corpo
            rect(0.2*em, 0.6*em - em, em - 0.4*em, 2*em - 0.6*em); //pernas
          } else {
            float offsetAmount = 0.1*em;
            rect(em/2 - em*0.5/2, -em + offsetAmount, em*0.5, 0.5*em); //cabeça
            rect(0, 0.6*em - em + offsetAmount, em, em - 0.3*em); //corpo
            rect(0.2*em, 0.6*em - em + offsetAmount, em - 0.4*em, 2*em - 0.6*em - offsetAmount); //pernas
          }
        }
        popMatrix();
      }
    }
  }

  void debug() {
    pushMatrix(); 
    {
      translate(area.x, area.y);
      stroke(255, 0, 0);
      strokeWeight(1);
      noFill();
      rect(0, 0, area.w, area.h);
    }
    popMatrix();
  }
}
