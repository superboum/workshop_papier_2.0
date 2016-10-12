import java.util.*;

PFont font;
PaperController controller;
LED led;
ArrayList<Screen> screens;
int selectedScreen;

void setup() {
  //controller = new FakePaperController("/home/qdufour/Documents/dev/processing/workshop_papier/ProcessData/example_data.txt");
  controller = new NetworkPaperController(this, "127.0.0.1", 5984);
  led = new LED(this);
  
  int sequencesX = 3, sequencesY = 2;
  controller.saveSequence(sequencesX*sequencesY);
  
  selectedScreen = 0;
  screens = new ArrayList<Screen>();
  screens.add(new GridScreen(sequencesX,sequencesY));
  screens.add(new LiveScreen());
  
  smooth(8);
  fullScreen(P2D, SPAN);
  //size(1024, 768);
  frameRate(60);
  background(255,209,209);
  font = loadFont("AlegreyaSans-Black-80.vlw");  
}

void keyPressed() {
  if (key == 's') {
    controller.changeState();
  } else if (key == 'v') {
    selectedScreen = (selectedScreen + 1) % screens.size();
    background(255,209,209);
  }
}

void draw() {
  screens.get(selectedScreen).draw();
}