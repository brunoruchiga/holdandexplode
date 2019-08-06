class Path {
  Vertex[] vertexes = new Vertex[100];
  boolean active = false;

  Path() {
    for (int i = 0; i < vertexes.length; i++) {
      vertexes[i] = new Vertex();
    }
  }

  void reset() {
    active = false;
    for (int i = 0; i < vertexes.length; i++) {
      vertexes[i].x = 0;
      vertexes[i].y = 0;
      vertexes[i].valid = false;
    }
  }

  void addVertex(float _x, float _y) {
    
    active = true;

    int x = round(_x / em);
    int y = round(_y / em);

  searchValidSpot:
    for (int i = 0; i < vertexes.length; i++) {
      if (!vertexes[i].valid) { //if has empty spot        
        for (int j = 0; j < vertexes.length; j++) {
          if (vertexes[j].valid && x == vertexes[j].x && y == vertexes[j].y) { //if this valid j is equal to (x, y)
            break searchValidSpot;
          }
        }
        vertexes[i].valid = true; 
        vertexes[i].x = x;
        vertexes[i].y = y;

        break searchValidSpot;
      }
    }
  }

  void display() {
    if (active && explosionAnimationTimer > 0  && explosionAnimationTimer < 1*60) {
      stroke(128, 0, 0);
      strokeWeight(0.1*em);
      noFill();
      beginShape();
      vertex(b.pos.x + b.size/2, b.pos.y + b.size);
      for (int i = 0; i < vertexes.length; i++) {
        if (vertexes[i].valid) {
          vertex(vertexes[i].x*em, vertexes[i].y*em);
        }
      }
      vertex(p.pos.x + p.w/2 - em, p.pos.y + p.h);
      endShape();
    }
  }
}

class Vertex {
  int x, y;
  boolean valid;

  Vertex() {
    int x = 0;
    int y = 0;
    valid = false;
  }
}
