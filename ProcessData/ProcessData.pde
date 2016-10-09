PaperController controller;

void setup() {
  //controller = new FakePaperController("/home/qdufour/Documents/dev/processing/workshop_papier/ProcessData/example_data.txt");
  controller = new NetworkPaperController(this, "127.0.0.1", 5284);
}

void draw() {
  Frame f = controller.waitForFrame();
  if (f != null) {
    println(
      f.getCenterOfPaper().x,
      f.getCenterOfPaper().y,
      f.getDetectedPixelCount(),
      f.getEvolutionCenterOfPaper().x,
      f.getEvolutionCenterOfPaper().y,
      f.getEvolutionPixelCount()
    );
  }
}  