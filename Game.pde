import processing.sound.*;

SoundFile Music; //This section is all the sound files
SoundFile Button;
SoundFile GameOver;
SoundFile FootSteps; 

Key K; //These are initialising all the objects 
Door D;
Floor F;
BoostBar BoostBar;
ArrayList<Guard> Guards; //This creates an array of all the object which will have more than 1 object of one class 
ArrayList<Player> Players;
ArrayList<Item> Items;
ArrayList<Wall> Walls;
ArrayList<Sensor> Sensors;
ArrayList<GSensor> GSensors;
PlayableGuard PlayableGuard;

int Game = 1; //This is the current function
public int Level = 1;

float Check;
float ScaleX;

public float GuardX; //These variables get the X and Y values of the Player and the Guard
public float GuardY;
public float PlayerX;
public float PlayerY;

public int GuardNO = 1;
public int ItemNO = 0;
public int WallNO = 0;
public int SensorNO = 1; 
public int PlayerNO = 1;

public int CommonNO;
public int TotalCommon;
public int UncommonNO;
public int TotalUncommon;
public int RareNO;
public int TotalRare;

public int TotalPlayerScore;
public int PlayerScore;
public int PlayerSlot;

public boolean GotKey = false;

String Username = " ";
public String object = " ";
Boolean Overwrite = false;
IntList User1 = new IntList(); 
IntList User2 = new IntList(); 
IntList User3 = new IntList(); 
boolean User1Existance = false;
boolean User2Existance = false;
boolean User3Existance = false;
boolean TEST = false;

boolean Player2active = false;
boolean PlayableGuardactive = false;

PImage GuardIMG;
PImage KeyIMG;
PImage BackIMG;
PImage MENU;
PImage PlayerIMG;
PImage Door;

void setup() {
  WallNO = int(random(-0.5,4.5));
  frameRate(60);
  size(1000,700);
  GSensors = new ArrayList<GSensor>();
  Players = new ArrayList<Player>();
  Guards = new ArrayList<Guard>();
  Items = new ArrayList<Item>();
  Walls = new ArrayList<Wall>();
  Sensors = new ArrayList<Sensor>();
  PlayableGuard = new PlayableGuard();

  for (int p = 0; p < PlayerNO; p++) {
    Sensors.add(new Sensor());
    Players.add(new Player());
  }

  for (int g = 0; g < GuardNO; g++) {
    Guards.add(new Guard());
    GSensors.add(new GSensor());
  }
  for (int i = 0; i <ItemNO; i++) {
    Items.add(new Item());
  }
  for (int w = 0; w < WallNO; w ++) {
    Walls.add(new Wall(w));
  }
  
  K = new Key();
  KeyIMG = loadImage("KEY.PNG");
  PlayerIMG = loadImage("PLAYER.png");
  GuardIMG = loadImage("GUARD.png");
  MENU = loadImage("MENU.jpg");
  BackIMG = loadImage("Back.png");
  Door = loadImage("Door.png");
  BoostBar = new BoostBar();
  D = new Door();
  F = new Floor();
  Button = new SoundFile(this, "Button.mp3");
  GameOver = new SoundFile(this, "GameOver.mp3");
  Music = new SoundFile(this, "Music.mp3");
  Music.stop();
  //Music.play();
  image(BackIMG,100,600,100,100);
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
  } else if (Game == 11) {
    LevelEditor();
  }
  fill(255);
  textSize(50);
  text("FPS:"+ int(frameRate),width-100,50);
}

