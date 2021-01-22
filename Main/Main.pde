/**
 * This program simulates the behavior of a similar Calder sculpture, a kinetic composition of pendulums and balances.
 *
 * Made by Michele Dusi, January 2021.
 */

/** Scales the simulation time */
final float TIME_SCALE = 0.003;

/** Masses of the hanging elements */
final float MIN_MASS = 300;
final float MAX_MASS = 4000;
final float RANGE_MASS = MAX_MASS - MIN_MASS;

/** Length of the connector elements */
final float MIN_LENGTH = 100;
final float MAX_LENGTH = 400;
final float RANGE_LENGTH = MAX_LENGTH - MIN_LENGTH;

/** Quantity of elements */
final int ELEMENTS_NUMBER = 8;

/** First element, the root of the sculpture. */
Starter sculpture;

void setup() {
  size(900, 500, P3D);
  ellipseMode(RADIUS);
  
  sculpture = createSculpture();
  
}

/**
 * Create and returns the sculpture.
 */
Starter createSculpture() {
  return new Starter(createComponent(ELEMENTS_NUMBER));
}

/**
 * Create a single component.
 * It can call itself recursively, creating other hanging components.
 */
HangingComponent createComponent(int remainingElements) {
  // If more than two elements are still to be created, we can create a connector.
  if (remainingElements >= 2) {
    // Connector
    int leftRemainingElements = floor(random(remainingElements - 2)) + 1; // At least 1
    int rightRemainingElements = remainingElements - leftRemainingElements; // At least 1
    HangingComponent c1 = createComponent(leftRemainingElements);
    HangingComponent c2 = createComponent(rightRemainingElements);
    float mass = random(RANGE_LENGTH) + MIN_LENGTH;
    return new Connector(c1, c2, mass);
  }
  // Else, we create and return a single element
  else {
    // Final element
    float span = random(RANGE_MASS) + MIN_MASS;
    return new Element(span); 
  }
}

/**
 * Draws a line connecting two points 
 */
void drawline(PVector p1, PVector p2) {
  line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
}

void draw() {
  background(255);
  
  // If the mouse is pressed, we can see a flat scene
  if (!mousePressed) {
    lights();
  }
  
  // Computation of the new position and visualization
  sculpture.display();
  
}
