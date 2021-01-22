
public class Starter extends HangingComponent {
  
  private final PVector point = new PVector(width / 2, 50, 0);
  private HangingComponent comp = null;
  
  public Starter(HangingComponent startingComponent) {
    this.comp = startingComponent;
    // Calcolo la posizione a discesa
    this.setHangingPosition(point);
  }
  
  @Override
  public void setHangingPosition(PVector position) {
    // Setting my position
    super.setHangingPosition(position);
    // Setting the position of my main element
    this.comp.setHangingPosition(this.getHangingPosition());
  }
  
  @Override
  public float getMass() {
    return 0;
  }
  
  @Override
  public void display() {
    // Computation of the new positions
    this.setHangingPosition(this.point);    
    // View of the pivot hanging point
    stroke(0);
    strokeWeight(6);
    point(this.getHangingPosition().x, this.getHangingPosition().y, this.getHangingPosition().z);
    // View of the first element + all the others in cascade
    this.comp.display();
  }
  
}
