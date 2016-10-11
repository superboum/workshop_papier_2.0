PFont font;
PaperController controller;
ScreenVisualization screen;
LampVisualization lamp;
    
void setup() {
  //controller = new FakePaperController("/home/qdufour/Documents/dev/processing/workshop_papier/ProcessData/example_data.txt");
  controller = new NetworkPaperController(this, "127.0.0.1", 5984);
  LED led = new LED(this);

  screen = new ScreenVisualization(400,400, 100, 100);
  lamp = new LampVisualization(led);
  
  smooth(8);
  fullScreen(P2D, SPAN);
  //size(800, 600);
  frameRate(60);
  
  font = loadFont("AlegreyaSans-Black-80.vlw");  
}

void keyPressed() {
  screen.keyPressed();
}

void draw() {
  if (controller.getStatus() == "etalonnage") {
    Calibration c = controller.waitForColor();
    if (c != null) {
      lamp.draw(c);
      screen.draw(c);
    }
  } else if (controller.getStatus() == "capture") {
    Frame f = controller.waitForFrame();
    if (f != null) {
      lamp.draw(f);
      screen.draw(f);
    }
  }
}