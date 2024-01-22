class Edible extends Plant {

  Edible(float si, String t) {
    super(si, t);

    this.size = si;
    this.pos = new PVector( random(0.1*width, 0.9*width), random(0.1*height, 0.9*height));
    this.type = t;

    //Add to this is more ideas come while programming
  }

  void drawMe() {
    if (type.equals("BushN")) {
      image(BushNA, pos.x, pos.y, size, size);
    }

    if (type.equals("BushS")) {
      image(BushSW, pos.x, pos.y, size, size);
    }
  }
}
