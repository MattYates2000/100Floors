import processing.sound.*;

SoundFile Music;
SoundFile Button;
SoundFile GameOver;
SoundFile FootSteps; 
Key K;
Door D;
Floor F;
int Game = 1;
float Check;
float ScaleX;
public int GuardNO = 1;
public int ItemNO = 0;
public int WallNO;
public int SensorNO = 1; 
public int PlayerNO = 1;
public int Level = 1;
public int TotalPlayerScore;
public int PlayerScore;
public int PlayerSlot;
public int CommonNO;
public int TotalCommon;
public int UncommonNO;
public int TotalUncommon;
public int RareNO;
public int TotalRare;
public boolean GotKey = false;
public float GuardX;
public float GuardY;
public float PlayerX;
public float PlayerY;
String Username = " ";
Boolean Overwrite = false;
IntList User1 = new IntList(); 
IntList User2 = new IntList(); 
IntList User3 = new IntList(); 
boolean User1Existance = false;
boolean User2Existance = false;
boolean User3Existance = false;
boolean Player2active = false;
boolean PlayableGuardactive = false;
ArrayList<Guard> Guards;
ArrayList<Player> Players;
ArrayList<Item> Items;
ArrayList<Wall> Walls;
ArrayList<Wall2> Walls2;
ArrayList<Sensor> Sensors;
ArrayList<GSensor> GSensors;
PlayableGuard PlayableGuard;
PImage GuardIMG;
PImage KeyIMG;
PImage MENU;
PImage PlayerIMG;

void setup() {
  size(1000,700);
  WallNO = int(random(0, 4));
  GSensors = new ArrayList<GSensor>();
  Guards = new ArrayList<Guard>();
  Players = new ArrayList<Player>();
  Items = new ArrayList<Item>();
  Walls = new ArrayList<Wall>();
  Walls2 = new ArrayList<Wall2>();
  Sensors = new ArrayList<Sensor>();
  PlayableGuard = new PlayableGuard();

  for (int p = 0; p < PlayerNO; p++) {
    Sensors.add(new Sensor());
    Players.add(new Player());
  }

  for (int g = 0; g < GuardNO; g++) {
    Guards.add(new Guard()); 
    GuardIMG = loadImage("GUARD.png");
  }
  for (int i = 0; i <ItemNO; i++) {
    Items.add(new Item());
  }
  for (int w = 0; w < WallNO; w++) {
    Walls.add(new Wall());
  }
  for (int w2 = 0; w2 < WallNO; w2++) {
    Walls2.add(new Wall2());
  }
  for (int gs = 0; gs < GuardNO; gs++) {
    GSensors.add(new GSensor());
  }
  K = new Key();
  KeyIMG = loadImage("KEY.PNG");
  PlayerIMG = loadImage("PLAYER.png");
  MENU = loadImage("MENU.jpg");
  D = new Door();
  F = new Floor();
  Music = new SoundFile(this, "Music.mp3");
  Button = new SoundFile(this, "Button.mp3");
  GameOver = new SoundFile(this, "GameOver.mp3");
  FootSteps = new SoundFile(this, "Somebody.mp3");
}

void NewGameSetup() {
}

void draw() {
  if (Game == 1) {
    Menu();
  } else if (Game == 2) {
    NextLevel();
  } else if (Game == 3) {
    MakeGame();
  } else if (Game == 4) {
    GameOver();
  } else if (Game == 5) {
    Win();
  } else if (Game == 6) {
    Pause();
  } else if (Game == 7) {
    LoadGame();
  } else if (Game == 8) {
    NewUser();
  } else if (Game == 9) {
    Story();
  } else if (Game == 10) {
    Player2();
  }
}

