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

ArrayList<Predator> wolves = new ArrayList<Predator>();
ArrayList<Predator> foxes = new ArrayList<Predator>();
ArrayList<Prey> preys = new ArrayList<Prey>();
Tree[] trees = new Tree[25];
Edible[] edibles = new Edible[10];


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
  makeTrees();
  makeEdibles();
  makePrey(10);
}

void makePrey(int numPrey) {
  for (int i = 0; i < numPrey; i++) {
    preys.add(new Prey(3, 30, "Deer"));
    preys.add(new Prey(4, 20, "Squirrel"));
  }
}

void makePredators() {
  wolves.add(new Predator(1, 75, 4.23, "wolf"));
  wolves.add(new Predator(1, 75, 4.23, "wolf"));  // Add more wolves if needed
  
  foxes.add(new Predator(2, 65, 20, "fox"));
  foxes.add(new Predator(2, 65, 20, "fox"));  // Add more foxes if needed
}

void makeTrees() {
  for (int i = 0; i < trees.length; i++)
    trees[i] = new Tree(40, "TreeN");
}

void makeEdibles() {
  for (int i = 0; i < edibles.length; i++)
    edibles[i] = new Edible(30, "BushN");
}


void createWolf() {
  
  
}

void draw() {
  background(bg);
  
  for (Predator wolf : wolves) {
    wolf.drawMe();
    wolf.move();
  }

  // Draw and move the foxes
  for (Predator fox : foxes) {
    fox.drawMe();
    fox.move();
  }

  for (Prey p : preys) {
    p.drawMe();
    p.move();
  }

  for (Tree t : trees) {
    t.drawMe();
  }
  for (Edible e : edibles) {
    e.drawMe();
  }
}
