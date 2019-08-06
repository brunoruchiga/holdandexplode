class Bomb {
  PVector pos;
  float size;
  boolean visible = false;
  boolean exploded = false;
  boolean explosionActive = false;
  Rectangle explosionArea;
  float power, maxPower, initialPower;

  Bomb(PVector _pos, boolean _visible) {
    pos = new PVector(_pos.x, _pos.y);
    maxPower = 30;
    initialPower = 2;
    power = initialPower;
    size = em;
    visible = _visible;

    explosionArea = new Rectangle(pos.x + size/2 - size*power/2, pos.y + size/2 - size*power/2, size*power, size*power);
  }

  void update() {
    if (visible && !exploded) {
      power = power*1.028;
    }
    if (!exploded) {
      if (power > maxPower) {
        explode();
      }
    }
    explosionArea.update(pos.x + size/2 - size*power/2, pos.y + size/2 - size*power/2, size*power, size*power);
    if (explosionAnimationTimer < 0 && exploded) {
      visible = false;
    }
  }

  void display() {
    if (visible) {
      if (!exploded) {
        //TNT
        pushMatrix(); 
        {
          translate(pos.x, pos.y);
          
          noStroke();
          fill(200, 0, 0);
          rect(0, 0, size, size); //quadrado

          noStroke();
          fill(255);
          rect(0.2*size, 0.4*size, size-0.2*size-0.2*size, 0.2*size); //linha branca no meio
        }
        popMatrix();
      }

      //Explosion area
      pushMatrix(); 
      {
        translate(explosionArea.x, explosionArea.y);
        if (exploded) {
          if (explosionAnimationTimer > 0.9*60) {
            fill(255);
            stroke(255);
          } else if (explosionAnimationTimer > 0.8*60) {
            fill(255, 0, 0);
            stroke(255, 0, 0);
          } else if (explosionAnimationTimer > 0.7*60) {
            fill(255);
            stroke(255);
          } else if (explosionAnimationTimer > 0.6*60) {
            fill(255, 0, 0);
            stroke(255, 0, 0);
          } else {
            float alpha = map(explosionAnimationTimer, 0.6*60, 0, 128, 0);
            fill(128, alpha);
            stroke(128, alpha);
          }
        } else {
          noFill();
          stroke(255, 128);
        }
        rect(0, 0, explosionArea.w, explosionArea.h);
      }
      popMatrix();
    }
  }

  void create(float _x, float _y) {
    if (game.gameOver == 0) {
      power = initialPower;
      pos.set(_x, _y);
      explosionArea.update(pos.x + size/2 - explosionArea.w/2, pos.y + size/2 - explosionArea.h/2);
      visible = true;
      exploded = false;
    }
  }

  void explode() {
    exploded = true;
    explosionActive = true;
    explosionAnimationTimer = 1*60;
  }
}
