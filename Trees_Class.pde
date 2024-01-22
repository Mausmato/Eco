class Tree extends Plant {

  Tree(float si, String t) {
    super(si, t);

    this.size = si;
    this.pos = new PVector( random(0.05*width, 0.95*width), random(0.05*height, 0.95*height));
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

    if (type.equals("PineN")) {
      image(PineNA, pos.x, pos.y, size, size);
    }

    if (type.equals("PineS")) {
      image(PineSW, pos.x, pos.y, size, size);
    }
  }
}
