public class FakePaperController implements PaperController {
  String[] lines;
  int cursor;
  
  public FakePaperController(String filename) {
    lines = loadStrings(filename);
    cursor = 0;
  }
  
  public String getStatus() {
    return "";
  }
  
  public Calibration waitForColor() {
    delay(20);
    return new Calibration("ETA 255 255 255");
  }
  
  public Frame waitForFrame() {
    if (cursor < lines.length) {
      delay(20);
      return new Frame("CAP "+lines[cursor++]);
    }
    
    return null;
  }
  
  public void changeState() {
  }
}