import processing.net.*; 

public class NetworkPaperController implements PaperController {
  private Client connection;
  private ControllerStatus status = new CalibrationStatus();
  private SequenceManager sequenceManager = new SequenceManager();
  
  public NetworkPaperController(PApplet processing, String ip, int port) {
    connection = new Client(processing, ip, port);
  }
  
  private String getLine() {
    String read = connection.readStringUntil('\n');
    if (read == null) return null;
    if (split(read, ' ')[0].contains("ETA")) {
      status = new CalibrationStatus();
      return read;
    }
    if (split(read, ' ')[0].contains("CAP")) {
      status = new CaptureStatus();
      return read;
    }
    return null;
  }
  
  public Calibration waitForColor() {
    String read = getLine();
    if (!(status instanceof CalibrationStatus)) return null;
    return read == null ? null : new Calibration(read);
  }  
  
  public Frame waitForFrame() {
    String read = getLine();
    if (read != null && status instanceof CaptureStatus) { 
      Frame lastFrame = new Frame(read);
      sequenceManager.notifyFrame(lastFrame);
      return lastFrame;
    }
    return null;
  }
  
  public SequenceManager getSequenceManager() {
    return sequenceManager;
  }
  
  public void changeState() {
    connection.write("OK\n");
  }
  
  public ControllerStatus getStatus() {
    return status;
  }
}