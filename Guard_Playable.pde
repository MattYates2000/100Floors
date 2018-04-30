class PlayableGuard extends Guard { 
    
    float MoveRight;
    float MoveDown;
    float MoveLeft;
    float MoveUp;
  
  PlayableGuard() {
    x = 500;
    y = random(120, 600);
    Speed = 1.25;
  }
  
    void movement() {
    if (keyCode == DOWN) {
      if (this.y + size/2 >= height-100) {
        MoveDown = 0;
      } else { 
          MoveDown = Speed;
          rotateGuard = 0;
      }
    } if (keyCode == LEFT)  {
        if (this.x - size/2 <= 100) {
          MoveLeft = -Speed;
        } else {
          MoveLeft = Speed;
          rotateGuard = PI/2;
        } 
    } if (keyCode == RIGHT) {
        if (this.x + size/2 >= width-100) {
          MoveRight = -Speed;
        } else {
        MoveRight = Speed;
        rotateGuard = -PI/2;
        }
    } if (keyCode == UP) { 
        if (this.y - size/2 <= 100) {
          MoveUp -= Speed;
          }else {         
            MoveUp = Speed;
            rotateGuard = PI;
          }
        }

  }

  void nomovement() {
    if (keyCode == RIGHT) {
      MoveRight = 0;
    } else if (keyCode == DOWN) {
       MoveDown = 0;
    } else if (keyCode == LEFT) {
      MoveLeft = 0;
    } else if (keyCode == UP) {
      MoveUp = 0;
    }
  }

  void display() {
    x += (MoveRight-MoveLeft)*Speed;
    y += (MoveDown-MoveUp)*Speed;
    ellipse(x, y, size, size);
    imageMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(rotateGuard);
    image(GuardIMG, 0, 0, size+40, size+40);
    popMatrix();
  }
}
  