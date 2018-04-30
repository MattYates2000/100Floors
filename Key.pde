class Key extends Item { 
  int ChooseGuard = int(random(0, Guards.size()));
  float x0;
  float x1;
  float x3;
  float y0;
  float y1;
  float y2;

  void display() {
    x0 = Guards.get(ChooseGuard).x;
    x1 = Guards.get(ChooseGuard).x - 50;
    x3 = Guards.get(ChooseGuard).x + 50;
    y0 = Guards.get(ChooseGuard).y - 50;
    y1 = Guards.get(ChooseGuard).y;
    y2 = Guards.get(ChooseGuard).y + 50;
    if (Guards.get(ChooseGuard).rotateGuard == 0 ) {
      ellipse(x0, y0, size, size);
      imageMode(CENTER);
      image(KeyIMG, x0, y0, size, size);
    } else if (Guards.get(ChooseGuard).rotateGuard == -PI/2) {
      ellipse(x1, y1, size, size);
      imageMode(CENTER);
      image(KeyIMG, x1, y1, size, size);
    } else if (Guards.get(ChooseGuard).rotateGuard == PI ) {
      ellipse(x0, y2, size, size);
      imageMode(CENTER);
      image(KeyIMG, x0, y2, size, size);
    } else if (Guards.get(ChooseGuard).rotateGuard == PI/2 ) {
      ellipse(x3, y1, size, size);
      imageMode(CENTER);
      image(KeyIMG, x3, y1, size, size);
    }
  }
}