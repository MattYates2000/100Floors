class Door {
  float x;
  float y;
  float x2;
  float y2;
  float x3;
  float y3;
  float x4;
  float y4;

  void display() {
    if (GotKey == true) {
      fill(0);
    } else {
      fill(182, 155, 76);
    }
    image(Door,width-50,height/2,100,150);
  }

  void UnlockDoor() {
    for (int p = 0; p < Players.size(); p++) {
      if ((Players.get(p).x + Players.get(p).size > width-100) && (Players.get(p).y > 320) && (Players.get(p).y < 380)) {
        Level += 1;
        if (PlayerSlot == 1) {  
          User1.set(0, Level);
        } else if (PlayerSlot == 2) {
          User2.set(1, Level);
        } else if (PlayerSlot == 3) {
          User3.set(2, Level);
        }
        GuardNO += int(random(1, 3));
        ItemNO = int(random(1, 8));
        F.FloorType = int(random(0, 2));
        CommonNO = 0;
        UncommonNO = 0;
        RareNO = 0;
        Game = 2;
        Players.get(p).Speed = Players.get(p).BaseSpeed;
      }
    }
  }
}