void mousePressed() {
  Button.play();
  if ((Game == 2) || (Game == 4) || (Game == 5)) {
    setup();
    if (Game == 2) {
      Game = 3;
    }
  } else if (Game == 9) {
    Game = 2;
  } else if ((Game == 3) && (mouseX > width-100) && (mouseY > height-100)) {
    Game = 6;
  } else if (Game == 6) {
    if ((mouseX < 700) && (mouseX > 300) && (mouseY <300) && (mouseY > 50)) {
      Game = 3;
    } else if ((mouseX < 700) && (mouseX > 300) && (mouseY < height) && (mouseY > height -200 )) {
      Game = 1;
    }
  } else if ((Game == 1) && ((mouseX < 700) && (mouseX > 300) && (mouseY < 450) && (mouseY > 50))) {
    Game = 7;
  } else if (Game == 7) {
    if ((mouseX < 700) && (mouseX > 300) && (mouseY < 300) && (mouseY > 50)) {
      PlayerSlot = 1;
      if (User1Existance == true) {
        User1.set(0, User1.get(0));
      } else {
        User1.set(0, 1);
      }
      User1Existance = true;
      Game = 8;
    } else if ((mouseX < 700) && (mouseX > 300) && (mouseY < 550) && (mouseY > 300)) {
      PlayerSlot = 2;
      if (User2Existance == false) {
        User2.set(0, 1);
      }
      User2Existance = true;
      Game = 8;
    } else if ((mouseX < 700) && (mouseX > 300) && (mouseY < 300) && (mouseY > 50)) {
      PlayerSlot = 3;
      if (User3Existance == false) {
        User3.set(0, 1);
      }
      User3Existance = true;
      Game = 8;
    }
  } else if ((Game == 8) && (mouseX > 650) && (mouseX < 880) && (mouseY < 540) && (mouseY > 430)) {
    Overwrite = true;
    Game = 9;
  } else if (Game == 10) {
    if ((mouseX > 200) && (mouseX < 500) && (mouseY > 300) && (mouseY < 600)) {
      PlayerNO += 1;
      Player2active = true;
      setup();
      Game = 3;
    } else if ((mouseX > 500) && (mouseX < 800) && (mouseY > 300) && (mouseY < 600)) {
      PlayableGuardactive = true;
      setup();
      Game = 3;
    }
  }
}
void keyPressed() {
  if (Game == 3) {
    if ((key == 'p') || (key == 'p')) {
      Game = 6;
    }
    if ((keyCode == ENTER)) {
      Game = 10;
    } 
    if (keyCode == SHIFT) { 
      Players.get(0).Speed = 3;
      Players.get(0).moving(0);
    } else {
      if (PlayableGuardactive == true) { 
        PlayableGuard.movement();
      }
      for (int player = 0; player < Players.size(); player++) {
        Players.get(player).moving(player);
      }
    }

    if (Game == 6) {
      if ((key == 'r') || (key == 'R')) {
        Game = 3;
      }
    }
    if (Game == 8) {
      if (key == BACKSPACE) {
        Username = Username.substring (0, Username.length()-1);
      } else { 
        Username = Username + key;
      }
    }
    if (Game == 10) { 
      if (key == BACKSPACE) {
        Game = 3;
      }
    }
  }
}

void keyReleased() {
  if (Game == 3) {
    for (int player = 0; player < Players.size(); player++) {
      Players.get(player).notmoving(player);
    }
    if (PlayableGuardactive == true) {
      PlayableGuard.notmoving();
    }
    if (keyCode == SHIFT) {
      for (int w = 0; w < Walls.size(); w++) {
        Walls.get(w).Goback = 5;
      }
      for (int p = 0; p <Players.size(); p++) {
        Players.get(p).Speed = 1.5;
        Players.get(p).notmoving(0);
      }
    }
  }
}

void Menu() {
  background(0);
  imageMode(1);
  image(MENU, 0, 0, width, height);
  fill(255);
  rect(300, 50, 400, 200);
  rect(300, 250, 400, 200);
  rect(300, 450, 400, 200);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("New Game", width/2, height/3 - 80);
  text("Load Game", width/2, height * 2/3 - 120);
  text("Options", width/2, height - 160);
}

