class Predator extends Animal {
  float aggression; // Predators will attack depending on how aggressive they are + hunger levels
  String type;


  Predator(float s, float rad, float a, String t) {
    super(s, rad);
    this.aggression = a;
    this.type = t;

    // Call a method to configure the properties based on the type
    ConfigureType();
  }

  void ConfigureType() {
    if (type.equals("wolf")) {
      aggression *= 1.5; // Adjust the amplification factor as needed
      // image = wolf
      // speed amplified
      // radius amplified
    } else if (type.equals("fox")) {
      // image = fox
    }
  }

  void drawMe() {
    if (vel.x > 0) {
      if (type.equalsIgnoreCase("wolf")) {
        // Predator is moving to the right
        image(WolfR, pos.x, pos.y, 45, 45);
      } else if (type.equalsIgnoreCase("fox")) {
        // Predator is moving to the right
        image(FoxR, pos.x, pos.y, 45, 45);
      }
    } else if (vel.x < 0) {
      if (type.equalsIgnoreCase("wolf")) {
        // Predator is moving to the left
        image(WolfL, pos.x, pos.y, 45, 45);
      } else if (type.equalsIgnoreCase("fox")) {
        // Predator is moving to the left
        image(FoxL, pos.x, pos.y, 45, 45);
      }
    }
  }



  void move() {
    boolean spottedPrey = false;
    this.hunger += 0.02;

    // Iterate through the list of prey to find the nearest prey
    Prey nearestPrey = findNearestPrey();

    if (nearestPrey != null) {
      float distToPrey = this.pos.dist(nearestPrey.pos);

      if (distToPrey <= this.sightRadius && this.hunger > 0) {
        // Move towards the nearest prey
        headTowardsPrey(nearestPrey);
        spottedPrey = true;

        // Check if the predator caught the prey
        if (distToPrey < 15) {
          this.eat(nearestPrey);
        }
      }
    }


    if (!spottedPrey) {
      if (random(100) < 3) {
        pickRandDirection();
      }
    }

    if (!predatorInBounds()) {
      this.vel.mult(-1);
    }

    this.pos.add(this.vel);
  }


  // Method to check if the predator is within the canvas bounds
  boolean predatorInBounds() {
    return this.pos.x > 0
      && this.pos.x < width
      && this.pos.y > 0
      && this.pos.y < height;
  }

  void headTowardsPrey(Prey prey) {
    PVector displacement = PVector.sub(prey.pos, this.pos);
    float angle = displacement.heading();
    this.dir = new PVector(cos(angle), sin(angle));
    this.vel = this.dir.mult(this.speed);
  }
  // Method to eat the prey
  void eat(Prey victim) {
    println("Predator is eating!");

    victim.alive = false; // Mark the prey as not alive
    this.hunger -= 0.25;  // Decrease the predator's hunger
  }

  // Method to find the nearest prey
  Prey findNearestPrey() {
    Prey nearestPrey = null;
    float minDist = Float.MAX_VALUE;

    for (Prey p : preys) {
      if (p.alive) {
        float distToPrey = this.pos.dist(p.pos);

        if (distToPrey < minDist) {
          minDist = distToPrey;
          nearestPrey = p;
        }
      }
    }

    return nearestPrey;
  }
}
