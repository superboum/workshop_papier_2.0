public class Calibration {
  public int red, green, blue;
  
  public Calibration(String line) {
    String[] numbers = split(line, ' ');
    red = int(numbers[1]);
    green = int(numbers[2]);
    blue = int(numbers[3]);
  }
  
  
}