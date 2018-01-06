boolean keyright = false;
boolean keyleft = false;
boolean hit = false;

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) keyleft = true; 
    if (keyCode == RIGHT) keyright = true;
  }
  if (key == ' ') hit= true;
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT) keyleft = false; 
    if (keyCode == RIGHT) keyright = false;
  }
  if (key == ' ') hit= false;
}


void control() {
  if (keyleft) {
    if (sx<=0)sx=0;
    else sx-=1.5;
  }
  if (keyright) {
    if (sx>=width)sx=width;
    else sx+=1.5;
  }
  if (hit) {
    Bullet B = new Bullet(sx, y-30);
    bulletList.add(B);
    hit=false;
  }

  for (int i=0; i<blastList.size (); i++) {
    Particle P = blastList.get(i);
    P.display();
    P.move();
    if (P.r<0)blastList.remove(i);
  }
}