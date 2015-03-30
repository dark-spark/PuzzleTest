
int numberOfCircles = 6;
int gap = 100;
int size = 40;
int pos[] = new int[numberOfCircles];
IntList randomInts = new IntList();
color colors[] = {
  color(255, 0, 0), 
  color(0, 255, 0), 
  color(0, 0, 255), 
  color(255, 255, 0), 
  color(255, 0, 255), 
  color(0, 255, 255)
};
int t1;
int mode = 0;
PFont f1, f2, f3;
IntList ints = new IntList();
int bX = width/2;
int bY = (height/3) * 2;
int bS = 300;
int t0;
boolean [] set = new boolean[numberOfCircles];

circle [] circles = new circle[numberOfCircles * colors.length];
circle [] lights = new circle[numberOfCircles];
circle [] selection = new circle[numberOfCircles];

void setup() {

  size(800, 600);
  background(0);

  bX = width/2;
  bY = (height/3) * 2;

  f1 = createFont("Crystal", 100);
  f2 = createFont("BaskOldFace", 100);
  f3 = createFont("Arial Unicode MS", 12);

  int start = (width - (gap * (numberOfCircles - 1))) / 2;

  for (int i = 0; i < numberOfCircles; i++) {
    pos[i] = start + (gap * i);
  }

  for (int i = 0; i < numberOfCircles; i++) {
    ints.append(i);
  }

  int index = 0;
  for (int j = 0; j < colors.length; j++) {
    for (int i = 0; i < numberOfCircles; i++) {
      circles[index] = new circle(pos[i], (height/2) + (j * (size + 10)), size, colors[j]);
      index++;
    }
  }

  for (int i = 0; i < lights.length; i++) {
    lights[i] = new circle(pos[i], (height/4), 60, colors[i]);
  }

  for (int i = 0; i < selection.length; i++) {
    selection[i] = new circle(pos[i], (height/4) + 80, 60, color(0, 0, 0));
  }
}

void draw() {
  background(0);

  noStroke();
  fill(225);
  rectMode(CORNER);
  rect(0, 0, 500, 20); 
  fill(0);
  textFont(f3);
  text(mouseX, 130, 10);
  text(mouseY, 160, 10);

  switch(mode) {

  case 0: //Display rainbow and first button
    displayRainbow(frameCount);
    showLights();
    displayButton("ON");
    break;

  case 10: //Display timer ready for countdown and wait for click
    showTimer(500);
    displayButton("START");
    break; 

  case 20: //Display random circles and countdown timer
    displayRandom();
    showLights();
    mode = 30;
    t0 = millis() + 2000;
    break;

  case 30: //Display random circles and countdown timer
    showLights();
    int t = t0 - millis();
    t /= 10;
    showTimer(t);

    if ((millis() - t0) >= 0) {
      mode = 40;
    }
    break;

  case 40: //Display selection and wait for finish button press
    showCircles();
    showSelection();
    if (allSet()) {
      mode = 50;
    }
    break;

  case 50: //Display results and restart button
    showSelection();
    showLights();
    displayButton("RESET");
    break;
  }
}

boolean allSet() {
  boolean a = true;
  for (int i = 0; i < set.length; i++) {
    a &= set[i];
  }
  return a;
}

void mousePressed() {
  if (mouseX > (bX - (bS/2)) && mouseX < (bX+bS- (bS/2)) && mouseY > (bY - (bS/2)) && mouseY < (bY+(bS/2) - (bS/4)) && mode == 0) { 
    mode = 10;
  } else if (mouseX > (bX - (bS/2)) && mouseX < (bX+bS- (bS/2)) && mouseY > (bY - (bS/2)) && mouseY < (bY+(bS/2) - (bS/4)) && mode == 10) { 
    mode = 20;
  } else if (mouseX > (bX - (bS/2)) && mouseX < (bX+bS- (bS/2)) && mouseY > (bY - (bS/2)) && mouseY < (bY+(bS/2) - (bS/4)) && mode == 50) { 
    mode = 0;
  }

  if (mode == 40) {
    for (int i = 0; i < circles.length; i++) {
      if (circles[i].clicked(mouseX, mouseY)) {
        int col = i % 6;
        set[col] = true;
        selection[col].setColour(circles[i].getColour());
      }
    }
  }
}

void displayButton(String text) {
  fill(255, 0, 0);
  rectMode(CENTER);
  rect(bX, bY, bS, bS/2);
  fill(255, 255, 255);
  textFont(f2);
  textAlign(CENTER, CENTER);
  text(text, bX, bY);
}

void showTimer(int time) {
  textFont(f1);
  textAlign(CENTER);
  fill(255, 0, 0);
  char[] chars = millisToChar(time);
  String display = "" + chars[2] + chars[3] + ":" + chars[4] + chars[5];
  text(display, width/2, 90);
}  

char[] millisToChar(int micros) {

  char[] chars = new char[6];
  int minutes, seconds, msec;

  msec = micros % 100;
  minutes = (micros - msec) /  100 / 60;
  seconds = (micros - msec - (minutes * 60 * 100)) / 100;

  String min = str(minutes);
  String sec = str(seconds);
  String mse = str(msec);

  if (minutes > 9) {
    chars[0] = min.charAt(0);
    chars[1] = min.charAt(1);
  } else {
    chars[0] = '0';
    chars[1] = min.charAt(0);
  }

  if (seconds > 9) {
    chars[2] = sec.charAt(0);
    chars[3] = sec.charAt(1);
  } else {
    chars[2] = '0';
    chars[3] = sec.charAt(0);
  }

  if (msec > 9) {
    chars[4] = mse.charAt(0);
    chars[5] = mse.charAt(1);
  } else {
    chars[4] = '0';
    chars[5] = mse.charAt(0);
  }

  return chars;
}

void displayRandom() {
  ints.shuffle();
  for (int i = 0; i < numberOfCircles; i++) {
    lights[i].setColour(colors[ints.get(i)]);
  }
}

void showLights() {
  for (circle c : lights) {
    c.display();
  }
}

void showSelection() {
  for (circle c : selection) {
    c.display();
  }
}

void showCircles() {
  for (circle c : circles) {
    c.display();
  }
}

void displayRainbow(int frame) {
  int j = frame;

  for (int i = 0; i < numberOfCircles; i++) {
    lights[i].setColour(wheel(((i * 256 / numberOfCircles) + j) & 255));
  }
}

color wheel(int wheelPos) {
  wheelPos = 255 - wheelPos;
  if (wheelPos < 85) {
    return color(255 - wheelPos * 3, 0, wheelPos * 3);
  } else if (wheelPos < 170) {
    wheelPos -= 85;
    return color(0, wheelPos * 3, 255 - wheelPos * 3);
  } else {
    wheelPos -= 170;
    return color(wheelPos * 3, 255 - wheelPos * 3, 0);
  }
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
    fill(colour);
    ellipse(xpos, ypos, size, size);
  }

  void setColour(color c) {
    colour = c;
  }

  color getColour() {
    return colour;
  }

  boolean clicked(int x, int y) {
    if (x > xpos && x < xpos + size && y > ypos && y < ypos + size) {
      return true;
    } else {
      return false;
    }
  }
}


void delay(int delay) {  
  int time = millis();
  while (millis () - time <= delay);
}

void circles(int amount, int gap, int size) {
  int start = (width - (gap * (amount - 1))) / 2;
  for (int i = 0; i < amount; i++) {
    fill(255);
    ellipseMode(CENTER);
    ellipse(start + (gap * i), height / 2, size, size);
  }
}
