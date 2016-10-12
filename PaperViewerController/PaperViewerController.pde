import java.util.*;

PFont font;
PaperController controller;
ArrayList<Visualization> vis;
Visualization hist;
    
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
  
  vis.add(new LiveScreenVisualization(width/3, height/2, 0, 0));
  vis.add(new LampVisualization(led));
  
  hist = new ReplayScreenVisualization(width/3, height/2, width/3, 0);
  
  smooth(8);
  fullScreen(P2D, SPAN);
  //size(1024, 768);
  frameRate(60);
  
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
  if (sequences.size() > 0 && sequences.get(sequences.size() - 1).isFinished()) {
    Frame f = sequences.get(sequences.size() - 1).iterateFrame();
    hist.draw(f); 
  } else if (sequences.size() > 1 && sequences.get(sequences.size() - 2).isFinished()) {
    Frame f = sequences.get(sequences.size() - 2).iterateFrame();
    hist.draw(f); 
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