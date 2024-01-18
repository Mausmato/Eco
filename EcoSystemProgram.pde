import g4p_controls.*;
PImage Wolf;
PImage Fox;
PImage Deer;
PImage BushNA;
PImage BushSW;
PImage TreeNA;
PImage TreeSW;
PImage PineNA;
PImage PineSW;

color fur = color(178, 120, 50);
Predator wolf2;

void setup() {
  Wolf = loadImage("models/WolfModel.png");
  Fox = loadImage("models/FoxModel.png");
  Deer = loadImage("models/DeerModel.png");
  BushNA = loadImage("models/Bush_NA.png");
  BushSW = loadImage("models/Bush_SW.png");
  TreeNA = loadImage("models/TreeModel_NA.png");
  TreeSW = loadImage("models/TreeModel_SW.png");
  PineNA = loadImage("models/Pine_NA.png");
  PineSW = loadImage("models/Pine_SW.png");

  size(650, 650);
  createGUI();
  wolf2 = new Predator(20.5, 40.4, 4.23, "wolf");
  wolf2.PStats();
}

void draw() {
  wolf2.drawMe();

}
