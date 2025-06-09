

public class Sprite
{
  PImage img;
  PImage dead;
  String charName;
  float center_x, center_y;
  float ogX, ogY;
  float change_x, change_y;
  float w, h, wD, hD;

  public Sprite(String fileName, float scale, float x, float y, String name)
  {
    img = loadImage(fileName);
    w = img.width * scale;
    h = img.height * scale;
    img.resize((int)w, (int)h);
    center_x = x;
    center_y = y;
    ogX = x;
    ogY = y;
    change_x = 0;
    change_y = 0;
    charName = name;
    if(name.equals("Hachiware"))
    {
      dead = loadImage("data/hachiDead.png");
      wD = dead.width * (scale+0.03);
      hD = dead.height * (scale+0.03);
      dead.resize((int)wD, (int)hD);
    }
    else if(name.equals("Usagi"))
    {
      dead = loadImage("data/usaDead.png");
      wD = dead.width * (scale);
      hD = dead.height * (scale);
      dead.resize((int)wD, (int)hD);
    }
    else if(name.equals("Chiikawa"))
    {
      dead = loadImage("data/chiiDead.png");
      wD = dead.width * (scale+0.03);
      hD = dead.height * (scale+0.03);
      dead.resize((int)wD, (int)hD);
    }
  }
  
  public Sprite(PImage imag, float scale)
  {
    img = imag;
    w = img.width * scale;
    h = img.height * scale;
    center_x = 0;
    center_y = 0;
    change_x = 0;
    change_y = 0;
    
  }
  
  public void display()
  {
    image(img, center_x, center_y);
  }
  
  public void displayDead()
  {
    image(dead, center_x, center_y);
  }
  
  public boolean over()
  {
    if (mouseX >= center_x && mouseX <= center_x+w && mouseY >= center_y && mouseY <= center_y+h)
      return true;
    else
      return false;
  }
  
  public void update()
  {
    center_x += change_x;
    center_y += change_y;
  }
  
  public float getLeft()
  {
    return center_x;
  }
  
  public float getRight()
  {
    return center_x + w;
  }
  
  public float getTop()
  {
    return center_y;
  }
  
  public float getBottom()
  {
    return center_y + h;
  }
  
  public void setLeft(float newLeft)
  {
    center_x = newLeft + w/2;
  }
  
  public void setRight(float newRight)
  {
    center_x = newRight - w/2;
  }
  
  public void setTop(float newTop)
  {
    center_y = newTop + h/2;
  }
  
  public void setBottom(float newBottom)
  {
    center_y = newBottom - h/2;
  }
  
}
