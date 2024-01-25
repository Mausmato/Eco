class Plant {
  PVector pos, vel;
  Float size;
  boolean alive;
  String type;

  Plant(float si, String t) {
    this.size = si;
    this.type = t;

    //Add to this is more ideas come while programming
  }

  float getSize() {
    return size;
  }
}
