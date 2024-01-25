class Prey extends Animal {
  String type;
  ArrayList<Predator> foxes;
  ArrayList<Predator> wolves;
  boolean isAccelerating = false;
  float accelerationTimer = 0;
  float accelerationDuration = 2.0;  // Duration of acceleration in seconds
  float normalSpeed;  // Store the normal speed for the prey

  Prey(float s, float rad, String t, ArrayList<Predator> foxes, ArrayList<Predator> wolves) {
    super(s, rad);
    this.type = t;
    this.alive = true;
    this.foxes = foxes;
    this.wolves = wolves;
    this.normalSpeed = this.speed;
    // Call a method to configure the properties based on the type
  }

  void drawMe() {
    if (alive) {  // Check if the prey is alive before drawing
      if (vel.x > 0) {
        if (type.equalsIgnoreCase("deer")) {
          // Prey is moving to the right
          image(DeerR, pos.x, pos.y, 30, 30);
        }
        // Add other drawing logic for different prey types if needed
      } else if (vel.x < 0) {
        if (type.equalsIgnoreCase("deer")) {
          // Prey is moving to the left
          image(DeerL, pos.x, pos.y, 30, 30);
        }
        // Add other drawing logic for different prey types if needed
      }
      if (vel.x > 0) {
        if (type.equalsIgnoreCase("squirrel")) {
          // Prey is moving to the right
          image(SquirrelR, pos.x, pos.y, 27.5, 27.5);
        }
        // Add other drawing logic for different prey types if needed
      } else if (vel.x < 0) {
        if (type.equalsIgnoreCase("squirrel")) {
          // Prey is moving to the left
          image(SquirrelL, pos.x, pos.y, 27.5, 27.5);
        }
        // Add other drawing logic for different prey types if needed
      }
    }
  }
  void move() {
    if (!alive) {
      drawDeadMarker();
      return;
    }
    boolean spottedEdible = false;

    runAwayFromPredators();
    // Check for predators in range and run away
    runAwayFromPredators();

    // Check if acceleration is active
    if (isAccelerating) {
      // Increment the acceleration timer
      accelerationTimer += 0.02;

      // Check if acceleration duration is reached
      if (accelerationTimer >= accelerationDuration) {
        // Reset acceleration
        isAccelerating = false;
        accelerationTimer = 0;

        // Reset to normal speed
        this.speed = normalSpeed;
      } else {
        // Apply acceleration (increase speed)
        this.speed += 0.01;
      }
    }


    this.hunger += 0.02;
    for (Edible ed : edibles) {
      float distToEdible = this.pos.dist(ed.pos);

      if (distToEdible <= this.sightRadius && this.hunger > 0 && ed.size > 0) {
        this.headTowards(ed);
        spottedEdible = true;
      }

      if (distToEdible < 6) {
        this.eat(ed);
      }
    }

    if (!spottedEdible) {
      if (random(100) < 3) {
        pickRandDirection();
      }
    }
    PVector nextPos = new PVector(this.pos.x + this.vel.x, this.pos.y + this.vel.y);

    // Check and adjust for border collisions
    if (nextPos.x < 0 || nextPos.x > width || nextPos.y < 0 || nextPos.y > height) {
      // Adjust the direction to avoid walking into the wall
      this.vel.mult(-1);
    } else {
      // Update the position
      this.pos.add(this.vel);
    }
  }


  void pickRandDirection() {
    float angle = random(0, TWO_PI);
    this.dir = new PVector( cos(angle), sin(angle) );  //Unit vector pointing in the randomly chosen angle
    this.vel = this.dir.mult( this.speed );  //Velocity = the unit vector multiplied by how fast you move
  }

  //7
  //Head towards works by chhanging the data of the PVector of the rabbit to aim towards the plant[i]
  void headTowards( Edible e ) {
    PVector displacement = PVector.sub(e.pos, this.pos);
    float angle = displacement.heading();
    this.dir = new PVector( cos(angle), sin(angle) );
    this.vel = this.dir.mult( this.speed );
  }

  // Create a function to run away void runAway ( Preditor p) {}


  boolean preyInBounds() {
    return this.pos.x > 0
      && this.pos.x < width
      && this.pos.y > 0
      && this.pos.x < height;
  }

  void runAwayFromPredators() {
    // Run away from foxes
    for (Predator fox : foxes) {
      float distToFox = this.pos.dist(fox.pos);

      if (distToFox <= this.sightRadius && distToFox < fox.sightRadius) {
        // Fox is within the prey's range, run away from it
        PVector foxDir = PVector.sub(this.pos, fox.pos).normalize();
        this.vel = foxDir.mult(this.speed);

        // Activate acceleration
        isAccelerating = true;
        accelerationTimer = 0;
        this.speed = normalSpeed + 0.5;  // You can adjust the acceleration factor
      }
    }

    // Run away from wolves
    for (Predator wolf : wolves) {
      float distToWolf = this.pos.dist(wolf.pos);
      if (distToWolf <= this.sightRadius && distToWolf < wolf.sightRadius) {
        // Wolf is within the prey's range, run away from it
        PVector wolfDir = PVector.sub(this.pos, wolf.pos).normalize();
        this.vel = wolfDir.mult(this.speed);

        // Activate acceleration
        isAccelerating = true;
        accelerationTimer = 0;
        this.speed = normalSpeed + 0.5;  // You can adjust the acceleration factor
      }
    }
  }

  void drawDeadMarker() {
    // Draw an X at the position where the predator died
    stroke(255, 255, 0); // Red stroke color
    line(pos.x - 6, pos.y - 6, pos.x + 6, pos.y + 6);
    line(pos.x - 6, pos.y + 6, pos.x + 6, pos.y - 6);

    // Display "wolf dead" text on top
    fill(255, 255, 0); // Red fill color
    textAlign(CENTER, CENTER);
    textSize(12);
    text("prey dead", pos.x, pos.y - 20);
  }

  void eat( Edible victim ) {
    if (alive) {
      victim.size -= 0.4;
      this.hunger -= 0.1;
    }
    if (this.hunger > 20) {
      alive = false;
    }
  }
}
