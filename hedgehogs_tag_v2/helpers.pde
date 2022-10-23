String previous_info_text = "";

void draw_info_text() {
  push();
  textAlign(RIGHT, TOP);
  textSize(12);
  fill(29, 32, 33);
  text(previous_info_text, width-5, 0+5);
  fill(180);
  String text =
    "fps : " + nf(frameRate,2,1) + "\n" + 
    "frame : " + nf(frameCount,4);
  text(text, width-5, 0+5);
  previous_info_text = text;
  pop();
};

void draw_polygon() {
  noFill();
  strokeWeight(3);
  stroke(100, 90, 75);

  for (int i = 0; i < N_VERTICES; i++) {
    int j = (i+1) % N_VERTICES;
    line(vertices[i].x, vertices[i].y, vertices[j].x, vertices[j].y);
  }
}