void MakeGame() { 
  stroke(0);
  background(150);
  fill(255);
  line(0, 0, 100, 100);
  line(0, 700, 100, 600);
  line(1000, 0, 900, 100);
  line(1000, 700, 900, 600);
  rect(100, 100, 800, 500);
  F.display();
  D.display();
  print(Players.size());
  print(Sensors.size());
  for (int p = 0; p < Players.size(); p++) {
    PlayerX = Players.get(p).x;
    PlayerY = Players.get(p).y;
    Sensors.get(p).display();
    Sensors.get(p).movement();
    Players.get(p).display();
    Players.get(p).PlayerCheckGuard();
  }
  for (int p = 0; p < Players.size(); p++) {
  }
  if (PlayableGuardactive == true) {
    PlayableGuard.display();
  }
  if (Items.size() == 0) {
    if (GotKey == false) {
      K.display();
    } else if (GotKey == true) {
      D.UnlockDoor();
    }
  }
  for (int i = 0; i < Items.size (); i ++) {
    Item I = Items.get(i);
    I.display();
    I.SameCell();
  }

  for (int gs = 0; gs < Guards.size (); gs ++) {
    GuardX = Guards.get(gs).x;
    GuardY = Guards.get(gs).y;
    GSensor GS = GSensors.get(gs);
    GS.display();
    GS.movement();
  }

  for (int g = 0; g < Guards.size (); g ++) {
    Guard G = Guards.get(g);
    G.display();
    G.movement();
  }

  for (int w = 0; w < Walls.size (); w ++) {
    Wall W = Walls.get(w); 
    W.display();
    W.WallCheckWall(); 
    W.WallCheckPlayer();
    W.WallCheckGuards(); 
    W.WallCheckItems();
  }

  for (int w2 = 0; w2 < Walls2.size (); w2 ++) {
    Wall2 W2 = Walls2.get(w2); 
    W2.display();
    W2.WallCheckWall(); 
    W2.WallCheckPlayer();
    W2.WallCheckGuards(); 
    W2.WallCheckItems();
  }
  fill(255);
  rect(0, height-100, width, 100);
  InGameMenu();
}

void GameOver() {
  Game = 4;
  PlayerScore = (CommonNO*10)+(UncommonNO*20)+(RareNO*50);
  GotKey = false;
  clear();
  textSize(160);
  fill(256, 0, 0); 
  text("GAME OVER", width/2, height/3);
  fill(255);
  textSize(100);
  rect(80, 430, 500, 110);
  rect(650, 430, 230, 110);
  fill(0);
  text("Try Again", width/3, height*2/3);
  text("Quit", width*2/3 + 100, height*2/3);
  fill(255);
  if (mousePressed) { 
    textSize(100);
    text("memes", 190, 100);
    if ((mouseX > 80) && (mouseX < 580) && (mouseY < 540) && (mouseY > 430)) {
      TotalCommon -= CommonNO;
      TotalUncommon -= UncommonNO;
      TotalRare -= RareNO;
      CommonNO = 0;
      UncommonNO = 0;
      RareNO = 0;
      TotalPlayerScore -= PlayerScore;
      setup();
      Game = 2;
    }
    if ((mouseX > 650) && (mouseX < 880) && (mouseY < 540) && (mouseY > 430)) {
      TotalCommon = 0; 
      TotalUncommon = 0;
      TotalRare = 0;
      PlayerScore = 0;
      TotalPlayerScore = 0;
      GuardNO = 1;
      Game = 1;
    }
  }
}

void Win() {
  GotKey = false;
  Game = 4;
  clear();
  textSize(160);
  fill(0, 256, 0); 
  text("YOU WIN", width/2, height/2);
  if (mousePressed) {
    Game = 1;
  }
}

void InGameMenu() {
  fill(0);
  textSize(30);
  textAlign(CENTER, CENTER);
  text("Total Score:", 100, height - 50);
  text(TotalPlayerScore, 210, height - 50);
  textSize(20);
  text("Items Collected:", 300, height-90);
  text("Common:", 300, height-60);
  text(TotalCommon, 360, height-60);
  text("Uncommon:", 300, height-40);
  text(TotalUncommon, 370, height-40);
  text("Rare:", 300, height-20); 
  text(TotalRare, 340, height-20);
  textSize(100);
  text("||", width-50, height-65);
  if (Items.size() == 0) {
    if (GotKey == true) {
      textSize(20);
      text("YOU GOT THE KEY! GET TO THE DOOR!", 650, height - 50);
    } else {
      textSize(20);
      text("YOU FOUND ALL THE ITEMS IN THE ROOM", 650, height - 50);
      text("NOW FIND THE GAURD WHICH HAS THE KEY", 650, height -30);
    }
  }
}

