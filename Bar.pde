
public class Bar
{
  PImage barTop;
  PImage barBottom;
  float center_x, yTop, yBottom;
  float change_x;
  float w, h;

  public Bar(float scale, float x, float top, float bottom)
  {
    barTop = loadImage("data/barTop.png");
    w = barTop.width * scale;
    h = 500;
    barTop.resize((int)w, (int)h);
    
    barBottom = loadImage("data/barBottom.png");
    barBottom.resize((int)w, (int)h);
    
    center_x = x;
    change_x = 3;
    yTop = top;
    yBottom = bottom;
  }
  
  public void display()
  {
    image(barTop, center_x, yTop);
    image(barBottom, center_x, yBottom);
  }
  
  public void update()
  {
    center_x -= change_x;
  }
  
  void setLeft(float left)
  {
    center_x = left + w/2;
  }
  float getLeft()
  {
    return center_x - w/2;
  }
  void setRight(float right)
  {
    center_x = right - w/2;
  }
  float getRight()
  {
    return center_x + w/2;
  }
  void setTop(float top)
  {
    yTop = top + h/2;
  }
  float getTop()
  {
    return yTop + h;
  }
  void setBottom(float bottom)
  {
    yBottom = bottom - h/2;
  }
  float getBottom()
  {
    return yBottom;
  }
  
  float distance()
  {
    return yBottom - (yTop);
  }
  
}
