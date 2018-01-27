public class Guard {
  public float x;
  public float y;
  float size; 
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
    size = 20;
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
      D = 0; 
      y = y + Speed;
      GuardCheckGuard();
      if (this.y + size/2 >= height-100) {
        Move= int(random(-0.5,3.5));
      }
    } else if (Move== 0) {
      D = 2;
      y = y - Speed;
      GuardCheckGuard();
      if (this.y - size/2 <= 100) {
        Move= int(random(-0.5,3.5));
      }
    } else if (Move== 3) {
      D = 1;
      x = x + Speed;
      GuardCheckGuard();
      if (this.x + size/2 >= width-100) {
        Move= int(random(-0.5,3.5));
      }
    } else if (Move== 1) {
      GuardCheckGuard();
      D = 3;
      x = x - Speed;

      if (this.x - size/2 <= 100) {
        Move= int(random(-0.5, 3.5));
      }
    }
    Change = int(random(0, 200));
  }

  void display() {
    fill(0);
    ellipse(x, y, size, size);
    imageMode(CENTER);
    image(GuardIMG, x, y, size+40, size+40);
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