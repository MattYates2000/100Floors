public class Wall {
  float x;
  float x2;
  float y;
  float y2;
  float sizex; 
  float sizey; 
  float DW;
  int Goback = 3;
  int ID;

  Wall(int _ID) {
    ID = _ID;
    sizex = 150;
    sizey = 200;
    x = random(120, width-300); 
    y = random(120,height-sizey);
    y2 = y + sizey;
    x2 = x + sizex;
    Goback = 1;
  }

  public void display() {
    fill(160, 82, 45);
    rect(x, y, sizex, sizey);
  }

  public void WallCheckWall() {
    print(Walls.size());
        for (int j = 0; j < Walls.size(); j++) {
          if (CheckBoundaryWall(j)) {
            if (object == "Wall") { 
              Walls.remove(Walls.size()-1);
            }
            else {
              randomPos();
            }
          }
        }
      }
  public void randomPos() {
    x = random(120, width-300); 
    y = random(0,height-sizey);
    y2 = y + sizey;
    x2 = x + sizex;
  }

  void WallCheckPlayer() {
    for (int p = 0; p < Players.size(); p++) {
      for (int w = 0; w < Walls.size(); w ++) {
        if (CheckBoundaryPlayer(w,p)) {
          print(Walls.get(w).y);
          print(Players.get(p).y);
          if (Players.get(p).x < Walls.get(w).x) {
            Players.get(p).x -= Goback;
          }
          if (Players.get(p).x > Walls.get(w).x2) {
            Players.get(p).x += Goback;
          }
          if(Players.get(p).y > Walls.get(w).y2) {
            Players.get(p).y += Goback;
          }
          if(Players.get(p).y < Walls.get(w).y) {
            Players.get(p).y -= Goback;
          }
        }
      }
    }
  }

  void WallCheckGuards() { 
    for (int w = 0; w < Walls.size (); w ++) {
      for (int k = 0; k < Guards.size (); k++) {
        if (CheckBoundaryGuard(w, k)) {

          if (Guards.get(k).x < Walls.get(w).x) {
            Guards.get(k).x -= 10; 
            Guards.get(k).Move= int(random(0, 3));
          }

          if (Guards.get(k).x > Walls.get(w).x2) {
            Guards.get(k).x += 10; 
            Guards.get(k).Move= int(random(0, 3));
          }

          if ((Guards.get(k).x > Walls.get(w).x) && (Guards.get(k).x < Walls.get(w).x2)) {
            Guards.get(k).y += 10; 
            Guards.get(k).Move= int(random(0, 3));
          }
        }
      }
    }
  }

  void WallCheckItems() {
    for (int w = 0; w < Walls.size(); w ++) {
      for (int i = 0; i < Items.size(); i++) {
        if (CheckBoundaryItem(w, i)) {
          Items.get(i).randomPos();
        }
      }
    }
  } 

  private boolean CheckBoundaryPlayer(int w,int p) {
      if ((Walls.get(w).x < Players.get(p).XradPos) && (Walls.get(w).x2 > Players.get(p).XradNeg) && (Walls.get(w).y < Players.get(p).YradPos) && (Walls.get(w).y2 > Players.get(p).YradNeg)) {
        return true;
    }
    return false;
  }

  private boolean CheckBoundaryGuard(int w, int k) {
    if ((Walls.get(w).x < Guards.get(k).XradPos) && (Walls.get(w).x2 > Guards.get(k).XradNeg) && (Walls.get(w).y < Guards.get(k).YradPos) && (Walls.get(w).y2 > Guards.get(k).YradNeg)) {
      return true;
    }
    return false;
  }

  private boolean CheckBoundaryItem(int w, int i) {
    if ((Walls.get(w).x < (Items.get(i).x+(Items.get(i).size/2))) && (Walls.get(w).x2 > (Items.get(i).x-(Items.get(i).size/2))) && (Walls.get(w).y < (Items.get(i).y+(Items.get(i).size/2))) && (Walls.get(w).y2 > (Items.get(i).y - (Items.get(i).size/2)))) {
      return true;
    }
    return false;
  }
  private boolean CheckBoundaryWall(int j) { 
     if ((x > Walls.get(j).x) && (x < Walls.get(j).x2)) {
       if ((y2 < Walls.get(j).y2) && (y2 > Walls.get(j).y)) {
         return true;
       }
      else if ((y < Walls.get(j).y2) && (y > Walls.get(j).y)) {
        return true;
      }
     } else if ((x2 > Walls.get(j).x) && (x2 < Walls.get(j).x2)) {
        if ((y2 < Walls.get(j).y2) && (y2 > Walls.get(j).y)) {
          return true;
     } else if ((y < Walls.get(j).y2) && (y > Walls.get(j).y)) {
       return true;
     }
     }
    //  } if (Walls.get(i).x - Walls.get(j).x2 < 50) {
    //    return true;
    //  }
     return false;
  }
}