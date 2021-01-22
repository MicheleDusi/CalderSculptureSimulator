
public class Element extends HangingComponent {

  private static final float VERTICAL_STEP = 20;
  private final color [] COLORS = {
    0xffeb4034, // Red
    0xff32a852, // Green
    0xff4287f5, // Blue
    0xfffcba03, // Yellow
  };
  
  private final float mass;
  private final float radius;
  private final color col;
  
  public Element(float mass) {
    if (mass <= 0) {
      throw new IllegalArgumentException("Impossibile creare un elemento con massa nulla o negativa");
    }
    this.mass = mass;
    /* Suppongo che la massa sia proporzionale all'area dell'elemento, che è più o meno circolare.
    */
    this.radius = pow(this.mass, 1/3.0);
    // Selezione del colore
    this.col = COLORS[floor(random(COLORS.length))];
  }
  
  @Override
  public float getMass() {
    return this.mass;
  }
  
  @Override
  public void display() {
    if (this.hasHangingPosition()) {
      // Hanging line
      noFill();
      stroke(Connector.WIRE_COLOR);
      strokeWeight(Connector.WIRE_WEIGHT);
      line(
        this.getHangingPosition().x, this.getHangingPosition().y, this.getHangingPosition().z, 
        this.getHangingPosition().x, this.getHangingPosition().y + VERTICAL_STEP, this.getHangingPosition().z);
      // Shape
      fill(this.col);
      noStroke();
      
      pushMatrix();
      translate(this.getHangingPosition().x, this.getHangingPosition().y + VERTICAL_STEP + this.radius, this.getHangingPosition().z);
      sphere(this.radius);
      popMatrix();
      
    } else {
      throw new IllegalStateException("Impossible to render the element: " + this.toString());
    }
  }
  
}
