public class Sequence {
  private ArrayList<Frame> frames;
  private int startingTime;
  private boolean finished = false;
  private int cursor = 0;
  
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
  
  public void setFinished() {
    finished = true;
  }
  
  public boolean isFinished() {
    return finished;
  }
  
  public ArrayList<Frame> getFrames() {
    return frames;
  }
  
  public Frame iterateFrame() {
    cursor++;
    if (cursor >= frames.size()) cursor = 0;
    return frames.get(cursor);
  }
}