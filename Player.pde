public class Player extends Entity{
  float MoveRight;
  float MoveDown;
  float MoveLeft;
  float MoveUp;
  float XradPos;
  float YradPos; 
  float XradNeg;
  float YradNeg;
  float DPGx;
  float DPGx2;
  float DPGy;
  float DPGy2;
  float DPI;
  float DPK;
  float Speed;
  float BaseSpeed = 1.5;
  int SpeedBoost = 3;
  float rotatePlayer;
  int TimeBoostUsedFor;
  boolean HasBoost = true;
  int WhenBoostUsed;


  Player() {
    x = 120;
    y = random(120, 600);
    Speed = BaseSpeed;
  }

  void movement(int player) {
    
    XradPos = this.x + size/2;
    XradNeg = this.x - size/2;
    YradPos = this.y + size/2;
    YradNeg = this.y - size/2;
    if (((player == 0) && (key == 'S' | key == 's')) || ((player == 1) && (keyCode == DOWN))) {
      if (YradPos > height-100) {
        MoveDown = -Speed;
      } else { 
        MoveDown = Speed;
      }
    } else if (((player == 0) && (key == 'A' | key == 'a')) || ((player == 1) && (keyCode == LEFT))) {
      if (XradNeg < 100) {
        MoveLeft = -Speed;
      } else {
        MoveLeft = Speed;
      }
    } else if (((player == 0) && (key == 'D' | key == 'd'))  || ((player == 1) && (keyCode == RIGHT))) {
      if (XradPos > width-50) {
        MoveRight = -Speed;
      } else {
        MoveRight = Speed;
      }
    } else if (((player == 0) && (key == 'W'| key == 'w')) || ((player == 1) && (keyCode == UP))) {
      if (YradNeg < 100) {
        MoveUp = -Speed;
      } else {
        MoveUp = Speed;
      }
    }
    if ((MoveUp == MoveRight) || (MoveUp == MoveLeft) || (MoveDown == MoveRight) || (MoveDown == MoveLeft))  {
      if (Speed == BaseSpeed) {
        Speed = sqrt(sq(BaseSpeed)/2);
      }
      if (Speed == SpeedBoost) {
        Speed = sqrt(sq(SpeedBoost)/2);
      }
    }
  }


  void nomovement(int player) {
    if (((player == 0) && (key == 'D' | key == 'd')) || ((player == 1) && (keyCode == RIGHT))) {
      MoveRight = 0;
    } else if (((player ==0) && (key == 'S' | key == 's')) || ((player == 1) && (keyCode == DOWN))) {
      MoveDown = 0;
    } else if (((player == 0) &&(key == 'A' | key == 'a')) || ((player == 1) && (keyCode == LEFT))) {
      MoveLeft = 0;
    } else if (((player == 0) && (key == 'W'| key == 'w')) || ((player == 1) && (keyCode == UP))) {
      MoveUp = 0;
    }
  }

  void display() {
    XradPos = this.x + size/2;
    XradNeg = this.x - size/2;
    YradPos = this.y + size/2;
    YradNeg = this.y - size/2;
    if (millis() > WhenBoostUsed + 1000) {
      Speed = BaseSpeed; 
    }    
    if (millis() > WhenBoostUsed + 5000) {
      BoostBar.fillBar();
      HasBoost = true;
    }
    fill(256, 0, 0);
    x += (MoveRight-MoveLeft)*Speed;
    y += (MoveDown-MoveUp)*Speed;
    imageMode(CENTER);
    ellipse(x, y, size, size);
    pushMatrix();
    translate(x, y);
    rotate(rotatePlayer);
    image(PlayerIMG, 0, 0, size+40, size+40);
    popMatrix();
  }

  void PlayerCheckGuard() {
    for (int i = 0; i < Guards.size(); i++) {
      DPGx = abs(this.x - Guards.get(i).x); 
      DPGx2 = this.x - Guards.get(i).x;
      DPGy = this.y - Guards.get(i).y; 
      DPGy2 = abs(this.y - Guards.get(i).y);
      if (Guards.get(i).rotateGuard == 0) {
        DPK = dist(this.x, this.y, K.x0, K.y0);
        if ((DPGx < 50)  && (DPGy < 50) && (DPGy > 0)) {
          GameOver.play();
          Game = 4;
        }
      } else if (Guards.get(i).rotateGuard == -PI/2) {
        DPK = dist(this.x, this.y, K.x1, K.y1);
        if ((DPGx2 < 50 ) && (DPGx2 > 0 ) && (DPGy2 < 50)) {
          GameOver.play();
          Game = 4;
        }
      } else if (Guards.get(i).rotateGuard == PI ) {
        DPK = dist(this.x, this.y, K.x0, K.y2);
        if ((DPGx < 50 ) && (DPGy > -50) && (DPGy < 0 )) {
          GameOver.play();
          Game = 4;
        }
      } else if (Guards.get(i).rotateGuard == PI/2) {
        DPK = dist(this.x, this.y, K.x3, K.y1);
        if ((DPGx2 > -50) && (DPGx2 < 0) && (DPGy2 < 50)) {
          GameOver.play();
          Game = 4;
        }
      }
    }

  }

  void PlayerCheckItems() {
    if (Items.size() == 0) {
      if (DPK < size+15) {
        fill(0);
        GotKey = true;
      }
    }

    for (int i = 0; i < Items.size (); i ++) {
      DPI = dist(this.x, this.y, Items.get(i).x, Items.get(i).y);
      if (DPI < size) {
        if (Items.get(i).Rarity == 1) {
          TotalCommon += 1;
          CommonNO += 1;
          TotalPlayerScore += 10;
        } else if (Items.get(i).Rarity == 2) {
          TotalUncommon += 1;
          UncommonNO += 1;
          TotalPlayerScore += 20;
        } else if (Items.get(i).Rarity == 3) {
          TotalRare += 1; 
          UncommonNO += 1;
          TotalPlayerScore += 50;
        }
        Items.remove(i);
      }
    }
  }

  public void Boost() { 
    if (!HasBoost) return;
    WhenBoostUsed = millis();
    for(int w = 0; w < Walls.size(); w ++) {
      Walls.get(w).Goback = 5;
    }
    BoostBar.drainBar();
    Speed = SpeedBoost;
    HasBoost = false;
  }
}

 