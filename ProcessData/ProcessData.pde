PaperController controller;

void setup() {
  //controller = new FakePaperController("/home/qdufour/Documents/dev/processing/workshop_papier/ProcessData/example_data.txt");
  controller = new NetworkPaperController(this, "127.0.0.1", 5284);
  
  smooth(8);
  //fullScreen(P2D, SPAN);
  size(800, 600);
  frameRate(60);
}

void draw() {
  Frame f = controller.waitForFrame();
  if (f != null) {
    /*println(
      f.getCenterOfPaper().x,
      f.getCenterOfPaper().y,
      f.getDetectedPixelCount(),
      f.getEvolutionCenterOfPaper().x,
      f.getEvolutionCenterOfPaper().y,
      f.getEvolutionPixelCount()
    ); */
    background(255,204,0); 
    
    ellipse(f.getCenterOfPaper().x * width, f.getCenterOfPaper().y * height, int(f.getDetectedPixelCount() * 500), int(f.getDetectedPixelCount() * 500));
    noStroke();
    fill(0,0,0);
  }
}  