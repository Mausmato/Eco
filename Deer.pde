class Deer {
  //FIELDS
  PVector pos, vel; // Make the pos the place where a mouse is clicked so that hte things spawn where the mouses are clicked.
  PVector dir;
  float hunger, thirst;
  float speed, size, sightRadius;
  boolean alive;

  //CONSTRUCTOR
  Deer(float pos, float s, float rad, float agit) {
    this.speed = s;
    this.sightRadius = rad;
    this.pos = new PVector( random(0.2*width, 0.8*width), random(0.2*height, 0.8*height));
    this.alive = true;
    this.size = 35;  //later set
    this.pickRandDirection();
  }


  //Methods


  void drawMe() {
  }


  void move() {
  }
