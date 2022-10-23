float STEP_SIZE = 10;
float TAG_RADIUS = STEP_SIZE;
int N_VERTICES = 31; 
int WINDING_NUMBER = 3;
float drunk_coeff = 0.2;

Hedgehog[] hedgehogs = new Hedgehog[N_VERTICES];
PVector[] vertices = new PVector[N_VERTICES];

float H_RADIUS = 2.5;
float H_ALPHA = 0.7;

PGraphics pg;
boolean SAVE = true;
PFont font;
int LOOP_FRAMES = 1000;

void setup() {
  size(512, 512, JAVA2D);
  frameRate(30);
  
  font = createFont("../fonts/Inconsolata-Light.ttf", 14);

  pg = createGraphics(512, 512, JAVA2D);
  //pg.noSmooth();
  pg.beginDraw();
  pg.background(29, 32, 33);
  pg.textFont(font);
  pg.endDraw();
  
  // Calculate polygon vertex positions
  float radius = min(width, height)/2 * 0.95;
  PVector center = new PVector(width/2, height/2);
  PVector arrow = new PVector(0,-1).mult(radius);
  if (N_VERTICES % 2 == 0) {
    arrow.rotate(-2*PI/N_VERTICES/2);
  }
  for (int i = 0; i < N_VERTICES; i++) {
    vertices[i] = center.copy().add(arrow);
    arrow.rotate(2*PI/N_VERTICES);
  }

  //draw_polygon();
  
  for (int i = 0; i < N_VERTICES; i++) {
    int j = (i+WINDING_NUMBER) % N_VERTICES;
    hedgehogs[i] = new Hedgehog(i, vertices[i].x, vertices[i].y, j);
  }
}

void draw() {
  pg.beginDraw();
  pg.noStroke();
  pg.fill(29, 32, 33, 10);
  pg.blendMode(DARKEST);
  pg.rect(0,0, width, height);
  pg.blendMode(BLEND);
  //draw_polygon();
  
  if (frameCount == LOOP_FRAMES) {
    for (Hedgehog h: hedgehogs) { h.go_home = true; h.play_tag = false; }
  }

  for (Hedgehog h: hedgehogs) { h.update(); h.draw(); }
  //draw_info_text();
  draw_author_text();
  pg.endDraw();
  image(pg, 0, 0);
  
  if (SAVE) {
    pg.save("./frames/frame_" + nf(frameCount,4) + ".png");
  }
  
}
