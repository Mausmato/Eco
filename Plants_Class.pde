class Plant {
  //vars
  PVector pos, vel;
  Float size;
  boolean alive;
  String type;

//constructor
  Plant(float si, String t) {
    this.size = si;
    this.type = t;

    //Add to this is more ideas come while programming
  }


//gets the size of plant
  float getSize() {
    return size;
  }
}
