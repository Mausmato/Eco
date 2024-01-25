class Prey extends Animal {
  String type;
  Prey(float s, float rad, String t) {
    super(s, rad);
    this.type = t;
    this.alive = true;
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
