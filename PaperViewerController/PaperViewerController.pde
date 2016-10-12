import java.util.*;

PFont font;
PaperController controller;
ArrayList<Visualization> vis;
ArrayList<Visualization> hist;

int divide_x, divide_y;
    
void setup() {
  //controller = new FakePaperController("/home/qdufour/Documents/dev/processing/workshop_papier/ProcessData/example_data.txt");
  controller = new NetworkPaperController(this, "127.0.0.1", 5984);
  LED led = new LED(this);
  
  divide_x = 3;
  divide_y = 2;
  
  vis = new ArrayList();
  hist = new ArrayList();
  
  for (int j = 0; j < divide_y; j++) {
      for(int i = 0; i < divide_x; i++) {
        if (i == 0 && j == 0) continue;
        hist.add(new ReplayScreenVisualization(width/divide_x, height/divide_y, width / divide_x * i, height / divide_y * j));
    }
  }
  
  vis.add(new LiveScreenVisualization(width/divide_x, height/divide_y, 0, 0));
  vis.add(new LampVisualization(led));
    
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
  }
}

void draw() {
  if (controller.getStatus() instanceof CalibrationStatus) calibrate();
  else if (controller.getStatus() instanceof CaptureStatus) capture();
  
  List<Sequence> sequences = controller.getSequenceManager().getSequences();
  int counter = 1, displayed = 0;
  while (sequences.size() - counter >= 0 && displayed < hist.size()) {
    Sequence s = sequences.get(sequences.size() - counter++);
    if (s.isFinished()) {
      hist.get(displayed++).draw(s.iterateFrame());
    }
  }
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