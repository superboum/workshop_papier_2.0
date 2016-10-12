public class LiveScreen extends AbstractScreen {
    
  public LiveScreen() {
    super();
    
    vis.add(new LiveScreenVisualization());
    vis.add(new LampVisualization(led));   
  }

}