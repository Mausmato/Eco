class Prey extends Animal {
  //variables
  String type;
  ArrayList<Predator> foxes;
  ArrayList<Predator> wolves;
  boolean isAccelerating = false;
  float accelerationTimer = 0;
  float accelerationDuration = 2.0;  // Duration of acceleration in seconds
  float normalSpeed;  // Store the normal speed for the prey
  float thirst = 0;


//constructor
  Prey(float s, float rad, String t, ArrayList<Predator> foxes, ArrayList<Predator> wolves) {
    super(s, rad);
    this.type = t;
    this.alive = true;
    this.foxes = foxes;
    this.wolves = wolves;
    this.normalSpeed = this.speed;
    // Call a method to configure the properties based on the type
  }

//drawprey function
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
  
  //move prey function
  void move() {
    if (!alive) {
      drawDeadMarker();
      return;
    }
    //spottedf edible
    boolean spottedEdible = false;

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


    thirst += 0.025;  // Increase thirst over time
    hunger += 0.02;  //increase hunger
    
    //find the edibles
    for (Edible ed : edibles) {
      float distToEdible = this.pos.dist(ed.pos);

      if (distToEdible <= this.sightRadius && this.hunger >= 5 && ed.size > 0) {
        this.headTowards(ed);
        spottedEdible = true;
      }

      if (distToEdible < 6) {
        this.eat(ed);
      }
    }
    
    //find water
    for (Water water : waters) {
      float distToWater = this.pos.dist(water.pos);

      if (distToWater <= this.sightRadius && this.thirst > 5) {
        this.headTowards(water);
        spottedEdible = true;

        // Drink when close to water
        drink(water);
      }
    }
//random movement if no spotted things
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

//rand Dir Functions
  void pickRandDirection() {
    float angle = random(0, TWO_PI);
    this.dir = new PVector( cos(angle), sin(angle) );  
    this.vel = this.dir.mult( this.speed ); 
  }

  //7
  //Head towards edibles
  void headTowards( Edible e ) {
    PVector displacement = PVector.sub(e.pos, this.pos);
    float angle = displacement.heading();
    this.dir = new PVector( cos(angle), sin(angle) );
    this.vel = this.dir.mult( this.speed );
  }
//Head towards water
  void headTowards(Water water) {
    PVector displacement = PVector.sub(water.pos, this.pos);
    float angle = displacement.heading();
    this.dir = new PVector(cos(angle), sin(angle));
    this.vel = this.dir.mult(this.speed);
  }

//kleeps in bounds
  boolean preyInBounds() {
    return this.pos.x > 0
      && this.pos.x < width
      && this.pos.y > 0
      && this.pos.x < height;
  }

//run from predators
  void runAwayFromPredators() {
    // Run away from alive foxes
    for (Predator fox : foxes) {
      if (fox.alive) {  // Check if the fox is alive
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
    }

    // Run away from  wolves
    for (Predator wolf : wolves) {
      if (wolf.alive) {  // Check if the wolf is alive
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
  }


//Dead marker if dead
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

//Drinking water
  void drink(Water water) {
    if (alive) {
      float distToWater = this.pos.dist(water.pos);
      if (distToWater < 10) {
        this.thirst -= 2;
        // Decrease thirst when drinking
      }
      println(this.thirst);
      if (this.thirst > 15) {
        alive = false;
              println("dead to thirst");

      }
    }
  }
  
  //Running away function
void runAwayFromMouse() {
  PVector mousePos = new PVector(mouseX, mouseY);
  PVector direction = PVector.sub(pos, mousePos).normalize();
  vel = direction.mult(speed * 2);  // Increase speed for a stronger run-away effect
  isAccelerating = true;
  accelerationTimer = 0;
  speed = normalSpeed + 1.0;  // Adjust the acceleration factor for Prey
}

//eating
  void eat( Edible victim ) {
    if (alive) {
      victim.size -= 0.1;
      this.hunger -= 0.085;
    }
    if (this.hunger > 15) {
      alive = false;
      println("dead to hunger");
    }
  }
}
