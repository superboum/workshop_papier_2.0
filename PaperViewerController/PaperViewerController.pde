PFont font;
PaperController controller;
ArrayList<Visualization> vis;
    
void setup() {
  //controller = new FakePaperController("/home/qdufour/Documents/dev/processing/workshop_papier/ProcessData/example_data.txt");
  controller = new NetworkPaperController(this, "127.0.0.1", 5984);
  LED led = new LED(this);

  vis = new ArrayList();
  
  /*for(int i = 0; i < 6; i++) {
    for (int j = 0; j < 4; j++) {
        vis.add(new ScreenVisualization(width/6, height/4, width / 6 * i, height / 4 * j));
    }
  }*/
  
  vis.add(new ScreenVisualization());
  vis.add(new LampVisualization(led));
  
  smooth(8);
  fullScreen(P3D, SPAN);
  //size(1024, 768);
  frameRate(60);
  
  font = loadFont("AlegreyaSans-Black-80.vlw");  
}

void keyPressed() {
 controller.changeState();
}

void draw() {
  if (controller.getStatus() instanceof CalibrationStatus) calibrate();
  else if (controller.getStatus() instanceof CaptureStatus) capture();
}

void calibrate() {
  Calibration c = controller.waitForColor();
  if (c != null) {
    for(Visualization v : vis) v.draw(c);
  }
}

void capture() {
  Frame f = controller.waitForFrame();
  if (f != null) {
    for(Visualization v : vis) v.draw(f);
  }
}