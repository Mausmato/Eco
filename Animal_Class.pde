class Animal {
  PVector pos, vel, dir;  // Position, velocity, and direction vectors
  float hunger, thirst, speed, sightRadius, size, waterLevel;  // Attributes
  boolean alive;  //Alive / dead

  // Constructor
  Animal(float initialSpeed) {
    this.speed = initialSpeed;
    this.waterLevel = 100;  // Initial water
  }

  // Constructor
  Animal(float s, float rad) {
    this.speed = s;
    this.size = s;
    this.sightRadius = rad;
    this.pos = new PVector(random(0.2 * width, 0.8 * width), random(0.2 * height, 0.8 * height));
    this.alive = true;
    this.pickRandDirection();
  }

  // Randomly Dir Animal
  void pickRandDirection() {
    float angle = random(0, TWO_PI);
    this.dir = new PVector(cos(angle), sin(angle));
    this.vel = this.dir.mult(this.speed);
  }

  // Method to print speed and sight radius for debugging
  void PStats() {
    println(speed);
    println(sightRadius);
  }
}
