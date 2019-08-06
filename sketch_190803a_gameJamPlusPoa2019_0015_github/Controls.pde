void mousePressed() {
  if(game.playing) {
    b.create(p.pos.x, p.pos.y + p.h/2);
  }
}

void mouseReleased() {
  mouseReleased = true;
}
