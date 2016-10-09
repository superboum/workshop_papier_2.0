public class Frame {
  private int width, height, total_pixel_count, detected_pixel_count, detected_pixel_delta;
  private float x_center_position, y_center_position, x_center_delta, y_center_delta;
  public String raw;
  
  public Frame(String line) {
    raw = line;
    String[] numbers = split(line, ' ');
    width = int(numbers[1]);
    height = int(numbers[2]);
    total_pixel_count = width*height;
    
    detected_pixel_count = int(numbers[3]);
    detected_pixel_delta = int(numbers[4]);
    x_center_position = float(numbers[5]);
    y_center_position = float(numbers[6]);
    x_center_delta = float(numbers[7]);
    y_center_delta = float(numbers[8]);
  }
  
  public float getDetectedPixelCount() {
    return float(detected_pixel_count) / float(total_pixel_count);
  }
  
  public float getEvolutionPixelCount() {
    return float(detected_pixel_delta) / float(total_pixel_count);
  }
  
  public PVector getCenterOfPaper() {
    return new PVector(x_center_position / width,y_center_position / height);
  }
  
  public PVector getEvolutionCenterOfPaper() {
    return new PVector(x_center_delta / width,y_center_delta / height);
  }
}