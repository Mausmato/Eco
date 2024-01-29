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
float minDistance = 50; // Minimum distance between objects
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

//void makeWaters() {
//  for (int i = 0; i < waters.length; i++) {
//    float waterSize = random(wWis, wWas);
//    waters[i] = new Water(waterSize, 7.5);
//  }
//}


void makePrey(int numPrey) {
  for (int i = 0; i < numPrey; i++) {
    preys.add(new Prey(3, 10, "Deer", wolves, foxes));  // Pass the wolves list
    preys.add(new Prey(4, 7.5, "Squirrel", foxes, wolves));  // Pass the foxes list
  }
}

void makePredators() {
  wolves.add(new Predator(2, 75, 4, "wolf"));  // Add more wolves if needed
  foxes.add(new Predator(3, 65, 1.2, "fox"));
}

void makeWaters() {
  for (int i = 0; i < waters.length; i++) {
    float waterSize = random(wWis, wWas);
    float x = random(width);
    float y = random(height);

    // Check if the new water position is too close to existing objects
    while (isOverlapping(x, y, waterSize)) {
      x = random(width);
      y = random(height);
    }

    waters[i] = new Water(x, y, waterSize, 7.5);
  }
}

void makeTrees() {
  for (int i = 0; i < trees.length; i++) {
    float treeSize = random(tMis, tMas);
    float x = random(width);
    float y = random(height);

    // Check if the new tree position is too close to existing objects
    while (isOverlapping(x, y, treeSize)) {
      x = random(width);
      y = random(height);
    }

    trees[i] = new Tree(x, y, treeSize, "TreeN");
  }
}

void makeEdibles() {
  for (int i = 0; i < edibles.length; i++) {
    float edibleSize = random(bMis, bMas);
    float x = random(width);
    float y = random(height);

    // Check if the new edible position is too close to existing objects
    while (isOverlapping(x, y, edibleSize)) {
      x = random(width);
      y = random(height);
    }

    edibles[i] = new Edible(x, y, edibleSize, "BushN");
  }
}

boolean isOverlapping(float x, float y, float size) {
  // Check if the new object overlaps with existing objects
  for (Tree t : trees) {
    if (t != null && dist(x, y, t.getX(), t.getY()) < size + t.getSize() + minDistance) {
      return true;
    }
  }

  for (Edible e : edibles) {
    if (e != null && dist(x, y, e.getX(), e.getY()) < size + e.getSize() + minDistance) {
      return true;
    }
  }

  for (Water w : waters) {
    if (w != null && dist(x, y, w.getX(), w.getY()) < size + w.getSize() + minDistance) {
      return true;
    }
  }

  return false;
}



void draw() {
  background(bg);

  for (Predator wolf : wolves) {
    wolf.drawMe();
    wolf.move();  // Make sure to call move even if resting
  }

  // Draw and move the foxes
  for (Predator fox : foxes) {
    fox.drawMe();
    fox.move();  // Make sure to call move even if resting
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
