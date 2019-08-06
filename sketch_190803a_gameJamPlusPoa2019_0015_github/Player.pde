class Player {
  PVector pos;
  PVector prevPos;
  float w, h;
  Rectangle area;
  float velScale;
  int animationState = 0;

  Player(float x, float y) {
    w = em;
    h = em;
    pos = new PVector(x - w/2, y - h/2);
    prevPos = new PVector(pos.x, pos.y);
    area = new Rectangle(pos.x, pos.y, w, h);
    velScale = 0.75;
  }

  void update() {
    if (game.gameOver == 0) {
      prevPos.set(pos);
      if (mousePressed) {
        pos.add((mouseX-pmouseX)*velScale, (mouseY-pmouseY)*velScale);
      }
      area.update(pos);

      if (explosionAnimationTimer < 0.95*60 && explosionAnimationTimer > 0.75*60) {
        animationState = 1;
      } else {
        animationState = 0;
      }
    }
    
    
    if(pos.y > deathWallY + playArea.h) {
      pos.y = deathWallY + playArea.h;
    }
  }

  void display() {
    pushMatrix(); 
    {
      translate(pos.x, pos.y);

      if (animationState == 0) {
        //pessoinha
        noStroke();
        fill(56);
        rect(em/2 - em*0.5/2, -em, em*0.5, 0.5*em); //cabeça
        rect(0, 0.6*em - em, em, em - 0.3*em); //corpo
        rect(0.2*em, 0.6*em - em, em - 0.4*em, 2*em - 0.6*em); //pernas
      } else {
        float offsetAmount = 0.3*em;
        noStroke();
        fill(56);
        rect(em/2 - em*0.5/2, -em + offsetAmount, em*0.5, 0.5*em); //cabeça
        rect(0, 0.6*em - em + offsetAmount, em, em - 0.3*em); //corpo
        rect(0.2*em, 0.6*em - em + offsetAmount, em - 0.4*em, 2*em - 0.6*em - offsetAmount); //pernas
      }

      //detonador
      if (b.visible) {
        if (animationState == 0) {
          noStroke();
          fill(200, 0, 0);
          rect(-w, h - 0.7*em, 0.8*em, 0.7*em); //caixa
          rect(-w + 0.5*em - 0.15*em, h - 1.2*em, 0.1*em, em); //barra do meio
          rect(-w, h - 0.7*em - 0.6*em, 0.8*w, 0.2*w); //barra
        } else if (animationState == 1) {
          noStroke();
          fill(200, 0, 0);
          rect(-w, h - 0.7*em, 0.8*em, 0.7*em); //caixa
          rect(-w + 0.5*em - 0.15*em, h - 1.2*em + 0.3*em, 0.1*em, em - 0.3*em); //barra do meio
          rect(-w, h - 0.7*em - 0.6*em + 0.3*em, 0.8*w, 0.2*w); //barra
        }
      }
    }
    popMatrix();
  }

  void debug() {
    pushMatrix(); 
    {
      translate(pos.x, pos.y);
      stroke(0, 0, 255);
      noFill();
      rect(0, 0, w, h);
    }
    popMatrix();
  }
}
