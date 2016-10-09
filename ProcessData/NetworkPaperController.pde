import processing.net.*; 

public class NetworkPaperController implements PaperController {
  Client connection;
  
  public NetworkPaperController(PApplet processing, String ip, int port) {
    connection = new Client(processing, ip, port);
  }
  
  public Frame waitForFrame() {
    String read = connection.readStringUntil('\n');
    return read == null ? null : new Frame(read);
  }
}