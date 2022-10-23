float STEP_SIZE = 8;
float TAG_RADIUS = STEP_SIZE;
int N_VERTICES = 301; 
int WINDING_NUMBER = 13;
float drunk_coeff = 0.2;

Hedgehog[] hedgehogs = new Hedgehog[N_VERTICES];
PVector[] vertices = new PVector[N_VERTICES];

float H_RADIUS = 2.5;
float H_ALPHA = 0.7;

void setup() {
  //size(1024, 768);
  fullScreen();
  frameRate(60);
  background(29, 32, 33);
  
  // Calculate vertex positions
  float radius = min(displayWidth, displayHeight)/2 * 0.95;
  PVector center = new PVector(displayWidth/2, displayHeight/2);
  PVector arrow = new PVector(0,-1).mult(radius);
  if (N_VERTICES % 2 == 0) {
    arrow.rotate(-2*PI/N_VERTICES/2);
  }
  for (int i = 0; i < N_VERTICES; i++) {
    vertices[i] = center.copy().add(arrow);
    arrow.rotate(2*PI/N_VERTICES);
  }

  draw_polygon();
  
  for (int i = 0; i < N_VERTICES; i++) {
    int j = (i+WINDING_NUMBER) % N_VERTICES;
    hedgehogs[i] = new Hedgehog(i, vertices[i].x, vertices[i].y, j);
  }
}

void draw() {
  noStroke();
  //int alpha = frameCount % 1000 == 0 ? 255 : 10;
  fill(29, 32, 33, 7);
  blendMode(DARKEST);
  rect(0,0, displayWidth, displayHeight);
  blendMode(BLEND);
  draw_polygon();
  for (Hedgehog h: hedgehogs) { h.update(); h.draw(); }
  draw_info_text();
}
