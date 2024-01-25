class Water {
  float size, purity;
  PVector pos, vel;

  Water(float x, float y, float si, float pu) {
    this.size = si;
    this.pos = new PVector(random(0.05 * width, 0.95 * width), random(0.05 * height, 0.95 * height));
    this.purity = pu;
  }

  void drawMe() {
    image(Water, pos.x, pos.y, size, size);
  }

  float getX() {
    return pos.x;
  }

  float getY() {
    return pos.y;
  }

  float getSize() {
    return size;
  }
}
