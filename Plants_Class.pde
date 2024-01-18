class Plant {
  PVector pos, vel;
  Float size;
  boolean alive;
  String type;

  Plant(float si, String t) {
    this.size = si;
    this.pos = new PVector( random(0.2*width, 0.8*width), random(0.2*height, 0.8*height));
    this.type = t;

    //Add to this is more ideas come while programming
  }

  void drawMe() {
    if (type.equals("TreeN")) {
      image(TreeNA, pos.x, pos.y, size, size);
    }

    if (type.equals("TreeS")) {
      image(TreeSW, pos.x, pos.y, size, size);
    }

    if (type.equals("BushN")) {
      image(BushNA, pos.x, pos.y, size, size);
    }

    if (type.equals("BushS")) {
      image(BushSW, pos.x, pos.y, size, size);
    }

    if (type.equals("PineN")) {
      image(PineNA, pos.x, pos.y, size, size);
    }

    if (type.equals("PineS")) {
      image(PineSW, pos.x, pos.y, size, size);
    }
  }
}
