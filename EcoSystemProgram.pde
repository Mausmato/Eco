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
Animal wolf2;

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
  wolf2 = new Animal(20.5, 40.4);
  wolf2.PStats();
}

void draw() {
  background (145, 175, 105);
  image(Wolf, 3, 1, 45, 45);
  image(Fox, 60, 1, 45, 45);
  image(Deer, 140, 1, 45, 45);
  image(BushNA, 450, 1, 45, 45);
  image(Wolf, 3, 1, 45, 45);
  image(Wolf, 3, 1, 45, 45);
  image(Wolf, 3, 1, 45, 45);
  image(Wolf, 3, 1, 45, 45);
  image(Wolf, 3, 1, 45, 45);
  image(Wolf, 3, 1, 45, 45);
  image(Wolf, 3, 1, 45, 45);
}
