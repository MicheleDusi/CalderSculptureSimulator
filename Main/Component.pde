/**
 * Generic component of the simulation.
 */
public interface Component {
  public float getMass();
  public void display();
}

/**
 * Component with a 3D position.
 */
protected abstract class HangingComponent implements Component {
  
  private PVector hangPos;
  
  protected HangingComponent() {
    this.hangPos = null;
  }
  
  public boolean hasHangingPosition() {
    return this.hangPos != null;
  }
  
  public void setHangingPosition(PVector position) {
    this.hangPos = position;
  }
  
  public PVector getHangingPosition() {
    return this.hangPos;
  }
  
}
