class Predator extends Animal {
  //vars

  float aggression;
  String type;
  float hunger;
  float restTimer = 0;
  boolean resting = false;
  float lastRestTime = 0;
  float wolfSize = random(wMis, wMas);
  float foxSize = random(fMis, fMas);
  float thirst = 0;

  //constructor
  Predator(float s, float rad, float a, String t) {
    super(s, rad);
    this.aggression = a;
    this.type = t;
    this.hunger = 0;

    ConfigureType();

    this.pos = new PVector(random(0.2 * width, 0.8 * width), random(0.2 * height, 0.8 * height));
  }


  //finds the type of pred
  void ConfigureType() {
    if (type.equals("wolf")) {
      vel.x = vel.x*0.5;
    } else if (type.equals("fox")) {
      // image = fox
    }
  }

  //draw function
  void drawMe() {
    if (!alive) {
      drawDeadMarker(type);

      return;
    }

    // Check if the predator is resting
    if (resting) {
      //pauses them
      if (type.equalsIgnoreCase("wolf")) {
        if (vel.x > 0) {
          image(WolfR, pos.x, pos.y, 35, 35);
        } else {
          image(WolfL, pos.x, pos.y, 35, 35);
        }
      } else if (type.equalsIgnoreCase("fox")) {
        if (vel.x > 0) {
          image(FoxR, pos.x, pos.y, 30, 30);
        } else {
          image(FoxL, pos.x, pos.y, 30, 30);
        }
      }
    }
     else//Not resting
    {
      if (vel.x > 0) {
        if (type.equalsIgnoreCase("wolf")) {
          image(WolfR, pos.x, pos.y, wolfSize, wolfSize);
        } else if (type.equalsIgnoreCase("fox")) {
          //sizing
          image(FoxR, pos.x, pos.y, 30, 30);
        }
      } else if (vel.x < 0) {
        if (type.equalsIgnoreCase("wolf")) {
          image(WolfL, pos.x, pos.y, wolfSize, wolfSize);
        } else if (type.equalsIgnoreCase("fox")) {
          image(FoxL, pos.x, pos.y, foxSize, foxSize);
        }
      }
    }
  }


  //movement
  void move() {
    //if it is dead (DEAD MARKER)
    if (!alive) {
      drawDeadMarker(type);
      return;
    }

    // Increase hunger over time
    hunger += 0.025;
    thirst += 0.005;

    // Check if the predator should rest
    if (hunger <= 4) {
      // Rest for 3 seconds
      restTimer += millis() - lastRestTime;
      lastRestTime = millis();

      if (restTimer >= 3000) {
        resting = false;
        restTimer = 0;
        pickRandDirection();
      } else {
        rest();
        return;
      }
    }

    // Reg Movement if no prey
    boolean spottedPrey = false;

    // Iterate through the list of prey to find the nearest prey
    Prey nearestPrey = findNearestPrey(preys);

    if (nearestPrey != null) {
      float distToPrey = this.pos.dist(nearestPrey.pos);

      if (distToPrey <= this.sightRadius && this.hunger > 0) {
        this.headTowardsPrey(nearestPrey);
        spottedPrey = true;

        if (distToPrey < 15) {
          this.eat(nearestPrey);
        }
      }
    }
    //if prey not spotted
    if (!spottedPrey) {
      if (random(100) < 3) {
        pickRandDirection();
      }
    }
    //die if too hungry
    if (hunger > 25) {
      alive = false;
      drawDeadMarker(type);
      return;
    }

    // Drinking logic for predators
    for (Water water : waters) {
      float distToWater = this.pos.dist(water.pos);
      if (distToWater <= this.sightRadius && this.thirst > 5) {
        this.headTowardsWater(water);
        drink(water);
      }
    }

    PVector nextPos = new PVector(pos.x + vel.x, pos.y + vel.y);

    if (nextPos.x < 0 || nextPos.x > width || nextPos.y < 0 || nextPos.y > height) {
      vel.mult(-1);
    } else {
      pos.add(vel);
    }
  }

  //go to water
  void headTowardsWater(Water water) {
    PVector displacement = PVector.sub(water.pos, this.pos);
    float angle = displacement.heading();
    this.dir = new PVector(cos(angle), sin(angle));
    this.vel = this.dir.mult(this.speed);
  }

  //keeps in bounds
  boolean predatorInBounds() {
    return this.pos.x > 0 && this.pos.x < width && this.pos.y > 0 && this.pos.y < height;
  }

  //dead drawing
  void drawDeadMarker(String predatorType) {
    stroke(255, 0, 0);
    line(pos.x - 6, pos.y - 6, pos.x + 6, pos.y + 6);
    line(pos.x - 6, pos.y + 6, pos.x + 6, pos.y - 6);

    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(predatorType + " dead", pos.x, pos.y - 20);
  }
  //go towards prey
  void headTowardsPrey(Prey prey) {
    PVector displacement = PVector.sub(prey.pos, this.pos);
    float angle = displacement.heading();
    this.dir = new PVector(cos(angle), sin(angle));
    this.vel = this.dir.mult(this.speed);
  }

  void eat(Prey victim) {
    if (alive) {
      println(this.hunger);
      victim.alive = false;
      this.hunger -= 2;
    }
  }

  //finds the closest prey
  Prey findNearestPrey(ArrayList<Prey> preyList) {
    Prey nearestPrey = null;
    float minDist = Float.MAX_VALUE;

    for (Prey p : preyList) {
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


  //drink water function
  void drink(Water water) {
    if (alive) {
      float distToWater = this.pos.dist(water.pos);
      if (distToWater < 10) {
        this.thirst -= 0.25;
        // Decrease thirst when drinking
      }
      if (this.thirst > 15) {
        alive = false;
      }
    }
  }
  //finds the type of pred
void runAwayFromMouse() {
  PVector mousePos = new PVector(mouseX, mouseY);
  PVector direction = PVector.sub(pos, mousePos).normalize();
  vel = direction.mult(speed * 2);  // Increase speed for a stronger run-away effect
}
  //resting function
  void rest() {
    // Display resting images based on the predator type
    if (type.equalsIgnoreCase("wolf")) {
      if (vel.x > 0) {
        image(WolfR, pos.x, pos.y, 35, 35);
      } else {
        image(WolfL, pos.x, pos.y, 35, 35);
      }
    } else if (type.equalsIgnoreCase("fox")) {
      if (vel.x > 0) {
        image(FoxR, pos.x, pos.y, 30, 30);
      } else {
        image(FoxL, pos.x, pos.y, 30, 30);
      }
    }
  }
}
