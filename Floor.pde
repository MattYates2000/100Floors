class Floor { 
  float FloorY = 100; 
  float FloorX = 100;
  int FloorType = int(random(0.5,2.5));
  int FloorSize = int(random(50, 100));
  int FloorSize2 = int(random(50, 100));
  float TotalFloor;

  public void display() {
    if (FloorType == 1) {
      for (int f = 0; f < 800; f += 50) {
        for (int g = 50; g < 550; g += 50) {
          if (g%100 == 0) {
            if (f%100 == 0) {
              fill(0);
            } else {
              fill(255);
            }
          } else {
            if (f%100 == 0) {
              fill(255);
            } else {
              fill(0);
            }
          }
          rect(FloorX+f, FloorY, 50, 50);
          rect(FloorX+f, FloorY+g, 50, 50);
        }
      }
    }
    if ((FloorType == 2)) {
      for (int f = 100; f < 900; f += FloorSize) {
        for (int g = 0; g < 550; g += 40) {
          if ((f+(FloorSize*2))+50 > 900) {
            if ((f + FloorSize + 50 < 900)) {
              rect(f+FloorSize+50, FloorY+g, 900-(f+FloorSize+50), 20);
            }
          } else {
            fill(204, 102, 0);
            rect(f, FloorY+g, FloorSize, 20);
            rect(f+FloorSize+50, FloorY+g, FloorSize, 20);
          }
        }
      }
      for (int f = 100; f < 900; f += FloorSize2) {
        for (int g = 20; g < 550; g += 40) {
          if ((f+(FloorSize2*2))+50 > 900) {
            if ((f + FloorSize2 + 50 < 900)) {
              rect(f+FloorSize2+50, FloorY+g, 900-(f+FloorSize2+50), 20);
            }
          } else {
            fill(204, 102, 0);
            rect(f, FloorY+g, FloorSize2, 20);
            rect(f+FloorSize2+50, FloorY+g, FloorSize2, 20);
          }
        }
      }
    }
    if ((FloorType == 3)) {
      fill(0);
      rect(100,100,width-200,height-200);
    }
  }
}