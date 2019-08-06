class Canvas {
  float x, y, w, h;

  Canvas(float ratio) {
    if (height*ratio>width) { //se tela é vertical
      w = width;
      h = w/ratio;

      x = 0;
      y = height/2 - h/2;
    } else { //se tela é horizontal
      h = height;
      w = h*ratio;

      y = 0;
      x = width/2 - w/2;
    }
  }

  void debug() {
    noFill();
    stroke(255, 255, 0);
    strokeWeight(1);

    rect(x, y, w-1, h-1);
  }

  void grid() {
    for (int i = 0; i <= floor(w/em); i++) {
      for (int j = 0; j <= floor(h/em); j++) {
        stroke(200);
        noFill();
        rect(i*em, j*em, em, em);

        fill(0);
        textFont(font);
        textSize(em/5);
        textAlign(LEFT, TOP);
        text("(" + i + "," + j + ")", i*em, j*em);
      }
    }
  }

  void begin() {
    translate(x, y);
  }

  void end() {
    translate(-x, -y);
  }
}

class PlayArea {
  float x, y, w, h;

  PlayArea(float ratio, float margin) {
    if (canvas.h*ratio>canvas.w) { //se tela é vertical
      w = canvas.w - 2*margin;
      h = w/ratio;

      x = 0 + margin;
      y = canvas.h/2 - h/2;
    } else { //se tela é horizontal
      h = canvas.h - 2*margin;
      w = h*ratio;

      y = 0 + margin;
      x = canvas.w/2 - w/2;
    }
  }

  PlayArea(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }

  void begin() {
    translate(x, y);
  }

  void end() {
    translate(-x, -y);
  }

  void debug() {
    noFill();
    stroke(255, 255, 0);
    strokeWeight(1);

    rect(x, y, w-1, h-1);
  }
}

class Camera {
  PVector pos;
  PVector targetPos;

  Camera(float x, float y) {
    pos = new PVector(x, y);
    targetPos = new PVector(x, y);
  }

  void update() {
    if (b.exploded) {
      targetPos.set(playArea.w/2-p.pos.x, -deathWallY + 2*em);//playArea.h/2-p.pos.y);
      pos.lerp(targetPos, 0.1);
    } else {
      targetPos.set(playArea.w/2-((p.pos.x+b.pos.x)/2), -deathWallY + 2*em);//playArea.h/2-((p.pos.y+b.pos.y)/2));
      pos.lerp(targetPos, 0.1);
    }
  }

  void begin() {
    pushMatrix();
    translate(pos.x, pos.y);
  }
  
  void end() {
    popMatrix();
  }
}

boolean isVisibleInsideScreen (float x, float y) {
  float screenInitialX = 0 - camera.pos.x - playArea.x - canvas.x;
  float screenInitialY = 0 - camera.pos.y - playArea.y - canvas.y;
  float screenFinalX = screenInitialX+width;
  float screenFinalY = screenInitialY+height;
  float buffer = 5*em;
  
  //debug
  //stroke(255, 0, 255);
  //line(screenInitialX, screenInitialY, screenFinalX, screenFinalY);
  
  return (x > screenInitialX - buffer &&
          x < screenFinalX   + buffer &&
          y > screenInitialY - buffer &&
          y < screenFinalY   + buffer );
}
