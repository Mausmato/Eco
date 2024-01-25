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
PImage Water;
PImage FoxRL;
PImage FoxRR;
PImage WolfRL;
PImage WolfRR;

float wMis, wMas, fMis, fMas, dMis, dMas, sMis, sMas, bushMinSize, bMis, bMas, tMis, tMas, wWis, wWas;


ArrayList<Predator> wolves = new ArrayList<Predator>();
ArrayList<Predator> foxes = new ArrayList<Predator>();
ArrayList<Prey> preys = new ArrayList<Prey>();
Tree[] trees = new Tree[25];
Water[] waters = new Water[4]; // Array to store multiple water pools
Edible[] edibles = new Edible[10];

void loadSizesFromFile(String filename) {
  // Load the content of the file into an array of strings
  String[] lines = loadStrings(filename);

  // Parse the values from the lines
  wMis = Float.parseFloat(lines[4]);
  wMas = Float.parseFloat(lines[5]);
  fMis = Float.parseFloat(lines[9]);
  fMas = Float.parseFloat(lines[10]);
  dMis = Float.parseFloat(lines[14]);
  dMas = Float.parseFloat(lines[15]);
  sMis = Float.parseFloat(lines[19]);
  sMas = Float.parseFloat(lines[20]);
  bMis = Float.parseFloat(lines[24]);
  bMas = Float.parseFloat(lines[25]);
  tMis = Float.parseFloat(lines[29]);
  tMas = Float.parseFloat(lines[30]);
  wWis = Float.parseFloat(lines[34]);
  wWas = Float.parseFloat(lines[35]);
}
void setup() {
  size(650, 650);
  loadSizesFromFile("sizes.txt");
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
  Water = loadImage("models/water.png");
  FoxRL = loadImage("models/FoxRestL.png");
  FoxRR = loadImage("models/FoxRestR.png");
  WolfRL = loadImage("models/WolfRestL.png");
  WolfRR = loadImage("models/WolfRestR.png");


  size(650, 650);
  createGUI();

  //make the textfile make hte randomizer
  makePredators();
  makeTrees();
  makeEdibles();
  makeWaters();
  makePrey(18);
}

void makeWaters() {
  for (int i = 0; i < waters.length; i++) {
    float waterSize = random(wWis, wWas);
    waters[i] = new Water(waterSize, 7.5);
  }
}


void makePrey(int numPrey) {
  for (int i = 0; i < numPrey; i++) {
    preys.add(new Prey(3, 10, "Deer"));
    preys.add(new Prey(4, 7.5, "Squirrel"));
  }
}

void makePredators() {
  float wolfSize = random(wMis, wMas);
  wolves.add(new Predator(wolfSize, 75, 4.23, "wolf"));  // Add more wolves if needed

  float foxSize = random(fMis, fMas);
  foxes.add(new Predator(foxSize, 65, 10, "fox"));
}

void makeTrees() {
  for (int i = 0; i < trees.length; i++) {
    float treeSize = random(tMis, tMas);
    trees[i] = new Tree(treeSize, "TreeN");
  }
}

void makeEdibles() {
  for (int i = 0; i < edibles.length; i++) {
    float edibleSize = random(bMis, bMas);
    edibles[i] = new Edible(edibleSize, "BushN");
  }
}

Water wo = new Water(40, 7.5);


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


  for (Water water : waters) {
    water.drawMe();
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
