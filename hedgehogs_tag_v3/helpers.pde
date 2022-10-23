String previous_info_text = "";
int TEXT_COLOR = 80;

void draw_info_text() {
  int tag_count = 0, home_count = 0;
  for (Hedgehog h: hedgehogs) {
    home_count += int(h.go_home);
    tag_count += int(!h.go_home);
  }
  
  float alpha = tag_count / float(tag_count+home_count);
  
  String text =
    "fps: " + nf(frameRate,2,1) + "\n" + 
    "frame: " + nf(frameCount,4) + "\n" + 
    "alpha: " + nf(alpha, 1, 2);

  pg.push();
  pg.textAlign(RIGHT, TOP);
  pg.fill(29, 32, 33);
  pg.text(previous_info_text, width-5, 0+5);
  pg.fill(TEXT_COLOR);
  pg.text(text, width-5, 0+5);
  pg.pop();
  
  previous_info_text = text;
};

String previous_author_text = "";

void draw_author_text() {
  pg.push();
  pg.textAlign(LEFT, BOTTOM);
  pg.fill(29, 32, 33);
  pg.text(previous_author_text, 5, height-5);
  pg.fill(TEXT_COLOR);
  String text = "Hedgehog tag | MK";
  pg.text(text, 5, height-5);
  previous_author_text = text;
  pg.pop();
}

void draw_polygon() {
  pg.noFill();
  pg.strokeWeight(3);
  pg.stroke(100, 90, 75);

  for (int i = 0; i < N_VERTICES; i++) {
    int j = (i+1) % N_VERTICES;
    pg.line(vertices[i].x, vertices[i].y, vertices[j].x, vertices[j].y);
  }
}
