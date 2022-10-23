class Hedgehog {
  int id;
  int follow; // id of the hedgehog to follow
  PVector position;
  PVector direction;
  
  Hedgehog(int id, float x, float y, int follow) {
    this.id = id;
    this.follow = follow;
    position = new PVector(x, y);
    direction = new PVector(0, 0);
  }
  
  
  void update() {
    Hedgehog target = hedgehogs[follow];
    PVector target_delta = target.position.copy().sub(position);
    if (target_delta.mag() < STEP_SIZE) {
      //print("[", id, "] got here!\n");
      return;
    }
    PVector new_direction = target_delta.normalize();
    if (drunk_coeff > 0) {
      new_direction.rotate(randomGaussian()*HALF_PI/2*drunk_coeff);
    }
    direction = new_direction;
    position.add(direction.mult(STEP_SIZE));
  }
  
  void draw() {
    ellipseMode(RADIUS);
    noStroke();
    fill(223, 70, 57, 150);
    ellipse(position.x, position.y, 2.5, 2.5);
  }
}
