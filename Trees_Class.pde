class Tree extends Plant {

  
  //constructor
  Tree(float x, float y, float si, String t) {
    super(si, t);

    this.size = si;
    this.pos = new PVector(random(0.05 * width, 0.95 * width), random(0.05 * height, 0.95 * height));
    this.type = t;

    // Add to this if more ideas come while programming
  }


//drawing the trees based on the type
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


//get x of the trree
  float getX() {
    return pos.x;
  }


//get y of the tree
  float getY() {
    return pos.y;
  }
}
