
int numberOfCircles = 5;
int gap = 100;
int pos[] = new int[numberOfCircles];

void setup() {
  size(800,600);
  background(0);
  int start = (width - (gap * (numberOfCircles - 1))) / 2;
  for(int i = 0; i < numberOfCircles; i++) {
    pos[i] = start + (gap * i);
  }
}

void draw() {
  stroke(255);
  fill(255);
  ellipseMode(CENTER);
  for(int i = 0; i < numberOfCircles; i++) {
    ellipse(pos[i], height / 2, 40, 40);
  }
}

void circles(int amount, int gap, int size) {
  int start = (width - (gap * (amount - 1))) / 2;
  for(int i = 0; i < amount; i++) {
    fill(255);
    ellipseMode(CENTER);
    ellipse(start + (gap * i), height / 2, size, size);
  }
}
