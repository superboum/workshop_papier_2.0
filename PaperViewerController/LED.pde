import processing.serial.*;

public class LED {
  Serial myPort;  
  
  public LED(PApplet processing) {
    try {
      // List all the available serial ports:
      printArray(Serial.list());
      // Open the port you are using at the rate you want:
      myPort = new Serial(processing, Serial.list()[0], 9600);
    } catch(Exception e) {
      println("Error: have you connected your arduino ?");
      myPort = null;
    }
  }
  
  public void setColor(int red, int green, int blue) {
    if (myPort != null) myPort.write(str(red)+" "+str(green)+" "+str(blue)+"\n");
  }
}
