import processing.sound.*;
SoundFile eh, oi, una;

final static float SPRITE_SIZE = 50;
final static float GRAVITY = .3;
final static float MOVE_SPEED = 5;

Sprite chii;
Sprite hachi;
Sprite usa;
Sprite character;
Sprite ground;
Sprite sky;
ArrayList<Bar> bars;
Button chooseChar;
PImage blue, white, yellow, lightB;

PFont selectText;

boolean started = false;
boolean charSelected = false;
boolean displayStart = false;
boolean gameOver = false;
float count = 100;
int score = 0;
int highScore = 0;


void setup()
{
  size(750, 600);
  selectText = createFont("Georgia", 20, true);
  
  ground = new Sprite("data/ground.png", 1, 0, 560, "Ground");
  sky = new Sprite("data/ground.png", 1, 0, -290, "Sky");
  chooseChar = new Button (width/2 - 105, 100, 210, 60, "Choose Character");
  bars = new ArrayList<Bar>();
  chii = new Sprite ("data/chii.png", 0.2, 100, 350, "Chiikawa");
  hachi = new Sprite("data/hachi.png", 0.21, 300, 345, "Hachiware");
  usa = new Sprite("data/usa.png", 0.24, 500, 320, "Usagi");
  
  eh = new SoundFile(this, "data/eh.mp3");
  oi = new SoundFile(this, "data/oi.mp3");
  una = new SoundFile(this, "data/una.mp3");
}

void draw()
{
  background(255,236,240);
  textFont(selectText);
  
  //display "choose a character"
  if(charSelected && !started && !displayStart)
  {
    chooseChar.update();
    fill(219, 123, 184);
    textAlign(CENTER);
    text(character.charName + " selected", width/2, 275);
  }
  else if (!started && !displayStart)
  {
    fill(219, 123, 184);
    textAlign(CENTER);
    text("Select your character", width/2, 275);
    fill(255, 255, 255);
    stroke(219, 123, 184);
    rect(width/2 - 250, 50, 500, 150);
    fill(219, 123, 184);
    textAlign(CENTER);
    text("Instructions", width/2, 75);
    textAlign(LEFT);
    text("1. Choose your character", width/2-240, 120);
    text("2. Press space to start", width/2-240, 145);
    text("3. Press space to jump and avoid all obstacles", width/2-240, 170);
  }

  if(!started)
  {
    if(displayStart)
    {
      character.display();
      fill(219, 123, 184);
      textAlign(CENTER);
      text("Press space to start", width/2, 150);
    }
    else
    {
      chii.display();
      hachi.display();
      usa.display();
    }
  }
  else
  {
    if(!gameOver)
    {
    
      if(count % 100 == 0)
      {
        float bottom = random(205, 540);
        Bar next = new Bar(.6, 800, bottom-650, bottom);
        bars.add(next);
      }
    
      count++;
      
      for(int i = 0; i < bars.size(); i++)
      {
        if(bars.get(i).getRight() < -75)
        {
          bars.remove(i);
          i--;
        }
      }
    
      for(Bar b : bars)
      {
        b.display();
        b.update();
      }
    
      sky.display();
      ground.display();
      character.display();
      character.change_y += GRAVITY;
      character.center_y += character.change_y;
      character.center_x += character.change_x;
    
      text("Score: " + score, 700, 25);
      
      if(count >= 360)
      {
        if((count-60) % 100 == 0)
          score++;
      }
      
      if(checkCollision(character, bars.get(0)) || character.getBottom() >= ground.getTop())
        gameOver = true;
        
      if(character.charName.equals("Usagi"))
      {
         if(character.getTop() + 30 <= sky.getBottom())
           gameOver = true;
      }
      else if(character.charName.equals("Hachiware") || character.charName.equals("Chiikawa"))
      {
         if(character.getTop() + 10 <= sky.getBottom())
           gameOver = true;
      }
    }
    else
    {
      for(Bar b : bars)
      {
        b.display();
      }
      sky.display();
      ground.display();
      character.displayDead();
      fill(255, 255, 255);
      stroke(219, 123, 184);
      rect(width/2 - 85, 120, 170, 100);
      fill(219, 123, 184);
      if(score > highScore)
      highScore = score;
      textAlign(CENTER);
      text("Game Over\nScore: " + score + "\nHigh Score: " + highScore, width/2, 150);
      
      Button restart = new Button (width/2 - 175/2, 310, 175, 50, "Restart");
      Button menu = new Button (width/2 - 175/2, 375, 175, 50, "Back to Menu");
      restart.update();
      menu.update();
    }
  }
  
}

