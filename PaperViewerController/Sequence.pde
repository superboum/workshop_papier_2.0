public class Sequence {
  private ArrayList<Frame> frames;
  private int startingTime;
  
  public Sequence() {
    frames = new ArrayList();
    startingTime = millis();
  }
  
  public Sequence(Frame f) {
    this();
    frames.add(f);
  }
  
  public void addFrame(Frame f) {
    frames.add(f);
  }
  
  public int getStartingTime() {
    return startingTime;
  }
  
  public ArrayList<Frame> getFrames() {
    return frames;
  }
}