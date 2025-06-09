public class Button
{
  color rectColor, rectHighlight;
  boolean rectOver = false;
  int x, y, w, h;
  String str;
  PFont font;

  public Button(int X, int Y, int W, int H, String text)
  {
    x = X;
    y = Y;
    w = W;
    h = H;
    str = text;
    font = createFont("Georgia", 20, true);
    rectColor = color(219, 123, 184);
    rectHighlight = color(232, 179, 213);
  }
  
  public void update()
  {
    if (overRect())
    rectOver = true;
    else
    rectOver = false;
    
    if (rectOver)
     fill(rectHighlight);
    else
     fill(rectColor);
     
    stroke(255);
    rect(x, y, w, h);
    
    textFont(font);
    fill(250, 250, 250);
    textAlign(CENTER);
    text(str, x+w/2, y+h/2+5);
  }
  
  public boolean overRect()
  {
  if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h)
    return true;
  else
    return false;
  }
  
  
}