void mousePressed() {
  //Button.play();

  if (Game == 11) {
  if ((mouseX > 100) && (mouseX < width-100) && (mouseY < height-100) && (mouseY > 100)) {
        if ((object == "Player") && (Players.size() < 2)) {
      Sensors.add(new Sensor());
      Players.add(new Player());
      Players.get(1).x = mouseX;
      Players.get(1).y = mouseY;
    }
    else if ((object == "Guard") && (Guards.size() < 50)) { 
      Guards.add(new Guard());
      Guards.get(Guards.size()-1).x = mouseX;
      Guards.get(Guards.size()-1).y = mouseY;
      GSensors.add(new GSensor());
    }
    else if ((object == "Item") &&(Items.size() < 10)) {
      ItemNO += 1;
      Items.add(new Item());
      Items.get(Items.size()-1).x = mouseX;
      Items.get(Items.size()-1).y = mouseY;
      Items.get(Items.size()-1).SameCell(); 
    }
    else if ((object == "Wall") && (Walls.size() < 10)) {
      Walls.add(new Wall(Walls.size()));
      Walls.get(Walls.size()-1).x = mouseX; 
      Walls.get(Walls.size()-1).y = mouseY;
      Walls.get(Walls.size()-1).WallCheckWall();
    }
  }
    if (mouseX < 100) {
      Game = 3;
    }
  }
  if ((Game == 2) || (Game == 4) || (Game == 5)) {
    setup();
    if (Game == 2) {
      Game = 3;
    }
  }if (Game == 4) { 
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
      TEST = false;
      TotalCommon = 0; 
      TotalUncommon = 0;
      TotalRare = 0;
      PlayerScore = 0;
      TotalPlayerScore = 0;
      GuardNO = 1;
      Game = 1;
    }
  }
   else if (Game == 9) {
      Game = 2;
  } else if (Game == 6) {
    if ((mouseX < 700) && (mouseX > 300) && (mouseY <300) && (mouseY > 50)) {
      Game = 3;
    } else if ((mouseX < 700) && (mouseX > 300) && (mouseY < height) && (mouseY > height -200 )) {
      Game = 1;
    }
  } else if ((Game == 1) && ((mouseX < 700) && (mouseX > 300) && (mouseY < 300) && (mouseY > 50))) {
    Game = 7;
  } else if ((Game == 1) && ((mouseX > 700) && (mouseY > 500))) {
    Game = 11;
  }
  else if (Game == 7) {
    if ((mouseX < 700) && (mouseX > 300) && (mouseY < 300) && (mouseY > 100)) {
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
    if (Username == " ") {
      text("THIS USERNAME IS NOT A VALID INPUT", width/2, height - 100);
    }
    else{
    Overwrite = true;
    Game = 9;
    }
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
  print(Game);
  if (Game == 3) {
    if ((keyCode == ENTER)) {
      Game = 10;
    } 
    if (keyCode == SHIFT) {
      Players.get(0).Boost();
    }
    if (PlayableGuardactive == true) { 
      PlayableGuard.movement();
    }
    for (int player = 0; player < Players.size(); player++) {
      Players.get(player).movement(player);
    }
  }
    if (Game == 6) {
      if ((key == 'r') || (key == 'R')) {
        Game = 3;
      }
    }
    if (Game == 8) {
      if ((key == BACKSPACE) && (Username.length() > 1)) {
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


void keyReleased() {
  if (Game == 3) {
    for (int player = 0; player < Players.size(); player++) {
      Players.get(player).nomovement(player);
    }
    if (PlayableGuardactive == true) {
      PlayableGuard.nomovement();
    }
    if (keyCode == SHIFT) { 
      for (int w = 0; w < Walls.size(); w++) {
        Walls.get(w).Goback = 5;
      }
      // for (int p = 0; p <Players.size(); p++) {
      //   Players.get(p).Speed = 1.5;
      //   Players.get(p).notmoving(p);
      // }
    }
  }
}
void DisplayMenu(){
  imageMode(1);
  image(MENU, 0, 0, width, height);
  imageMode(CENTER);
  image(BackIMG,100,600,100,100);
  if ((mousePressed) && (mouseX < 100) && (mouseY > height-100)) {
    Game = Game - 1; 
  }
}

void MenuButtons() {
  rect(300, 100, 400, 200);
  rect(300, 300, 400, 200);
  rect(300, 500, 400, 200); 
}

void Menu() {
  DisplayMenu();
  MenuButtons();
  fill(255);
  rect(600, 550, 400, 200);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("100 FLOORS",width/2,50);
  fill(0);
  text("New Game", width/2, height/3-40);
  text("Load Game", width/2, height * 2/3 - 80);
  text("Options", width/2, height - 100);
  text("LEVEL EDITOR",width-200,height-100);
}

void DisplayGame() {
  stroke(0);
  background(150);
  fill(255);
  line(0, 0, 100, 100);
  line(0, 700, 100, 600);
  line(1000, 0, 900, 100);
  line(1000, 700, 900, 600);
  rect(100, 100, 800, 500);
  rect(0, height-100, width, 100);
  D.display();
}

void MakeGame() { 
  DisplayGame();
  DisplayObjects();
  fill(255);
  InGameMenu();
}

void DisplayObjects() {
    F.display();
    for (int player = 0; player < Players.size(); player++) {
    PlayerX = Players.get(player).x;
    PlayerY = Players.get(player).y;
    Sensors.get(player).display(player);
    Sensors.get(player).movement();
    BoostBar.display();
    Players.get(player).display();
    Players.get(player).PlayerCheckGuard();
    Players.get(player).PlayerCheckItems();
  }
  if (PlayableGuardactive == true) {
    if (Sensors.size() < 3) {
      Sensors.add(new Sensor());
    }
    PlayerX = PlayableGuard.x;
    PlayerY = PlayableGuard.y;
    Sensors.get(Sensors.size()-1).display(3);
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

  for (int g = 0; g < Guards.size(); g ++) {
    Guard G = Guards.get(g);
    G.display();
    G.movement();
  }

  for (int w = 0; w < Walls.size(); w ++) {
    Wall W = Walls.get(w); 
    W.WallCheckWall();
    W.display();
    W.WallCheckPlayer();
    W.WallCheckGuards(); 
    W.WallCheckItems();
  }

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
  rect(0, height-100, width, 100);
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
  PauseButton();
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
  text("Floor", width/2 - 50, height/2-100);
  if (PlayerSlot == 1) {  
    text(str(User1.get(0)), width/4, 0, width*3/4, height-170);
  } else if (PlayerSlot == 2) {
    text(str(User2.get(0)), width/4, 0, width*3/4, height-170);
  } else if (PlayerSlot == 3) {
    text(str(User3.get(0)), width/4, 0, width*3/4, height-170);
  }
  textSize(50);
  text("Number Of Guards:", width/2, height/2);
  text(GuardNO, width/2 + 250, height/2);
  text("Number Of Items:", width/2, height/2 + 100);
  text(Items.size(), width/2 + 230, height/2 + 100);
}


void PauseButton() { 
    textSize(100);
    text("||", width-50, height-65);
    if ((keyPressed) && ((key == 'p') || (key == 'p'))) {
      Game = 6;
    }
    if ((mousePressed) && (mouseX > width-100) && (mouseY > height-100)) {
      Game = 6;
    }
}
void Pause() {
  DisplayMenu();
  MenuButtons();
  for (int p = 0; p < Players.size(); p++) {
    Players.get(p).MoveDown = 0;
    Players.get(p).MoveRight = 0; 
    Players.get(p).MoveLeft = 0;
    Players.get(p).MoveUp = 0;
  }
  stroke(0);
  text("Game Paused", width/2, 50);
  textSize(50);
  fill(0);
  text("Resume", width/2, height/3 - 30);
  text("Save and Quit", width/2, height * 2/3 - 70);
  text("Quit", width/2, height - 110);
}

void LoadGame() {
  DisplayMenu();
  MenuButtons();
  fill(255);
  text("CHOOSE SLOT", width/2, 50);
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
  DisplayMenu();
  textSize(60);
  fill(255); 
  text("Please enter a username", width/2, 100);
  textSize(100);  
  text("Enter", width*2/3 + 100, height*2/3);
  textSize(50);
  text(Username, 0, height/3, 1000, 100);
  if (Username == " ") {
      text("THIS USERNAME IS NOT A VALID INPUT", width/2, height - 100);
    }
}


void Story() {
  clear();
  DisplayMenu();
  textSize(50);
  textAlign(LEFT);
  text("BACKSTORY:", 20, 50);
  text("Hey,", 20, 120);
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
  textSize(20);
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

void LevelEditor() {
  DisplayGame();
  float DifferenceinMouseX = mouseX - pmouseX;
  float DifferenceinMouseY = mouseY - pmouseY;
  fill(0);
  if (keyPressed) {
    if (key == '1') {
      object = "Player"; 
      rect(60,height - 90,80,80);
    }
    if (key == '2') {
      object = "Guard";
      if(object == "Guard") {
      rect(160,height - 90,80,80);
      }
    }
    if (key == '3') {
      rect(260,height - 90,80,80);
      object = "Item";
    }
    if (key == '4') {
      rect(360,height - 95,80,90);
      object = "Wall";
    }
    if (keyCode == BACKSPACE) {
      if (object == "Wall") {
        Walls.remove(Walls.size());
      }

    }
    if (key == '0') { 
      Walls.clear();
      Guards.clear();
      Items.clear();
      if(Players.size() == 2) {
        Players.remove(1);
      }
    }
    if (key == ENTER) {
      TEST = true;
    }
  }
  imageMode(CENTER);
  image(PlayerIMG,100,height-50 , Player.size+40, Player.size+40);
  image(GuardIMG, 200,height-50, Guard.size+40, Guard.size+40);
  fill(0,256,0);
  ellipse(300,height-50,Item.size,Item.size);
  fill(160, 82, 45);
  rect(370,height-90,60,80);
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("You have selected the " + object, 650, height - 70);
  PauseButton();
  for(int p = 0; p < Players.size(); p++) {
    Players.get(p).display();
  }
  for (int g = 0; g < Guards.size(); g++) {
    GuardX = Guards.get(g).x;
    GuardY = Guards.get(g).y;
    GSensors.get(g).display();
    Guards.get(g).display();
  }
  for (int i = 0; i <Items.size(); i++){
    Items.get(i).display();
  }
  for (int w = 0; w < Walls.size(); w++) {
    Walls.get(w).display();
  }
  if(TEST == true) {
    MakeGame();
    fill(256,0,0); 
    rect(width-200,height-90,100,80);
    fill(255);
    textSize(25);
    text("STOP",width-150,height-60);
  }
  if(TEST == false) {    
    fill(0,256,0); 
    rect(width-200,height-90,100,80);
    fill(255);
    textSize(25);
    text("TEST",width-150,height-60);
  }
}

