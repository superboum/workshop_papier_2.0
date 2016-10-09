PaperController controller;

void setup() {
  controller = new FakePaperController("/home/qdufour/Documents/dev/processing/workshop_papier/ProcessData/example_data.txt");
}

void draw() {
  Frame f = controller.waitForFrame();
  println(
    f.getCenterOfPaper().x,
    f.getCenterOfPaper().y,
    f.getDetectedPixelCount(),
    f.getEvolutionCenterOfPaper().x,
    f.getEvolutionCenterOfPaper().y,
    f.getEvolutionPixelCount());
}