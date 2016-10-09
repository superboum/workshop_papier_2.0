import processing.serial.*;

public class LED {
  Serial myPort;  
  
  public LED(PApplet processing) {
    // List all the available serial ports:
    printArray(Serial.list());
    // Open the port you are using at the rate you want:
    myPort = new Serial(processing, Serial.list()[0], 9600);
  }
  
  public void setColor(int red, int green, int blue) {
    myPort.write(str(red)+" "+str(green)+" "+str(blue)+"\n");
  }
}