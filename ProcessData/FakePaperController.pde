public class FakePaperController implements PaperController {
  String[] lines;
  int cursor;
  
  public FakePaperController(String filename) {
    lines = loadStrings(filename);
    cursor = 0;
  }
  
  public Frame waitForFrame() {
    if (cursor < lines.length) {
      delay(50);
      return new Frame(lines[cursor++]);
    }
    
    return null;
  }
}