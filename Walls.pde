class Wall {
  float x;
  float x2;
  float y;
  float y2;
  float sizex; 
  float sizey; 
  float DW;
  int Goback = 3;

  Wall() {
    x = random(120, width-300); 
    sizex = 180;
    sizey = 250;
    y = height - sizey;
    x2 = x + sizex;
    Goback = 3;
  }

  public void display() {
    fill(160, 82, 45);
    rect(x, 0, sizex, sizey);
  }

  public void WallCheckWall() {
    for (int p = 0; p < Players.size(); p++) {
      for (int i = 0; i < Walls.size (); i ++) {
        for (int j = 0; j < Walls.size (); j++) {
          if ((Walls.get(i).x > Walls.get(j).x) && (Walls.get(i).x < Walls.get(j).x2)) {
            print("Walls realigned");
            Walls.remove(i);
            Walls.add(new Wall());
          }
          if ((Walls.get(i).x2 > Walls.get(j).x) && (Walls.get(i).x2 < Walls.get(j).x2)) {
            Walls.remove(i);
            Walls.add(new Wall());
          }
        }
      }
    }
  }

  void WallCheckPlayer() {
    for (int p = 0; p < Players.size(); p++) {
      for (int w = 0; w < Walls.size (); w ++) {
        if (CheckBoundaryPlayer(w,p)) {
          if (Players.get(p).x < Walls.get(w).x) {
            Players.get(p).x = Players.get(p).x - Goback;
          }
          if (Players.get(p).x > Walls.get(w).x2) {
            Players.get(p).x = Players.get(p).x + Goback;
          }
          if ((Players.get(p).x > Walls.get(w).x) && (Players.get(p).x < Walls.get(w).x2)) {
            Players.get(p).y = Players.get(p).y + Goback;
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
    for (int w = 0; w < Walls.size (); w ++) {
      for (int k = 0; k < Items.size (); k++) {
        if (CheckBoundaryItem(w, k)) {
          Items.remove(k);
          Items.add(new Item());
        }
      }
    }
  } 

  private boolean CheckBoundaryPlayer(int w,int p) {
      if (((Walls.get(w).x < Players.get(p).x+(Players.get(p).size/2))) && ((Walls.get(w).x2 > Players.get(p).x-(Players.get(p).size/2)) && (Walls.get(w).sizey > Players.get(p).y-(Players.get(p).size/2)))) {
        return true;
    }
    return false;
  }

  private boolean CheckBoundaryGuard(int w, int k) {
    if (((Walls.get(w).x < Guards.get(k).x+(Guards.get(k).size/2))) && ((Walls.get(w).x2 > Guards.get(k).x-(Guards.get(k).size/2)) && (Walls.get(w).sizey - 1 > Guards.get(k).y-(Guards.get(k).size/2)))) {
      return true;
    }
    return false;
  }

  private boolean CheckBoundaryItem(int w, int k) {
    if (((Walls.get(w).x < Items.get(k).x+(Items.get(k).size/2))) && ((Walls.get(w).x2 > Items.get(k).x-(Items.get(k).size/2)) && (Walls.get(w).sizey - 1 > Items.get(k).y-(Items.get(k).size/2)))) {
      return true;
    }
    return false;
  }
}