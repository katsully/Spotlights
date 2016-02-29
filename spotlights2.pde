import java.util.Iterator;
int rectWidth = 0;
int upperRectY = 0;
int upperRectHeight, lowerRectHeight;
int line1X2;
int line2X1;

ArrayList<Rect> rects = new ArrayList<Rect>();

int particleCount = 10001;
ArrayList<Particle> particles = new ArrayList<Particle>();

float circleMin = 10;
float circleMax = 20;

void setup() {
  fullScreen();
  background(0);
  upperRectHeight = height/2;
  lowerRectHeight = height/2;
  line1X2 = 0;
  line2X1 = width;
  for (int i=0; i<80; i++) {
    if (i<72) {
      rects.add(new Rect(0-(i*75), 700, random(75), random(175, 255), true));
      rects.add(new Rect(0-(i*75), 675, random(75), random(175, 255), true));
    }
    rects.add(new Rect(width+(i*75), 700, random(75), random(175, 255), false));
    rects.add(new Rect(width+(i*75), 675, random(75), random(175, 255), false));
  }
  for (int i=0; i<particleCount; i++) {
    particles.add(new Particle());
  }
}

void draw() {
  background(0);
  for (int i=0; i<8; i++) {
    fill(255);
    noStroke();
    if (i<4) {
      rect((width/8)*i*2, upperRectY, rectWidth, upperRectHeight);
    } else {
      rect((width/8)*(((i-4)*2)+1), height/2, rectWidth, lowerRectHeight);
    }
  }
  if (rectWidth<width/8) {
    rectWidth++;
  } else if (upperRectHeight > 0) {
    upperRectHeight--;
    upperRectY++;
    lowerRectHeight--;
  } else if (rects.size() > 0) {
    Iterator<Rect> itr = rects.iterator();
    while (itr.hasNext()) { 
      Rect rect = itr.next(); 
      rect.update();
      rect.display();
      if (rect.reachedPoint()) {
        itr.remove();
      }
    }
  } else if (particles.size() > 0) {
    translate(850, 800);
    Iterator<Particle> itr = particles.iterator();
    while (itr.hasNext()) { 
      Particle p = itr.next(); 
      p.update();
      if (p.current.y > height || (p.current.x > width || p.current.x < 0)) {
        itr.remove();
      }
    }
    println(particles.size());
  } else {
    float angle = 360/30;
    float radius = 0.0;
    beginShape();
    for (int i=0; i<30; i++) {
      radius = i%2==0 ? random(circleMin, circleMin*1.5) : random(circleMax*1.4, circleMax);
      float x = cos(radians(i * angle)) * radius;
      float y = sin(radians(i * angle)) * radius;
      vertex(x+width/2, y+height/2);
    }
    endShape(CLOSE);
    circleMin+=random(2);
    circleMax+=random(3);
  }
  saveFrame("lights-######.tif");
}