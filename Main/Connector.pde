
public class Connector extends HangingComponent {
  
  private static final float MASS_PER_LENGTH = 0.1;
  private static final float VERTICAL_STEP = 40;
  public static final color WIRE_COLOR = 0xFF777777; // Grey
  public static final float WIRE_WEIGHT = 2;
  public static final float RING_RADIUS = 3;
  
  private final HangingComponent lx;
  private final HangingComponent rx;
  private final float span;
  private final float distL;
  private final float distR;
  private final float seed;
  
  public Connector(HangingComponent leftComponent, HangingComponent rightComponent, float span) {
    this.span = span;
    this.lx = leftComponent;
    this.rx = rightComponent;
    float massL = this.lx.getMass();
    float massR = this.rx.getMass();
    this.distL = (this.span * massR) / (massL + massR);
    this.distR = (this.span * massL) / (massL + massR);
    this.seed = random(9999)-5000;
  }
  
  @Override
  public void setHangingPosition(PVector position) {
    // Setting my position by the parent method
    super.setHangingPosition(position);
    
    // Computing the angle / direction of the horizontal bar
    float oscAngle = sin((frameCount + this.seed) * TIME_SCALE) * (0.1);
    float rotAngle = ((frameCount + this.seed) * TIME_SCALE) * sin(this.seed);
    float centerX = this.getHangingPosition().x;
    float centerY = this.getHangingPosition().y + VERTICAL_STEP;
    float centerZ = this.getHangingPosition().z;
    
    // Setting the position of the two sub-components
    this.lx.setHangingPosition(new PVector(
      centerX - cos(rotAngle) * cos(oscAngle) * distL,
      centerY - sin(oscAngle) * distL,
      centerZ - sin(rotAngle) * cos(oscAngle) * distL
      ));
    this.rx.setHangingPosition(new PVector(
      centerX + cos(rotAngle) * cos(oscAngle) * distR, 
      centerY + sin(oscAngle) * distR,
      centerZ + sin(rotAngle) * cos(oscAngle) * distR
      ));
  }
  
  /**
   * Returns the mass of this sub-tree, adding the left child mass, the right child mass and the mass of the bar
   */
  @Override
  public float getMass() {
    return Connector.MASS_PER_LENGTH * this.span + this.lx.getMass() + this.rx.getMass();
  }
  
  @Override
  public void display() {
    if (this.hasHangingPosition()) {
      // Lines
      noFill();
      stroke(WIRE_COLOR);
      strokeWeight(WIRE_WEIGHT);
      
      // Horizontal bar
      drawline(this.lx.getHangingPosition(), this.rx.getHangingPosition());
      // Vertical hanging line
      line(
        this.getHangingPosition().x, this.getHangingPosition().y, this.getHangingPosition().z, 
        this.getHangingPosition().x, this.getHangingPosition().y + VERTICAL_STEP - RING_RADIUS, this.getHangingPosition().z);
        
      pushMatrix();
      translate(this.getHangingPosition().x, this.getHangingPosition().y + VERTICAL_STEP, this.getHangingPosition().z);
      rotateY(this.lx.getHangingPosition().copy().sub(this.rx.getHangingPosition()).heading() - PI / 2);
      ellipse(0, 0, RING_RADIUS, RING_RADIUS);
      popMatrix();
      
      // Drawing the components in cascade
      this.lx.display();
      this.rx.display();
    } else {
      throw new IllegalStateException("Impossible to render the element: " + this.toString());
    }
  }
  
}
