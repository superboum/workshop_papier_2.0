PaperController controller;
LED led;
PFont font;
    
void setup() {
  //controller = new FakePaperController("/home/qdufour/Documents/dev/processing/workshop_papier/ProcessData/example_data.txt");
  controller = new NetworkPaperController(this, "127.0.0.1", 5984);
  led = new LED(this);

  smooth(8);
  fullScreen(P2D, SPAN);
  //size(800, 600);
  frameRate(60);
  
  font = loadFont("AlegreyaSans-Black-80.vlw");
}

int rouge = 0;
int vert = 0;
int bleu = 0;

void keyPressed() {
  controller.changeState();
  led.setColor(min(255,rouge),min(255,vert),min(255,bleu));
}

void draw() {
  if (controller.getStatus() == "etalonnage") etalonnage();
  else if (controller.getStatus() == "capture") capture();
}

void etalonnage() {
  Calibration c = controller.waitForColor();
  if (c != null) {
    background(c.red, c.green, c.blue);
  } else {
    //background(255,0,0);
  }
}

void capture() {
  Frame f = controller.waitForFrame();
  if (f != null) {
    
    if (abs(f.getEvolutionPixelCount()) > 0.08f)
      background(40,0,0);
    else
      background(255, 209, 209);
    
    int red_lamp = min(255, int(pow(f.getDetectedPixelCount(), 2) * 250) + min(255, int(pow(f.getEvolutionPixelCount(), 2) * 1000)));
    int green_lamp = min(30, int(pow(f.getEvolutionPixelCount(), 2) * 1000));
    int blue_lamp = 0;
    
    int red_ball = max(130, min(255, int(f.getDetectedPixelCount() * 1000)));
    int green_ball = min(30, int(f.getEvolutionPixelCount() * 2000)) + min(60, int(f.getDetectedPixelCount() * 1000));
    int blue_ball = min(0, int(f.getEvolutionPixelCount() * 500));
    
    float size = min(height, int(f.getDetectedPixelCount() * height * 1.2));
    
    textSize(32);
    fill(130,30,0);
    textFont(font, 80);
    textAlign(CENTER, CENTER);
    text("NE NOUS FROISSONS PAS", width/2, height/2);
    
    fill(red_ball, green_ball, blue_ball);    
    ellipse(width/2, height/2, size, size);
    noStroke();
    
    led.setColor(red_lamp, green_lamp, blue_lamp);

    //ellipse(f.getCenterOfPaper().x * width, f.getCenterOfPaper().y * height, int(f.getDetectedPixelCount() * 500), int(f.getDetectedPixelCount() * 500));
  }
}
