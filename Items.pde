class Item extends Entity{  
  float DI;
  int Start;
  int Chance;
  int Rarity;

  Item() {
    Chance = int(random(0,100)); 
    for (int p = 0; p < Players.size(); p++) {
      x = random(Players.get(p).x + 100, width-120); 
    }
    y = random(120, height-120);
  }

  void display() {
    if (Chance < 80) { 
      Rarity = 1;
      fill(0,256,0);
    }    
    else if ((Chance >= 80) && (Chance <= 97)) {
      Rarity = 2; 
      fill(0,0,256);
    }
    else if (Chance >= 98) {
      Rarity = 3; 
      fill(256,0,0);
    }
    ellipse(x, y, size, size);
  }
  
  void randomPos() {
    for (int p = 0; p < Players.size(); p++) {
      x = random(Players.get(p).x + 100, width-120); 
    }
    
    y = random(120, height-120);
  }

  void SameCell() {
    Start = 0;
    for (int i = 0; i < Items.size(); i ++) {
      Start = Start + 1;
      for (int j = Start; j < Items.size (); j++) {
        DI = dist(Items.get(i).x, Items.get(i).y, Items.get(j).x, Items.get(j).y);
        if (DI < size+150) { 
          if (object == "Item") {
            Items.remove(j);
          }
          else {
            Items.get(j).randomPos();
          }
        }
      }
    }
  }
}