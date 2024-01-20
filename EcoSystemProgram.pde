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
PImage bg; 
PImage SquirrelR;
PImage SquirrelL;

Predator wo;
Predator fo;
ArrayList<Prey> preys = new ArrayList<Prey>();
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
  SquirrelR = loadImage("models/SquirrelR.png");
  SquirrelL = loadImage("models/SquirrelL.png");
  bg = loadImage("models/background.png");
  

  size(650, 650);

  createGUI();


  makePredators();
  makePlants();
  makePrey(5);
}

void makePrey(int numPrey) {
  for (int i = 0; i < numPrey; i++) {
    preys.add(new Prey(3, 30, "Deer"));
    preys.add(new Prey(4, 20, "Squirrel"));
  }
}
void makePredators() {
  wo = new Predator(5, 40.4, 4.23, "wolf");
  fo = new Predator(4, 40, 20, "fox");
}

void makePlants() {
  for (int i = 0; i < plants.length; i++)
    plants[i] = new Plant(60, "BushN");
}

void draw() {
  background(bg);
  wo.drawMe();
  fo.drawMe();
  wo.move();
  fo.move();

  for (Prey p : preys) {
    p.drawMe();
    p.move();
  }

  for (Plant p : plants) {
    p.drawMe();
  }
}