boolean checkCollision(Sprite s1, Bar s2)
{
  if(s1.charName.equals("Usagi"))
  {
    if(s1.getTop() + 30 <= s2.getTop() && s1.getRight() >= s2.getLeft() + 70    && s1.getLeft() <= s2.getRight() - 25)
      return true;
      else if(s1.getBottom() - 10 >= s2.getBottom() && s1.getRight() >= s2.getLeft() + 70 && s1.getLeft() <= s2.getRight() - 25)
      return true;
  }
  else
  {
    if(s1.getTop() + 10 <= s2.getTop() && s1.getRight() >= s2.getLeft() + 55 && s1.getLeft() <= s2.getRight() - 25)
      return true;
    else if(s1.getBottom() - 10 >= s2.getBottom() && s1.getRight() >= s2.getLeft() + 55 && s1.getLeft() <= s2.getRight() - 25)
      return true;
  }
    
  return false;
}

public ArrayList<Bar> checkCollisionList(Sprite s, ArrayList<Bar> list)
{
  ArrayList<Bar> colliList = new ArrayList<Bar>();
  for(Bar p: list)
  {
    if(checkCollision(s,p))
      colliList.add(p);
  }
  return colliList;
}

void mousePressed()
{
  if(gameOver)
  {
    if(mouseX >= (width/2 - 175/2) && mouseX <= (width/2 - 175/2)+175 && mouseY >= 320 && mouseY <= 370)//restart
    {
      started = false;
      gameOver = false;
      bars.clear();
      resetChar(character.charName);
      count = 100;
      score = 0;
    }
    else if (mouseX >= (width/2 - 175/2) && mouseX <= (width/2 - 175/2) + 175 && mouseY >= 375 && mouseY <= 425)//menu
    {
      started = false;
      gameOver = false;
      displayStart = false;
      charSelected = false;
      bars.clear();
      resetChar(character.charName);
      count = 100;
      score = 0;
    }
  }
  else if(!displayStart)
  {
    if(chooseChar.overRect())
    {
      displayStart = true;
    }
    else if(chii.over())
    {
      chii.center_y = chii.ogY-10;
      hachi.center_y = hachi.ogY;
      usa.center_y = usa.ogY;
      character = new Sprite ("data/chii.png", 0.115, 30, 250, "Chiikawa");
      charSelected = true;
      eh.play();
    }
    else if(hachi.over())
    {
      chii.center_y = chii.ogY;
      hachi.center_y = hachi.ogY-10;
      usa.center_y = usa.ogY;
      character = new Sprite("data/hachi.png", 0.117, 30, 250, "Hachiware");
      charSelected = true;
      oi.play();
    }
    else if(usa.over())
    {
      chii.center_y = chii.ogY;
      hachi.center_y = hachi.ogY;
      usa.center_y = usa.ogY-10;
      character = new Sprite("data/usa.png", 0.14, 30, 240, "Usagi");
      charSelected = true;
      una.play();
    }
  }
  
}

void keyPressed()
 {
  if (keyCode == 32)
  {
    if(displayStart)
      started = true;
    character.change_y = -MOVE_SPEED;
  }
}

void keyReleased()
{
  character.change_y = 0;
}

void resetChar(String name)
{
  if(name.equals("Chiikawa"))
    character = new Sprite ("data/chii.png", 0.13, 30, 250, "Chiikawa");
  else if(name.equals("Hachiware"))
    character = new Sprite("data/hachi.png", 0.13, 30, 250, "Hachiware");
  else if(name.equals("Usagi"))
    character = new Sprite("data/usa.png", 0.15, 30, 240, "Usagi");
}
