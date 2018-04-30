public class Guard extends Entity {
  float XradPos;
  float YradPos; 
  float XradNeg;
  float YradNeg;
  float DG;
  int Start;
  int Move; 
  float Speed;
  int Change;
  int Time = millis();
  float D;
  boolean Collided;
  float rotateGuard;

  Guard() {
    Collided = false;
    for (int p = 0; p < Players.size(); p++) {
      x = random(Players.get(p).x+500, width-120); 
    }
    y = random(100, height-120);
    Move = int(random(-0.5,3.5));
    Change = int(random(0, 200));
    Speed = random(1,2.5); 
  }

  void movement() { 
    //FootSteps.play();
    if (millis() > Time + 500) {
      Collided = false;
      Time = millis();
    }
    if (Change == 50) {
      Move = int(random(-0.5,3.5));
      print(Move);
    }
    if (Move== 2) {
      rotateGuard = 0;
      y = y + Speed;      
      if (this.y + size/2 >= height-100) {
        Move= int(random(-0.5,3.5));
      }
    } else if (Move== 0) {
      rotateGuard = PI;
      y = y - Speed;
      if (this.y - size/2 <= 100) {
        Move= int(random(-0.5,3.5));
      }
    } else if (Move== 3) {
      rotateGuard = -PI/2;
      x = x + Speed;
      if (this.x + size/2 >= width-100) {
        Move= int(random(-0.5,3.5));
      }
    } else if (Move== 1) {
      rotateGuard = PI/2;
      x = x - Speed;

      if (this.x - size/2 <= 100) {
        Move= int(random(-0.5, 3.5));
      }
    }
    GuardCheckGuard();
    Change = int(random(0, 200));
  }

  void display() {
    XradPos = this.x + size/2;
    XradNeg = this.x - size/2;
    YradPos = this.y + size/2;
    YradNeg = this.y - size/2;
    fill(0);
    ellipse(x, y, size, size);
    imageMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(rotateGuard);
    image(GuardIMG, 0, 0, size+40, size+40);
    popMatrix();
  }

  void GuardCheckGuard() {
    Start = 0;
    for (int i = 0; i < Guards.size (); i ++) {
      Start = Start + 1;
      for (int j = Start; j < Guards.size (); j++) {
        DG = dist(Guards.get(i).x, Guards.get(i).y, Guards.get(j).x, Guards.get(j).y);
        if (DG < size+100) { 
          if (Collided == false) { 
            Guards.get(i).Move = int(random(0, 3));
            Collided = true;
          }
        }
      }
    }
  }
}