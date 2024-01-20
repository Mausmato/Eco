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
          image(DeerR, pos.x, pos.y, 45, 45);
        }
        // Add other drawing logic for different prey types if needed
      } else if (vel.x < 0) {
        if (type.equalsIgnoreCase("deer")) {
          // Prey is moving to the left
          image(DeerL, pos.x, pos.y, 45, 45);
        }
        // Add other drawing logic for different prey types if needed
      }
      if (vel.x > 0) {
        if (type.equalsIgnoreCase("squirrel")) {
          // Prey is moving to the right
          image(SquirrelR, pos.x, pos.y, 45, 45);
        }
        // Add other drawing logic for different prey types if needed
      } else if (vel.x < 0) {
        if (type.equalsIgnoreCase("squirrel")) {
          // Prey is moving to the left
          image(SquirrelL, pos.x, pos.y, 45, 45);
        }
        // Add other drawing logic for different prey types if needed
      }
    }
  }
  void move() {
    boolean spottedPlant = false;
    this.hunger += 0.02;

    for (Plant pl : plants) {
      float distToPlant = this.pos.dist(pl.pos);

      if (distToPlant <= this.sightRadius && this.hunger > 0 && pl.size > 0) {
        this.headTowards(pl);
        spottedPlant = true;
      }

      if (distToPlant < 15) {
        this.eat(pl);
      }
    }

    if (!spottedPlant) {
      if (random(100) < 3) {
        pickRandDirection();
      }
    }

    if (!preyInBounds()) {
      this.vel.mult(-1);
    }

    this.pos.add(this.vel);
  }


  void pickRandDirection() {
    float angle = random(0, TWO_PI);
    this.dir = new PVector( cos(angle), sin(angle) );  //Unit vector pointing in the randomly chosen angle
    this.vel = this.dir.mult( this.speed );  //Velocity = the unit vector multiplied by how fast you move
  }

  //7
  //Head towards works by chhanging the data of the PVector of the rabbit to aim towards the plant[i]
  void headTowards( Plant p ) {
    PVector displacement = PVector.sub(p.pos, this.pos);
    float angle = displacement.heading();
    this.dir = new PVector( cos(angle), sin(angle) );
    this.vel = this.dir.mult( this.speed );
  }

  //8
  boolean preyInBounds() {
    return this.pos.x > 0
      && this.pos.x < width
      && this.pos.y > 0
      && this.pos.x < height;
  }


  void eat( Plant victim ) {
    if (alive) {
      victim.size -= 0.1;
      this.hunger -= 0.25;
    }
  }
}
