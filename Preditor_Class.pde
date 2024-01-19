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
    if (type.equals("wolf")) {
      // Draw the wolf image
      image(WolfL, pos.x, pos.y, 45, 45);
    }
    if (type.equals("fox")) {
      // Draw the wolf image
      image(FoxL, pos.x, pos.y, 45, 45);
    }

    // Add other drawing logic for different predator types if needed
  }

  void move() {

    if (random(100) < 3) {
      pickRandDirection();
    }
  }

  // You can add a draw method here or in Animal class if needed
}
