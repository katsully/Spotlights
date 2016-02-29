class Rect {

  int x;
  int y;
  float width;
  float alpha;
  boolean movingLeft;

  Rect(int x, int y, float width, float alpha, boolean movingLeft) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.alpha = alpha;
    this.movingLeft = movingLeft;
  }

  void update() {
    if (movingLeft) {
      x+=10;
    } else {
      x-=10;
    }
  }

  boolean reachedPoint() {
    if (movingLeft) {
      return this.x+width > 850;
    } else {
      return this.x < 850;
    }
  }

  void display() {
    fill(255, alpha);
    rect(x, y, width, 15);
  }
}