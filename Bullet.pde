class Bullet {
  float x, y;
  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void show() {
    pushStyle();
    noStroke();
    rectMode(CENTER);
    fill(255);
    rect(x, y, 2, 4);
    popStyle();
  }
  
  void move() {
    y -= 2;
  }
}