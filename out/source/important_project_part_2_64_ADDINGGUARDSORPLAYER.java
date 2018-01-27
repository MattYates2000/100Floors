import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class important_project_part_2_64_ADDINGGUARDSORPLAYER extends PApplet {



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

public void setup() {
  
  WallNO = PApplet.parseInt(random(0, 4));
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

public void NewGameSetup() {
}

public void draw() {
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

public void mousePressed() {
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
public void keyPressed() {
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

public void keyReleased() {
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
        Players.get(p).Speed = 1.5f;
        Players.get(p).notmoving(0);
      }
    }
  }
}

public void Menu() {
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

public void MakeGame() { 
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

public void GameOver() {
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

public void Win() {
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

public void InGameMenu() {
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

public void NextLevel() { 
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

public void Pause() {
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
  textSize(51.5f);
  textSize(50);
  fill(0);
  stroke(0);
  text("Resume", width/2, height/3 - 30);
  text("Save and Quit", width/2, height * 2/3 - 70);
  text("Quit", width/2, height - 110);
}

public void LoadGame() {
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

public void NewUser() {
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


public void Story() {
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

public void Player2() {
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);
  fill(255);
  stroke(0);
  rect(200, 200, 600, 400);
  textSize(51.5f);
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



public void Save() {
}

public void ExistingUser() {
}
class Door {
  float x;
  float y;
  float x2;
  float y2;
  float x3;
  float y3;
  float x4;
  float y4;

  public void display() {
    if (GotKey == true) {
      fill(0);
    } else {
      fill(182, 155, 76);
    }
    quad(width-100, 320, width-100, 380, width-40, 440, width-40, 275);
  }

  public void UnlockDoor() {
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
        GuardNO += PApplet.parseInt(random(1, 3));
        ItemNO = PApplet.parseInt(random(1, 8));
        F.FloorType = PApplet.parseInt(random(0, 2));
        CommonNO = 0;
        UncommonNO = 0;
        RareNO = 0;
        Game = 2;
      }
    }
  }
}
class Floor { 
  float FloorY = 100; 
  float FloorX = 100;
  int FloorType = PApplet.parseInt(random(0.5f,2.5f));
  int FloorSize = PApplet.parseInt(random(50, 100));
  int FloorSize2 = PApplet.parseInt(random(50, 100));
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
public class Guard {
  public float x;
  public float y;
  float size; 
  float DG;
  int Start;
  int Move; 
  float Speed;
  int Change;
  int Time = millis();
  float D;
  boolean Collided;
  float rotateGuard;

  Guard() {
    Collided = false;
    for (int p = 0; p < Players.size(); p++) {
      x = random(Players.get(p).x+500, width-120); 
    }
    y = random(100, height-120);
    Move = PApplet.parseInt(random(-0.5f,3.5f));
    Change = PApplet.parseInt(random(0, 200));
    Speed = random(1,2.5f); 
    size = 20;
  }

  public void movement() { 
    //FootSteps.play();
    if (millis() > Time + 500) {
      Collided = false;
      Time = millis();
    }
    if (Change == 50) {
      Move = PApplet.parseInt(random(-0.5f,3.5f));
      print(Move);
    }
    if (Move== 2) {
      rotateGuard = 0;
      D = 0; 
      y = y + Speed;
      GuardCheckGuard();
      if (this.y + size/2 >= height-100) {
        Move= PApplet.parseInt(random(-0.5f,3.5f));
      }
    } else if (Move== 0) {
      D = 2;
      y = y - Speed;
      GuardCheckGuard();
      if (this.y - size/2 <= 100) {
        Move= PApplet.parseInt(random(-0.5f,3.5f));
      }
    } else if (Move== 3) {
      D = 1;
      x = x + Speed;
      GuardCheckGuard();
      if (this.x + size/2 >= width-100) {
        Move= PApplet.parseInt(random(-0.5f,3.5f));
      }
    } else if (Move== 1) {
      GuardCheckGuard();
      D = 3;
      x = x - Speed;

      if (this.x - size/2 <= 100) {
        Move= PApplet.parseInt(random(-0.5f, 3.5f));
      }
    }
    Change = PApplet.parseInt(random(0, 200));
  }

  public void display() {
    fill(0);
    ellipse(x, y, size, size);
    imageMode(CENTER);
    image(GuardIMG, x, y, size+40, size+40);
  }
  public void GuardCheckGuard() {
    Start = 0;
    for (int i = 0; i < Guards.size (); i ++) {
      Start = Start + 1;
      for (int j = Start; j < Guards.size (); j++) {
        DG = dist(Guards.get(i).x, Guards.get(i).y, Guards.get(j).x, Guards.get(j).y);
        if (DG < size+100) { 
          if (Collided == false) { 
            Guards.get(i).Move = PApplet.parseInt(random(0, 3));
            Collided = true;
          }
        }
      }
    }
  }
}
class PlayableGuard extends Guard { 
  
  PlayableGuard() {
    Speed = 3;
  }
  
    public void movement() {
    if (keyCode == DOWN) {
      if (this.y + size/2 >= height-100) {
        y += 0;
      } else { 
        y += Speed;
        rotateGuard = 0;
      }
    } else if (keyCode == LEFT)  {
      x -= Speed;
      rotateGuard = PI/2;
    } else if (keyCode == RIGHT) {
      x += Speed;
      rotateGuard = -PI/2;
    } else if (keyCode == UP) { 
      y -= Speed;
      rotateGuard = PI;
    }
    if (this.x - size/2 <= 100) {
      x -= 0;
    }
    if (this.y - size/2 <= 100) {
      y -= 0;
    }
    if (this.x + size/2 >= width-100) {
      x += 0;
    }
  }

  public void notmoving() {
    if (keyCode == RIGHT) {
      x += 0;
    } else if (keyCode == DOWN) {
       y += 0;
    } else if (keyCode == LEFT) {
      x += 0;
    } else if (keyCode == UP) {
      y += 0;
    }
  }
}
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
  public void display() { 
    fill(255, 255, 100);
    arc(GuardX, GuardY, Length, Length, Start, Stop);
  }


  public void movement() {

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
class Item {  
  float x;
  float y;
  float size; 
  float DI;
  int Start;
  int Chance;
  int Rarity;

  Item() {
    Chance = PApplet.parseInt(random(0,100)); 
    for (int p = 0; p < Players.size(); p++) {
      x = random(Players.get(p).x + 100, width-120); 
    }
    y = random(120, height-120);
    size = 20;
  }

  public void display() {
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

  public void SameCell() {
    Start = 0;
    for (int i = 0; i < Items.size (); i ++) {
      Start = Start + 1;
      for (int j = Start; j < Items.size (); j++) {
        DI = dist(Items.get(i).x, Items.get(i).y, Items.get(j).x, Items.get(j).y);
        if (DI < size+150) { 
          Items.remove(i);
          Items.add(new Item());
        }
      }
    }
  }
}
class Key extends Item { 
  int ChooseGuard = PApplet.parseInt(random(0, Guards.size()));
  float x0;
  float x1;
  float x3;
  float y0;
  float y1;
  float y2;

  public void display() {
    x0 = Guards.get(ChooseGuard).x;
    x1 = Guards.get(ChooseGuard).x - 50;
    x3 = Guards.get(ChooseGuard).x + 50;
    y0 = Guards.get(ChooseGuard).y - 50;
    y1 = Guards.get(ChooseGuard).y;
    y2 = Guards.get(ChooseGuard).y + 50;
    if (Guards.get(ChooseGuard).D == 0 ) {
      ellipse(x0, y0, size, size);
      imageMode(CENTER);
      image(KeyIMG, x0, y0, size, size);
    } else if (Guards.get(ChooseGuard).D == 1 ) {
      ellipse(x1, y1, size, size);
      imageMode(CENTER);
      image(KeyIMG, x1, y1, size, size);
    } else if (Guards.get(ChooseGuard).D == 2 ) {
      ellipse(x0, y2, size, size);
      imageMode(CENTER);
      image(KeyIMG, x0, y2, size, size);
    } else if (Guards.get(ChooseGuard).D == 3 ) {
      ellipse(x3, y1, size, size);
      imageMode(CENTER);
      image(KeyIMG, x3, y1, size, size);
    }
  }
}
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
    Speed = 1.5f;
  }

  public void moving(int player) {
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

  public void notmoving(int player) {
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

  public void display() {
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

  public void PlayerCheckGuard() {
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
class Sensor {
  float Start;
  float Stop;
  float Length;

  Sensor() {
    Start = 2*PI - PI/4;
    Stop = 2*PI + PI/4;
    Length = 100;
  }

  public void display() { 
    fill(0, 256, 0);   
    arc(PlayerX,PlayerY, Length, 100, Start, Stop);
  }

  public void movement() {
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

  public void WallCheckPlayer() {
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

  public void WallCheckGuards() {
    for (int w = 0; w < Walls.size (); w ++) {
      for (int k = 0; k < Guards.size (); k++) {
        if (CheckBoundaryGuard(w, k)) {

          if (Guards.get(k).x < Walls.get(w).x) {
            Guards.get(k).x -= 10; 
            Guards.get(k).Move= PApplet.parseInt(random(0, 3));
          }

          if (Guards.get(k).x > Walls.get(w).x2) {
            Guards.get(k).x += 10; 
            Guards.get(k).Move= PApplet.parseInt(random(0, 3));
          }

          if ((Guards.get(k).x > Walls.get(w).x) && (Guards.get(k).x < Walls.get(w).x2)) {
            Guards.get(k).y += 10; 
            Guards.get(k).Move= PApplet.parseInt(random(0, 3));
          }
        }
      }
    }
  }

  public void WallCheckItems() {
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
class Wall2 extends Wall {

  public void display() {
    fill(160, 82, 45);
    rect(x, y, sizex, sizey);
  }

  public void WallCheckWall() {
    for (int i = 0; i < Walls2.size (); i ++) {

      for (int j = 0; j < Walls2.size (); j++) {
        if ((Walls2.get(i).x > Walls2.get(j).x) && (Walls2.get(i).x < Walls2.get(j).x2)) {
          print("Walls realigned");
          Walls2.remove(i);
          Walls2.add(new Wall2());
        }
        if ((Walls2.get(i).x2 > Walls2.get(j).x) && (Walls2.get(i).x2 < Walls2.get(j).x2)) {
          print("Walls realigned");
          Walls2.remove(i);
          Walls2.add(new Wall2());
        }
      }
    }
  }

  public void WallCheckPlayer() { 
    for (int p = 0; p < Players.size(); p++) {
    for (int i = 0; i < Walls.size (); i ++) {
      if (CheckBoundaryPlayer(i,p)) {
        if (Players.get(p).x < Walls2.get(i).x) {
          Players.get(p).x = Players.get(p).x - Goback;
        }
        if (Players.get(p).x > Walls2.get(i).x2) {
          Players.get(p).x = Players.get(p).x + Goback;
        }
        if ((Players.get(p).x > Walls2.get(i).x) && (Players.get(p).x < Walls2.get(i).x2)) {
          Players.get(p).y = Players.get(p).y - Goback;
        }
      }
    }
    }
  }

  public void WallCheckItems() {
    for (int w = 0; w < Walls.size (); w ++) {
      for (int k = 0; k < Items.size (); k++) {
        if (CheckBoundaryItems(w, k)) {
          Items.remove(k);
          Items.add(new Item());
        }
      }
    }
  }

  public void WallCheckGuards() {
    for (int i = 0; i < Walls.size (); i ++) {
      for (int k = 0; k < Guards.size (); k++) {
        if (CheckBoundaryGuard(i, k)) {

          if (Guards.get(k).x < Walls2.get(i).x) {
            Guards.get(k).x -= 10; 
            Guards.get(k).Move = PApplet.parseInt(random(0, 3));
          }
          else if (Guards.get(k).x > Walls2.get(i).x2) {
            Guards.get(k).x += 10; 
            Guards.get(k).Move = PApplet.parseInt(random(0, 3));
          }

          else if ((Guards.get(k).x > Walls2.get(i).x) && (Guards.get(k).x < Walls2.get(i).x2)) {
            Guards.get(k).y -= 10; 
            Guards.get(k).Move = PApplet.parseInt(random(0, 3));
          }
        }
      }
    }
  } 

  private boolean CheckBoundaryGuard(int i, int k) {
    if (((Walls2.get(i).x < Guards.get(k).x+(Guards.get(k).size/2)))&&((Walls2.get(i).x2 > Guards.get(k).x-(Guards.get(k).size/2))&&(Walls2.get(i).y + 1< Guards.get(k).y+(Guards.get(k).size/2)))) {
      return true;
    }
    return false;
  }

  private boolean CheckBoundaryPlayer(int i, int p) {
    if (((Walls2.get(i).x < Players.get(p).x+(Players.get(p).size/2))) && ((Walls2.get(i).x2 > Players.get(p).x-(Players.get(p).size/2)) && (Walls2.get(i).y < Players.get(p).y + (Players.get(p).size/2)))) {
      return true;
    }
    return false;
  }

  private boolean CheckBoundaryItems(int w, int k) {
    if (((Walls2.get(w).x < Items.get(k).x+(Items.get(k).size/2)))&&((Walls2.get(w).x2 > Items.get(k).x-(Items.get(k).size/2))&&(Walls2.get(w).y + 1< Items.get(k).y+(Items.get(k).size/2)))) {
      return true;
    }
    return false;
  }
}
  public void settings() {  size(1000,700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "important_project_part_2_64_ADDINGGUARDSORPLAYER" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
