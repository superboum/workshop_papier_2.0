import java.util.*;

public class SequenceManager {
  private SequenceStatus status;
  private float limit = 0.6f;
  private ArrayList<Sequence> sequences;
  private int sequenceDurationTime = 10000;
  private int sequenceGreetingDuration = 2000;
  private int sequenceHistorySize = 0;
  
  public SequenceManager(int sequenceHistorySize) {
    status = SequenceWait.getInstance();
    sequences = new ArrayList();
    this.sequenceHistorySize = sequenceHistorySize;
  }
  
  public SequenceStatus getStatus() {
    return status;
  }
  
  public List<Sequence> getSequences() {
    return sequences;
  }
  
  public void notifyFrame(Frame f) {
    if (status instanceof SequenceWait) {
      if (f.getDetectedPixelCount() > limit) {
        status = SequenceInProgress.getInstance();
        sequences.add(new Sequence(f));
        if(sequences.size() > sequenceHistorySize) {
          sequences.remove(0);
        }
      }
    } else if (sequences.get(sequences.size() - 1).getStartingTime() + sequenceDurationTime > millis()) {
      sequences.get(sequences.size() - 1).addFrame(f);
    } else if (sequences.get(sequences.size() - 1).getStartingTime() + sequenceDurationTime + sequenceGreetingDuration > millis()) {
      status = SequenceThanks.getInstance();
      sequences.get(sequences.size() - 1).setFinished();
    } else {
      status = SequenceWait.getInstance();
    }
  }
}

public interface SequenceStatus {
}

public static class SequenceWait implements SequenceStatus {
  private static SequenceWait INSTANCE;
  private SequenceWait() {}
  
  public static SequenceWait getInstance() {
    if(SequenceWait.INSTANCE == null) { SequenceWait.INSTANCE = new SequenceWait(); }
    return SequenceWait.INSTANCE;
  }
}

public static class SequenceInProgress implements SequenceStatus {
  private static SequenceInProgress INSTANCE;
  private SequenceInProgress() {}
  
  public static SequenceInProgress getInstance() {
    if(SequenceInProgress.INSTANCE == null) { SequenceInProgress.INSTANCE = new SequenceInProgress(); }
    return SequenceInProgress.INSTANCE;
  }
}

public static class SequenceThanks implements SequenceStatus {
  private static SequenceThanks INSTANCE;
  private SequenceThanks() {}
  
  public static SequenceThanks getInstance() {
    if(SequenceThanks.INSTANCE == null) { SequenceThanks.INSTANCE = new SequenceThanks(); }
    return SequenceThanks.INSTANCE;
  }
}
