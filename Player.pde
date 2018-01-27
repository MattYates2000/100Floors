public class Player {
  float x;
  float y;
  float MoveRight;
  float MoveDown;
  float MoveLeft;
  float MoveUp;
  float size; 
  float DPGx;
  float DPGx2;
  float DPGy;
  float DPGy2;
  float DPI;
  float DPK;
  float Speed;
  float rotatePlayer;


  Player() {
    x = 120;
    y = random(120, 600);
    size = 20;
    Speed = 1.5;
  }

  void moving(int player) {
    print(Speed);
    if (((player == 0) && (key == 'S' | key == 's')) || ((player == 1) && (keyCode == DOWN))) {
      if (this.y + size/2 > height-100) {
        MoveDown = 0;
      } else { 
        MoveDown = Speed;
      }
    } else if (((player == 0) && (key == 'A' | key == 'a')) || ((player == 1) && (keyCode == LEFT))) {
      if (this.x - size/2 < 100) {
        MoveLeft = 0;
      } else {
        MoveLeft = Speed;
      }
    } else if (((player == 0) && (key == 'D' | key == 'd'))  || ((player == 1) && (keyCode == RIGHT))) {
      if (this.x + size/2 > width-100) {
        MoveRight = Speed;
      } else {
        MoveRight = Speed;
      }
    } else if (((player == 0) && (key == 'W'| key == 'w')) || ((player == 1) && (keyCode == UP))) {
      if (this.y - size/2 < 100) {
        MoveUp = 0;
      } else {
        MoveUp = Speed;
      }
    }
  }

  void notmoving(int player) {
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
    fill(256, 0, 0);
    x += (MoveRight-MoveLeft)*Speed;
    y += (MoveDown-MoveUp)*Speed;
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
      if (Guards.get(i).D == 0) {
        DPK = dist(this.x, this.y, K.x0, K.y0);
        if ((DPGx < 50)  && (DPGy < 50) && (DPGy > 0)) {
          GameOver.play();
          GameOver();
        }
      } else if (Guards.get(i).D == 1) {
        DPK = dist(this.x, this.y, K.x1, K.y1);
        if ((DPGx2 < 50 ) && (DPGx2 > 0 ) && (DPGy2 < 50)) {
          GameOver.play();
          Game = 4;
        }
      } else if (Guards.get(i).D == 2 ) {
        DPK = dist(this.x, this.y, K.x0, K.y2);
        if ((DPGx < 50 ) && (DPGy > -50) && (DPGy < 0 )) {
          GameOver.play();
          Game = 4;
        }
      } else if (Guards.get(i).D == 3) {
        DPK = dist(this.x, this.y, K.x3, K.y1);
        if ((DPGx2 > -50) && (DPGx2 < 0) && (DPGy2 < 50)) {
          GameOver.play();
          Game = 4;
        }
      }
    }
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
}