void NextLevel() { 
  GotKey = false;
  Game = 2;
  clear(); 
  textSize(100);
  textAlign(CENTER, CENTER);
  fill(255);
  text("Floor", width/2 - 50, height/2);
  if (PlayerSlot == 1) {  
    text(str(User1.get(0)), width/4, 0, width*3/4, height);
  } else if (PlayerSlot == 2) {
    text(str(User2.get(0)), width/4, 0, width*3/4, height);
  } else if (PlayerSlot == 3) {
    text(str(User3.get(0)), width/4, 0, width*3/4, height);
  }
  textSize(50);
  //text("Number Of Guards:", width/2, height/2);
  //text(GuardNO, width/2 + 250, height/2);
  //text("Number Of Items:", width/2, height/2 + 100);
  //text(Items.size(), width/2 + 230, height/2 + 100);
}

void Pause() {
  for (int p = 0; p < Players.size(); p++) {
    Players.get(p).MoveDown = 0;
    Players.get(p).MoveRight = 0; 
    Players.get(p).MoveLeft = 0;
    Players.get(p).MoveUp = 0;
  }
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);
  fill(255);
  stroke(0);
  text("Game Paused", width/2, 50);
  rect(300, 100, 400, 200);
  rect(300, 300, 400, 200);
  rect(300, 500, 400, 200);
  textSize(51.5);
  textSize(50);
  fill(0);
  stroke(0);
  text("Resume", width/2, height/3 - 30);
  text("Save and Quit", width/2, height * 2/3 - 70);
  text("Quit", width/2, height - 110);
}

void LoadGame() {
  imageMode(1);
  image(MENU, 0, 0, width, height);
  fill(255);
  text("CHOOSE SLOT", width/2, 50);
  rect(300, 100, 400, 200);
  rect(300, 300, 400, 200);
  rect(300, 500, 400, 200);
  textSize(50);
  fill(0);
  if (Overwrite == true) {
    text(Username, 0, height/3 - 80, 1000, 100);
  } else { 
    text("NEW SLOT", width/2, height/3 - 30);
  }
  text("NEW SLOT", width/2, height * 2/3 - 70);
  text("NEW SLOT", width/2, height - 110);
}

void NewUser() {
  clear();
  imageMode(1);
  image(MENU, 0, 0, width, height);
  textSize(60);
  fill(255); 
  text("Please enter a username", width/2, 100);
  textSize(100);
  text("Back", width/3-100, height*2/3);  
  text("Enter", width*2/3 + 100, height*2/3);
  textSize(50);
  text(Username, 0, height/3, 1000, 100);
}


void Story() {
  clear();
  imageMode(1);
  image(MENU, 0, 0, width, height);
  textSize(50);
  textAlign(LEFT);
  text("BACKSTORY:", 20, 50);
  text("Hey,", 100, 120);
  text(Username, 140, 120);
  textSize(25);
  text("So...You've just entered to be part of the elite group of thiefs and you are about", 20, 200);
  text("to undergo through a 'simple' test to see if you are good enough and have what", 20, 225);
  text("it takes to join the exclusive club. The test is straight forward: get through", 20, 250);
  text("and rob 100 floors in a museum located in new york...", 20, 275);
  text("However.... to proceed through each floor, you must:", 20, 350);
  text("-COLLECT ALL ITEMS", 50, 400);
  text("-COLLECT THE KEY FROM THE GUARDS", 50, 450);
  text("- AND MOST IMPORTANTLY! DON'T GET CAUGHT!", 50, 500);
  textSize(100);
  textAlign(CENTER);
  text("GOOD LUCK!", width/2, 650);
}

void Player2() {
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);
  fill(255);
  stroke(0);
  rect(200, 200, 600, 400);
  textSize(51.5);
  text("Hello, Player2", width/2, 100);
  text("NOTE: ADDING A PLAYER WILL RESET THE CURRENT FLOOR", width/2, 150); 
  textSize(50);
  fill(0);
  stroke(0);
  text("What do you want to be:", width/2, 300);
  text("A Player:", width/3, 400);
  text("A Guard:", width*2/3, 400);
  image(PlayerIMG, 350, 500, 100, 100);
  image(GuardIMG, 650, 500, 100, 100);
}



void Save() {
}

void ExistingUser() {
}