import g4p_controls.*;
color fur = color(178, 120, 50);
Animal wolf2;

void setup() {
  size(650, 650);
  createGUI();
  wolf2 = new Animal(20.5, 40.4);
  wolf2.PStats();
}

void draw() {
  background (145, 175, 105);
}
