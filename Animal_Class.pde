  class Animal {
  //FIELDS
  PVector pos, vel; //Will have a position + velocity
  PVector dir; //Direction
  float hunger, thirst; //All animals will have hunger and thirst
  float speed, sightRadius; //Will all have a speed size and sight radius
  boolean alive; //To determine if they are dead due to eaten / hunger

  //Constructor
  Animal(float s, float rad) {
    this.speed = s;
    this.sightRadius = rad;
    this.pos = new PVector( random(0.2*width, 0.8*width), random(0.2*height, 0.8*height));
    this.alive = true;
    this.pickRandDirection();
  }

  void pickRandDirection() {
    float angle = random(0, TWO_PI);
    this.dir = new PVector( cos(angle), sin(angle) );  //Unit vector pointing in the randomly chosen angle
    this.vel = this.dir.mult( this.speed );  //Velocity = the unit vector multiplied by how fast you move
  }

  void PStats() {
    println(speed);
    println(sightRadius);
  }
}
