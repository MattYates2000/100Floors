class GSensor {
  float Start;
  float Stop;
  float Length;
  boolean Changed;

  GSensor() {
    Start = random(0, PI*2);
    Stop = Start + PI/2;
    Length = 100;
    Changed = false;
  }
  void display() { 
    fill(255, 255, 100);
    arc(GuardX, GuardY, Length, Length, Start, Stop);
  }


  void movement() {

    for (int i = 0; i < Guards.size(); i ++) {

      if (Guards.get(i).Move == 2) {
        GSensors.get(i).Start = PI/4;
        GSensors.get(i).Stop = PI*3/4;
      }

      if (Guards.get(i).Move == 3) {
        GSensors.get(i).Start = 2*PI - PI/4;
        GSensors.get(i).Stop = 2*PI + PI/4;
      }

      if (Guards.get(i).Move == 0) { 
        GSensors.get(i).Start = PI + PI/4;
        GSensors.get(i).Stop = 2*PI - PI/4;
      }

      if (Guards.get(i).Move == 1) {
        GSensors.get(i).Start = PI - PI/4;
        GSensors.get(i).Stop = PI + PI/4;
      }

      if ((Guards.size() != 0)) {
        GSensors.get(i).Start = GSensors.get(i).Start - PI/1000;
        GSensors.get(i).Stop = GSensors.get(i).Stop - PI/1000;
      }
    }
  }
}