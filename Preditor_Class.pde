class Predator extends Animal {
  float aggression;
  String type;
  float hunger;
  float restTimer = 0;
  boolean resting = false;
  float lastRestTime = 0;
  float wolfSize = random(wMis, wMas);
  float foxSize = random(fMis, fMas);

  Predator(float s, float rad, float a, String t) {
    super(s, rad);
    this.aggression = a;
    this.type = t;
    this.hunger = 0;

    ConfigureType();
  }

  void ConfigureType() {
    if (type.equals("wolf")) {
      aggression *= 1.5;
    } else if (type.equals("fox")) {
      // image = fox
    }
  }

  void drawMe() {
    if (!alive) {
      drawDeadMarker();
      return;
    }

    // Check if the predator is resting
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
          image(WolfR, pos.x, pos.y, wolfSize, wolfSize);
        } else if (type.equalsIgnoreCase("fox")) {
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




  void move() {
    if (!alive) {
      drawDeadMarker();
      return;
    }

    // Increase hunger over time
    hunger += 0.025;

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

    // Continue with regular movement if not resting
    boolean spottedPrey = false;

    // Iterate through the list of prey to find the nearest prey
    Prey nearestPrey = findNearestPrey();

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

    if (!spottedPrey) {
      if (random(100) < 3) {
        pickRandDirection();
      }
    }

    if (hunger > 25) {
      alive = false;
      drawDeadMarker();
      return;
    }

    PVector nextPos = new PVector(pos.x + vel.x, pos.y + vel.y);

    if (nextPos.x < 0 || nextPos.x > width || nextPos.y < 0 || nextPos.y > height) {
      vel.mult(-1);
    } else {
      pos.add(vel);
    }
  }

  boolean predatorInBounds() {
    return this.pos.x > 0 && this.pos.x < width && this.pos.y > 0 && this.pos.y < height;
  }

  void drawDeadMarker() {
    stroke(255, 0, 0);
    line(pos.x - 6, pos.y - 6, pos.x + 6, pos.y + 6);
    line(pos.x - 6, pos.y + 6, pos.x + 6, pos.y - 6);

    fill(255, 0, 0);
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

  void eat(Prey victim) {
    if (alive) {
      println("Eatin");
      println(this.hunger);
      victim.alive = false;
      this.hunger -= 2;
    }
  }

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
