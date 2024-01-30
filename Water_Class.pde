class Water {
  float size, purity;
  PVector pos, vel;


//Constructor
  Water(float x, float y, float si, float pu) {
    this.size = si;
    this.pos = new PVector(random(0.05 * width, 0.95 * width), random(0.05 * height, 0.95 * height));
    this.purity = pu;
  }

//draw function
  void drawMe() {
    image(Water, pos.x, pos.y, size, size);
  }
//get x of water
  float getX() {
    return pos.x;
  }
//get y of water
  float getY() {
    return pos.y;
  }

  float getSize() {
    return size;
  }
}
