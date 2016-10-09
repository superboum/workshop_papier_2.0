public class Frame {
  private int width, height, total_pixel_count, detected_pixel_count, detected_pixel_delta;
  private float x_center_position, y_center_position, x_center_delta, y_center_delta;
  
  public Frame(String line) {
    String[] numbers = split(line, ' ');
    width = int(numbers[0]);
    height = int(numbers[1]);
    total_pixel_count = width*height;
    
    detected_pixel_count = int(numbers[2]);
    detected_pixel_delta = int(numbers[3]);
    x_center_position = float(numbers[4]);
    y_center_position = float(numbers[5]);
    x_center_delta = float(numbers[6]);
    y_center_delta = float(numbers[7]);
  }
  
  public float getDetectedPixelCount() {
    return float(detected_pixel_count) / float(total_pixel_count);
  }
  
  public float getEvolutionPixelCount() {
    return float(detected_pixel_delta) / float(total_pixel_count);
  }
  
  public PVector getCenterOfPaper() {
    return new PVector(x_center_position,y_center_position);
  }
  
  public PVector getEvolutionCenterOfPaper() {
    return new PVector(x_center_delta,y_center_delta);
  }
}