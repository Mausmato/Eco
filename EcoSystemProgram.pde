// Import G4P library for GUI controls
import g4p_controls.*;

// Images
PImage WolfL, WolfR, FoxL, FoxR, DeerL, DeerR, BushNA, BushSW, TreeNA, TreeSW, PineNA, PineSW, bg, SquirrelR, SquirrelL, Water, FoxRL, FoxRR, WolfRL, WolfRR;

// Vars for size
float minDistance = 50; // Min distance
float wMis, wMas, fMis, fMas, dMis, dMas, sMis, sMas, bushMinSize, bMis, bMas, tMis, tMas, wWis, wWas;

// Booleans
boolean programRunning = true;

// Arrays and ArrayLists
ArrayList<Predator> wolves = new ArrayList<>();
ArrayList<Predator> foxes = new ArrayList<>();
ArrayList<Predator> predators = new ArrayList<Predator>();
ArrayList<Prey> preys = new ArrayList<Prey>();
Tree[] trees = new Tree[25];  //EDIT THESE
Edible[] edibles = new Edible[25]; //EDIT THESE
Water[] waters = new Water[4]; //EDIT THESE
int twa, tfa, tda, tsa;

// Load sizes from a file
void loadSizesFromFile(String filename) {
  // Load file into an array
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

// Setup function
void setup() {
  size(650, 650);
  loadSizesFromFile("sizes.txt");
  // Load images
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

  // Call functions
  createGUI();
  makeEdibles();
  makeTrees();
  makeWaters();

  // Combine wolves and foxes into the predators list
  predators.addAll(wolves);
  predators.addAll(foxes);

  programRunning = true;
  draw();
  programRunning = false;
}

void keyPressed() {
  if (key == ' ') {
    // Toggle the program state when spacebar is pressed (pause / play)
    programRunning = !programRunning;
  }
}

void mouseClicked() {
  println("Mouse Clicked!");

  // Debug prints for predators
  println("Predators:");
  for (Predator predator : predators) {
    println("Predator type: " + predator.type + ", Position: " + predator.pos);
    float distToMouse = predator.pos.dist(new PVector(mouseX, mouseY));
    println("Distance to mouse: " + distToMouse + ", Sight radius: " + predator.sightRadius);
    if (distToMouse <= predator.sightRadius+30) {
      println("Running away from mouse: " + predator.type);
      predator.runAwayFromMouse();
    }
  }

  // Debug prints for preys
  println("Preys:");
  for (Prey prey : preys) {
    println("Prey type: " + prey.type + ", Position: " + prey.pos);
    float distToMouse = prey.pos.dist(new PVector(mouseX, mouseY));
    println("Distance to mouse: " + distToMouse + ", Sight radius: " + prey.sightRadius);
    if (distToMouse <= prey.sightRadius) {
      println("Running away from mouse: " + prey.type);
      prey.runAwayFromMouse();
    }
  }
}

// Create water
void makeWaters() {
  for (int i = 0; i < waters.length; i++) {
    float waterSize = random(wWis, wWas);
    float x = random(width);
    float y = random(height);

    // Overlaps
    while (isOverlapping(x, y, waterSize)) {
      x = random(width);
      y = random(height);
    }

    waters[i] = new Water(x, y, waterSize, 7.5);
  }
}

// Create Trees
void makeTrees() {
  for (int i = 0; i < trees.length; i++) {
    float treeSize = random(tMis, tMas);
    float x = random(width);
    float y = random(height);

    // Overlaps
    while (isOverlapping(x, y, treeSize)) {
      x = random(width);
      y = random(height);
    }

    trees[i] = new Tree(x, y, treeSize, "TreeN");
  }
}

// Edibles
void makeEdibles() {
  for (int i = 0; i < edibles.length; i++) {
    float edibleSize = random(bMis, bMas);
    float x = random(width);
    float y = random(height);

    // Overlaps
    while (isOverlapping(x, y, edibleSize)) {
      x = random(width);
      y = random(height);
    }

    edibles[i] = new Edible(x, y, edibleSize, "BushN");
  }
}

// Spawns
void spawnEntity(String entityType) {
  float x = random(width);
  float y = random(height);
  float entitySize = 5;
  Predator predator = null;

  // Overlaps
  while (isOverlapping(x, y, entitySize)) {
    x = random(width);
    y = random(height);
  }

  // Picker
  switch (entityType) {
  case "wolf":
    predator = new Predator(2, 60, 3, "wolf");
    wolves.add(predator);
    break;
  case "fox":
    predator = new Predator(3, 60, 5, "fox");
    foxes.add(predator);
    break;
  case "deer":
    preys.add(new Prey(3, 60, "deer", foxes, wolves));
    break;
  case "squirrel":
    preys.add(new Prey(2, 40, "squirrel", foxes, wolves));
    break;
  }


  // Add the predator to the general predators list
  if (predator != null) {
    predators.add(predator);
  }

  if (entityType.equals("wolf")) {
    twa++;
  } else if (entityType.equals("fox")) {
    tfa++;
  } else if (entityType.equals("deer")) {
    tda++;
  } else if (entityType.equals("squirrel")) {
    tsa++;
  }
}

//overlaps
boolean isOverlapping(float x, float y, float size) {
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

// Draw function
void draw() {
  if (programRunning) {
    background(bg); // Set background image

    // Draw and move the wolves
    for (Predator wolf : wolves) {
      wolf.drawMe();
      wolf.move();
    }

    // Draw and move the foxes
    for (Predator fox : foxes) {
      fox.drawMe();
      fox.move();
    }

    // Draw the waters
    for (Water water : waters) {
      water.drawMe();
    }

    // Draw and move the preys
    for (Prey p : preys) {
      p.drawMe();
      p.move();
    }

    // Draw the trees
    for (Tree t : trees) {
      t.drawMe();
    }

    // Draw the edibles
    for (Edible e : edibles) {
      e.drawMe();
    }
  }

  // Total counts with background rectangles
  fill(255);
  textAlign(LEFT, TOP);
  textSize(12);

  displayCount("Total wolves added: " + twa, 10, 10);
  displayCount("Total foxes added: " + tfa, 10, 30);
  displayCount("Total deer added: " + tda, 10, 50);
  displayCount("Total squirrels added: " + tsa, 10, 70);
}

void displayCount(String text, int x, int y) {
  float textWidth = textWidth(text);
  fill(255, 200); //Alpha values very cool!
  rect(x - 5, y - 2, textWidth + 10, 15); // Background rectangle
  fill(0); // Text color
  text(text, x, y); // Display the text
}
