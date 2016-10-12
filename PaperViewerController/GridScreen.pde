public class GridScreen extends AbstractScreen {
  private int divide_x, divide_y;
  protected ArrayList<Visualization> hist;
    
  public GridScreen(int divide_x, int divide_y) {
    super();
    
    this.divide_x = divide_x;
    this.divide_y = divide_y;
    hist = new ArrayList();
    
    vis.add(new LiveScreenVisualization(width/divide_x, height/divide_y, 0, 0));
    vis.add(new LampVisualization(led));
    
    for (int j = 0; j < divide_y; j++) {
      for(int i = 0; i < divide_x; i++) {
        if (i == 0 && j == 0) continue;
        hist.add(new ReplayScreenVisualization(width/divide_x, height/divide_y, width / divide_x * i, height / divide_y * j));
      }
    }    
  }
  
  public void draw() {
    super.draw();

    List<Sequence> sequences = controller.getSequenceManager().getSequences();
    int counter = 1, displayed = 0;
    while (sequences.size() - counter >= 0 && displayed < hist.size()) {
      Sequence s = sequences.get(sequences.size() - counter++);
      if (s.isFinished()) {
        hist.get(displayed++).draw(s.iterateFrame());
      }
    }
  }
}