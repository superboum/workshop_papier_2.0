import processing.net.*; 

public class NetworkPaperController implements PaperController {
  Client connection;
  String status = "etalonnage";
  
  public NetworkPaperController(PApplet processing, String ip, int port) {
    connection = new Client(processing, ip, port);
  }
  
  private String getLine() {
    String read = connection.readStringUntil('\n');
    if (read == null) return null;
    if (split(read, ' ')[0].contains("ETA")) {
      status = "etalonnage";
      return read;
    }
    if (split(read, ' ')[0].contains("CAP")) {
      status = "capture";
      return read;
    }
    return null;
  }
  
  public Calibration waitForColor() {
    String read = getLine();
    if (status != "etalonnage") return null;
    return read == null ? null : new Calibration(read);
  }  
  
  public Frame waitForFrame() {
    String read = getLine();
    if (status != "capture") return null;
    return read == null ? null : new Frame(read);
  }
  
  public void changeState() {
    connection.write("OK\n");
  }
  
  public String getStatus() {
    return status;
  }
}