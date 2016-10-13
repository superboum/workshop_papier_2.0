public class Sequence {
  private ArrayList<Frame> frames;
  private int startingTime;
  private boolean finished = false;
  private int cursor = 0;
  private int cursorTime = 0;
  private int[] backgroundColor;
  
  public Sequence() {
    frames = new ArrayList();
    startingTime = millis();
    // @TODO remove
    //backgroundColor = new int[]{(int)random(0,255), (int)random(0,255), (int)random(0,255)};
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
    int nextCursor = (cursor + 1) % frames.size();

    int deltaTime = millis() - cursorTime;
    int deltaSaveTime = frames.get(nextCursor).getTime() - frames.get(cursor).getTime();

    //@TODO Remove
    //frames.get(cursor).setBackgroundColor(backgroundColor[0],backgroundColor[1],backgroundColor[2]);
    if (deltaTime >= deltaSaveTime) {
      cursorTime = millis();
      cursor = nextCursor;
    }
    return frames.get(cursor);
  }
}
