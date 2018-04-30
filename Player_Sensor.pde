class Sensor {
  float Start;
  float Stop;
  float Length;

  Sensor() {
    Start = 2*PI - PI/4;
    Stop = 2*PI + PI/4;
    Length = 100;
  }

  void display(int player) { 
    if (player == 0) {
      fill(0, 256, 0);   
    }
    if (player == 1) {
      fill(0,0,256);
    }
    if (player == 3) {
      fill(256,0,0);
    }
    arc(PlayerX,PlayerY, Length, 100, Start, Stop);
  }

  void movement() {
     for (int p = 0; p < Players.size(); p++) {
      if (Players.get(p).MoveDown == Players.get(p).Speed) {
        if (Players.get(p).MoveRight == Players.get(p).Speed) {
          Sensors.get(p).Start = 0;
          Sensors.get(p).Stop = PI/2;
          Players.get(p).rotatePlayer = -PI/4;
        } else if (Players.get(p).MoveLeft == Players.get(p).Speed) {
          Sensors.get(p).Start = PI/2;
          Sensors.get(p).Stop = PI;
          Players.get(p).rotatePlayer = PI/4;
        } else {
          Sensors.get(p).Start = PI/4;
          Sensors.get(p).Stop = PI*3/4;
          Players.get(p).rotatePlayer = 0;
        }
      } else if (Players.get(p).MoveUp == Players.get(p).Speed) {   
        if (Players.get(p).MoveRight == Players.get(p).Speed) {
          Sensors.get(p).Start = -PI/2;
          Sensors.get(p).Stop = 0;
          Players.get(p).rotatePlayer = PI+PI/4;
        } else if (Players.get(p).MoveLeft == Players.get(p).Speed) {
          Sensors.get(p).Start = PI;
          Sensors.get(p).Stop = 2*PI - PI/2;
          Players.get(p).rotatePlayer = PI-PI/4;
        } else {
          Sensors.get(p).Start = PI + PI/4;
          Sensors.get(p).Stop = 2*PI - PI/4;
          Players.get(p).rotatePlayer = PI;
        }
      } else if (Players.get(p).MoveRight == Players.get(p).Speed) {
        Sensors.get(p).Start = 2*PI - PI/4;
        Sensors.get(p).Stop = 2*PI + PI/4;
        Players.get(p).rotatePlayer = -PI/2;
      } else if (Players.get(p).MoveLeft == Players.get(p).Speed) {
        Sensors.get(p).Start = PI - PI/4;
        Sensors.get(p).Stop = PI + PI/4;
        Players.get(p).rotatePlayer = PI/2;
      }

      //if (key == '>') {
      //  Sensors.get(p).Start = Sensors.get(p).Start + PI/25;
      //  Sensors.get(p).Stop = Sensors.get(p).Stop + PI/25;
      //} 
      //else if (key == '<') {
      //  Sensors.get(p).Start = Sensors.get(p).Start - PI/25;
      //  Sensors.get(p).Stop = Sensors.get(p).Stop - PI/25;
      //}
    }
  }
}