int WIDTH = 1024;
int HEIGHT = 768;

float STEP_SIZE = 4;

int N_VERTICES = 11;
 
float drunk_coeff = 0.9; 

Hedgehog[] hedgehogs = new Hedgehog[N_VERTICES];

void setup() {
  size(1024, 768);
  background(29, 32, 33);
  noStroke();
  
  float POLYGON_RADIUS = min(WIDTH, HEIGHT)/2 * 0.8;
  
  PVector[] vertices = new PVector[N_VERTICES];
  PVector center = new PVector(WIDTH/2, HEIGHT/2);
  PVector arrow = new PVector(0,-1).mult(POLYGON_RADIUS);
  if (N_VERTICES % 2 == 0) {
    arrow.rotate(-2*PI/N_VERTICES/2);
  }
  for (int i = 0; i < N_VERTICES; i++) {
    vertices[i] = center.copy().add(arrow);
    arrow.rotate(2*PI/N_VERTICES);
  }
  
  noFill();
  strokeWeight(3);
  stroke(200, 185, 154);

  for (int i = 0; i < N_VERTICES; i++) {
    int j = (i+1) % N_VERTICES;
    line(vertices[i].x, vertices[i].y, vertices[j].x, vertices[j].y);
  }
  
  for (int i = 0; i < N_VERTICES; i++) {
    int j = (i+1) % N_VERTICES;
    hedgehogs[i] = new Hedgehog(i, vertices[i].x, vertices[i].y, j);
  }
}

void draw() {
  for (Hedgehog h: hedgehogs) {
    h.update();
    h.draw();
  }
}
