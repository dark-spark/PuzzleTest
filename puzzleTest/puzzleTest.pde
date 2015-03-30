
int numberOfCircles = 6;
int gap = 100;
int pos[] = new int[numberOfCircles];
IntList randomInts = new IntList();
 color colors[] = {
 color(255,0,0),
 color(0,255,0),
 color(0,0,255),
 color(255,255,0),
 color(255,0,255),
 color(0,255,255),
 color(255,128,0),
 color(255,0,128),
 color(128,255,0)};
char mode = 'd';
int t1;

void setup() {
  
  size(800,600);
  background(0);
  
  int start = (width - (gap * (numberOfCircles - 1))) / 2;
  
  for(int i = 0; i < numberOfCircles; i++) {
    pos[i] = start + (gap * i);
  }
  
  for(int j = 0; j < 30; j++){
    IntList ints = new IntList();
  for(int i = 0; i < numberOfCircles; i++) {
    ints.append(i);
  }
  ints.shuffle();
  print("{");
  for(int k = 0; k < ints.size(); k++) {
    print(ints.get(k));
    print(",");
  }
  println("}");
  }
  t1 = millis();
}

void draw() {
  background(0);
  switch(mode) {
    case 'd':
      noStroke();
      ellipseMode(CENTER);
      for(int i = 0; i < numberOfCircles; i++) {
        fill(colors[randomInts.get(i)]);
        ellipse(pos[i], height / 4, 40, 40);
      }
      if(millis() - t1 > 5000) {
        mode = 'i';
      }
      break;
    case 'i':
      noStroke();
      ellipseMode(CENTER);
      for(int i = 0; i < numberOfCircles; i++) {
        for(int j = 0; j < numberOfCircles; j++) {
          fill(colors[j]);
          ellipse(pos[i], ((height / 2)) + (j * 40), 40, 40);
        }
      }
      break;
  }
}


void delay(int delay) {  
  int time = millis();
  while (millis () - time <= delay);
}

class circle {
  int ypos, xpos, size;
  color colour;
  
  circle(int x, int y, int s, color c) {
    ypos = y;
    xpos = x;
    colour = c;
    size = s;
  }
  
  void display() {
    ellipse(xpos, ypos, size, size);
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
