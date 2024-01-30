class Edible extends Plant {
//constructor
  Edible(float x, float y, float si, String t) {
    super(si, t);

    this.size = si;
    this.pos = new PVector(random(0.1 * width, 0.9 * width), random(0.1 * height, 0.9 * height));
    this.type = t;

    // Add to this if more ideas come while programming
  }
//draw methoid
  void drawMe() {
    if (type.equals("BushN")) {
      image(BushNA, pos.x, pos.y, size, size);
    }

    if (type.equals("BushS")) {
      image(BushSW, pos.x, pos.y, size, size);
    }
  }
//geting x coord
  float getX() {
    return pos.x;
  }
//getting y coord
  float getY() {
    return pos.y;
  }
}
