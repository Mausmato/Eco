class Rabbit {
  //FIELDS
  String name;
  PVector pos, vel;
  PVector dir;
  float hunger, thirst;
  float speed, size, sightRadius, agitation;
  boolean alive;
  color furColour;
  
  //CONSTRUCTOR
  Rabbit(String n, float s, float rad, float agit) {
    this.name = n;
    this.furColour = fur;
    this.speed = s;
    this.sightRadius = rad;
    this.agitation = agit;
    this.pos = new PVector( random(0.2*width, 0.8*width), random(0.2*height, 0.8*height)); 
    this.alive = true;
    this.size = 35;  //later set 
    this.pickRandDirection();
  }
  
  //METHODS
  void drawMe() {
    fill(this.furColour);
    noStroke();
    square( this.pos.x, this.pos.y, this.size );
    
    noFill();
    stroke(0);
    circle( this.pos.x, this.pos.y, 2*this.sightRadius );
    
    fill(0);
    text( round(this.hunger), this.pos.x, this.pos.y );
  }
  
  
  void move() {
    boolean spottedPlant = false;
    this.hunger += 0.02;
    


    if( ! rabbitInBounds() ) {
      this.vel.mult(-1);  //Reverse direction
    }
         
    this.pos.add( this.vel );
  }
  
  
  void pickRandDirection() {
    float angle = random(0, TWO_PI);
    this.dir = new PVector( cos(angle), sin(angle) );  //Unit vector pointing in the randomly chosen angle
    this.vel = this.dir.mult( this.speed );  //Velocity = the unit vector multiplied by how fast you move
  }
  
  

  
  boolean rabbitInBounds() {
    return this.pos.x > 0 
        && this.pos.x < width
        && this.pos.y > 0
        && this.pos.x < height;   
  }
  
  
}
