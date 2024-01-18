import g4p_controls.*;
PImage WolfL;
PImage WolfR;
PImage FoxL;
PImage FoxR;
PImage DeerL;
PImage DeerR;
PImage BushNA;
PImage BushSW;
PImage TreeNA;
PImage TreeSW;
PImage PineNA;
PImage PineSW;

Predator wo;
Predator fo;
Prey de;
Plant[] plants = new Plant[10];

void setup() {
  WolfL = loadImage("models/WolfModelLeft.png");
  FoxL = loadImage("models/FoxModelLeft.png");
  WolfR = loadImage("models/WolfModelRight.png");
  FoxR = loadImage("models/FoxModelRight.png");
  DeerL = loadImage("models/DeerModelLeft.png");
  DeerR = loadImage("models/DeerModelRight.png");
  BushNA = loadImage("models/Bush_NA.png");
  BushSW = loadImage("models/Bush_SW.png");
  TreeNA = loadImage("models/TreeModel_NA.png");
  TreeSW = loadImage("models/TreeModel_SW.png");
  PineNA = loadImage("models/Pine_NA.png");
  PineSW = loadImage("models/Pine_SW.png");

  size(650, 650);

  createGUI();


  makePredators();

  makePlants();

  makePrey();
}

void makePrey() {
  de = new Prey(3, 30, "Deer");
}

void makePredators() {
  wo = new Predator(20.5, 40.4, 4.23, "wolf");
  fo = new Predator(70, 40, 20, "fox");
}

void makePlants() {
  for (int i = 0; i < plants.length; i++)
    plants[i] = new Plant(60, "PineN");
}
void draw() {
  background(120, 225, 40);
  wo.drawMe();
  fo.drawMe();
  wo.move();

  de.drawMe();
  de.move();
  for (Plant p : plants) {
    p.drawMe();
  }
}
