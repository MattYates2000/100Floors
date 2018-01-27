class PlayableGuard extends Guard { 
  
  PlayableGuard() {
    Speed = 3;
  }
  
    void movement() {
    if (keyCode == DOWN) {
      if (this.y + size/2 >= height-100) {
        y += 0;
      } else { 
        y += Speed;
        rotateGuard = 0;
      }
    } else if (keyCode == LEFT)  {
      x -= Speed;
      rotateGuard = PI/2;
    } else if (keyCode == RIGHT) {
      x += Speed;
      rotateGuard = -PI/2;
    } else if (keyCode == UP) { 
      y -= Speed;
      rotateGuard = PI;
    }
    if (this.x - size/2 <= 100) {
      x -= 0;
    }
    if (this.y - size/2 <= 100) {
      y -= 0;
    }
    if (this.x + size/2 >= width-100) {
      x += 0;
    }
  }

  void notmoving() {
    if (keyCode == RIGHT) {
      x += 0;
    } else if (keyCode == DOWN) {
       y += 0;
    } else if (keyCode == LEFT) {
      x += 0;
    } else if (keyCode == UP) {
      y += 0;
    }
  }
}