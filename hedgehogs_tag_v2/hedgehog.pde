class Hedgehog {
  int id;
  int follow; // id of the hedgehog to follow
  PVector home;
  PVector position;
  PVector _position;
  PVector direction;
  boolean go_home;
  
  Hedgehog(int id, float x, float y, int follow) {
    this.id = id;
    this.follow = follow;
    this.position = new PVector(x, y);
    this._position = position.copy();
    this.home = position.copy();
    this.direction = new PVector(0, 0);
    this.go_home = false;
  }
  
  
  void update() {
    PVector target;
    if (go_home) {
      target = home.copy();
    } else {
      target = hedgehogs[follow]._position.copy();
    }
    PVector target_delta = target.sub(position);
    float tag_radius = go_home ? STEP_SIZE : TAG_RADIUS;
    if (target_delta.mag() < tag_radius) {
      go_home = !go_home;
      return;
    }
    PVector new_direction = target_delta.normalize();
    if (drunk_coeff > 0 && !go_home) {
      new_direction.rotate(randomGaussian()*HALF_PI/2*drunk_coeff);
    }
    direction = new_direction;
    this._position = position.copy();
    float step_size = go_home ? 2*STEP_SIZE : STEP_SIZE;
    this.position.add(direction.mult(step_size));
  }
  
  void draw() {
    strokeWeight(3);
    ellipseMode(RADIUS);
    stroke(H_RADIUS);
    if (go_home) {
      // stroke(224, 170, 59, int(H_ALPHA*255));
      stroke(224, 170, 59, int(0.01*255));
    } else {
      stroke(223, 70, 57, int(H_ALPHA*255));
    }
    PVector initial = _position.copy().sub(position);
    initial.setMag(initial.mag() - H_RADIUS*3/4);
    initial.add(position);
    line(initial.x, initial.y, position.x, position.y);
  }
}
