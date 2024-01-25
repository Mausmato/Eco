class Predator extends Animal {
  float aggression; // Predators will attack depending on how aggressive they are + hunger levels
  String type;
  float hunger; // Added hunger variable for each predator
  float restTimer = 0; // Timer for resting
  boolean resting = false;
  float lastRestTime = 0;

  Predator(float s, float rad, float a, String t) {
    super(s, rad);
    this.aggression = a;
    this.type = t;
    this.hunger = 0;

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
    if (!alive) {
      drawDeadMarker();
      return;
    }

    if (resting) {
      // Draw resting images based on the predator type
      if (type.equalsIgnoreCase("wolf")) {
        if (vel.x > 0) {
          image(WolfRR, pos.x, pos.y, 35, 35);
        } else {
          image(WolfRL, pos.x, pos.y, 35, 35);
        }
      } else if (type.equalsIgnoreCase("fox")) {
        if (vel.x > 0) {
          image(FoxRR, pos.x, pos.y, 30, 30);
        } else {
          image(FoxRL, pos.x, pos.y, 30, 30);
        }
      }
    } else {
      // Draw regular images based on the predator type and movement direction
      if (vel.x > 0) {
        if (type.equalsIgnoreCase("wolf")) {
          image(WolfR, pos.x, pos.y, 35, 35);
        } else if (type.equalsIgnoreCase("fox")) {
          image(FoxR, pos.x, pos.y, 30, 30);
        }
      } else if (vel.x < 0) {
        if (type.equalsIgnoreCase("wolf")) {
          image(WolfL, pos.x, pos.y, 35, 35);
        } else if (type.equalsIgnoreCase("fox")) {
          image(FoxL, pos.x, pos.y, 30, 30);
        }
      }
    }
  }

  void move() {
    // Check if the predator is still alive
    if (!alive) {
      drawDeadMarker();
      return;
    }

    if (resting) {
      // If resting, increment the rest timer using millis()
      restTimer += millis() - lastRestTime;
      lastRestTime = millis(); // Update the last rest time

      // Wolves start roaming after x seconds of rest
      if (restTimer >= 5000) { // x  milliseconds is equivalent to x/1000 seconds
        resting = false;
        restTimer = 0;
        pickRandDirection(); // Resume movement after resting
      }
    } else {
      // Increase hunger over time
      hunger += 0.025;

      // Check if the predator should rest
      if (hunger <= 4) {
        resting = true;
        restTimer = 0;
        lastRestTime = millis(); // Set the initial rest time
        rest();
        return; // Stop further actions if the predator is resting
      }
    }

    // Continue with regular movement if not resting
    boolean spottedPrey = false;

    // Increase hunger over time
    this.hunger += 0.025;

    // Iterate through the list of prey to find the nearest prey
    Prey nearestPrey = findNearestPrey();

    if (nearestPrey != null) {
      float distToPrey = this.pos.dist(nearestPrey.pos);

      if (distToPrey <= this.sightRadius && this.hunger > 0) {
        // Move towards the nearest prey
        this.headTowardsPrey(nearestPrey);
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

    if (hunger > 25) {
      alive = false;
      drawDeadMarker();
      return; // Stop further actions if the predator is not alive
    }

    // Calculate the next position
    PVector nextPos = new PVector(pos.x + vel.x, pos.y + vel.y);

    // Check and adjust for border collisions
    if (nextPos.x < 0 || nextPos.x > width || nextPos.y < 0 || nextPos.y > height) {
      // Adjust the direction to avoid walking into the wall
      vel.mult(-1);
    } else {
      // Update the position
      pos.add(vel);
    }
  }

  // Method to check if the predator is within the canvas bounds
  boolean predatorInBounds() {
    return this.pos.x > 0
      && this.pos.x < width
      && this.pos.y > 0
      && this.pos.y < height;
  }
  void drawDeadMarker() {
    // Draw an X at the position where the predator died
    stroke(255, 0, 0); // Red stroke color
    line(pos.x - 6, pos.y - 6, pos.x + 6, pos.y + 6);
    line(pos.x - 6, pos.y + 6, pos.x + 6, pos.y - 6);

    // Display "wolf dead" text on top
    fill(255, 0, 0); // Red fill color
    textAlign(CENTER, CENTER);
    textSize(12);
    text("wolf dead", pos.x, pos.y - 20);
  }
  void headTowardsPrey(Prey prey) {
    PVector displacement = PVector.sub(prey.pos, this.pos);
    float angle = displacement.heading();
    this.dir = new PVector(cos(angle), sin(angle));
    this.vel = this.dir.mult(this.speed);
  }
  // Method to eat the prey
  void eat(Prey victim) {
    if (alive) {

      println("Eatin");
      println(this.hunger);
      victim.alive = false; // Mark the prey as not alive
      this.hunger -= 2;  // Decrease the predator's hunger
    }
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

  void rest() {
    // Reset velocity to 0 when resting
    vel.set(0, 0);

    // Display resting images based on the predator type
    if (type.equalsIgnoreCase("wolf")) {
      if (vel.x > 0) {
        image(WolfRR, pos.x, pos.y, 35, 35);
      } else {
        image(WolfRL, pos.x, pos.y, 35, 35);
      }
    } else if (type.equalsIgnoreCase("fox")) {
      if (vel.x > 0) {
        image(FoxRR, pos.x, pos.y, 30, 30);
      } else {
        image(FoxRL, pos.x, pos.y, 30, 30);
      }
    }
  }
}
