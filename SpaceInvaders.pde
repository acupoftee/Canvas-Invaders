
ArrayList<Alien> AlienList = new ArrayList();
ArrayList<Bullet> bulletList = new ArrayList();
ArrayList<Particle> blastList = new ArrayList();

ArrayList<Alien> deadAliens = new ArrayList<Alien>();
ArrayList<Bullet> deadBullets = new ArrayList<Bullet>();

float y, sx, deltay=0.1;
int level=0;
boolean gamelost = false, gamewin = false;
void setup() {
  size(300, 400);
  AddAlien();
  y=height-50;
}

void draw() {
  background(0);
  surface.setTitle("LEVEL "+ level + " Speed = " + deltay);
  if (startGame) {
    //------------------
    for (Alien a : AlienList)
      a.show();
    for (Bullet b : bulletList) {
      b.move();
      b.show();
    }
    //-------------------------
    //------------------------------
    for (int i=AlienList.size ()-1; i>=0; i--) {
      Alien A = AlienList.get(i);
      if (!gamelost)A.move();
      for (int j=bulletList.size ()-1; j>=0; j--) {
        Bullet B  =  bulletList.get(j);
        if ((sq(B.x-A.x)+sq(B.y-A.y))<sq(10)) { // check distance
          AlienList.remove(i);
          bulletList.remove(j);

          for (int k=0; k<30; k++) {
            Particle P = new Particle(A.x+random(-30, 30), A.y+random(-30, 30), A.c);
            blastList.add(P);
          }
        } else if (B.y<=1) bulletList.remove(j);
      }
      if (!deadBullets.isEmpty()) { 
        bulletList.removeAll(deadBullets);
        deadBullets.clear();
      }
      if (A.y>y+10) {
        gamelost = true;
      }
      if (!deadAliens.isEmpty()) {
        AlienList.removeAll(deadAliens);
        deadAliens.clear();
      }
      if (AlienList.size()<=0) {
        gamewin = true;
      }
    }
  } else startmenu();
  //--------------------------------------
  control();
  pushMatrix();
  translate(sx, y);
  ship();
  popMatrix();
  //--------------------------------------
  if (gamewin) {
    rectMode(CENTER);
    noStroke();
    fill(0);
    rect(width>>1, height>>1, 200, 150);
    textAlign(CENTER);
    textSize(30);
    fill(#F50041);
    text("You Won !", width>>1, height>>1);
    fill(-1);
    rect(width>>1, height/2 + 55, 200, 25);
    fill(0);
    textSize(15);
    text("Game will restart in " + (500-timer)/60, width>>1, height/2 + 60);
    timer++;
    if (timer>500) { // timer
      gameReset();
      timer=0;
      gamewin=false;
      level++;
      deltay+=5/100.0;
    }
  }
  if (gamelost) {
    rectMode(CENTER);
    noStroke();
    fill(0);
    rect(width>>1, height>>1, 200, 150);
    textAlign(CENTER);
    textSize(30);
    fill(#F50041);
    text("Game Over", width>>1, height>>1);
    fill(0);
    rect(width>>1, height/2 + 55, 200, 25);
    fill(0);
    textSize(15);
    text("You Lost", width>>1, height/2 + 35);
    textSize(15);
    text("Game will restart in " + (500-timer)/60, width>>1, height/2 + 60);
    timer++;
    if (timer>500) { // timer 
      gameReset();
      timer=0;
      gamelost=false;
    }
  }
}


void stop() {
  super.stop();
}


void ship() {
  stroke(0);
  fill(255);
  beginShape();
  vertex(0, 0);
  vertex(10, 20);
  vertex(0, 15);
  vertex(-10, 20);
  vertex(0, 0);
  endShape();
}