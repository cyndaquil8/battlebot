class Tile {
  //variables
  PImage img;
  boolean collide;
  boolean portal;
  float x;
  float y;

  
  public Tile(float x, float y, boolean c, boolean p, PImage img) {
    this.x = x;
    this.y = y;
    this.img = img;
    collide = c;
    portal = p;
  }
  
  public Tile() {
  
  }
  
  void draw() {
    image(this.img, this.x, this.y);
  }
  
}
