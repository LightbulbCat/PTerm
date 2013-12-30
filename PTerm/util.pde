
void line(PVector p1, PVector p2) {
  line(p1.x, p1.y, p2.x, p2.y);
}

void ellipse(PVector pos, PVector dim) {
  ellipse(pos.x, pos.y, dim.x, dim.y);
}

void ellipse(PVector pos, float dim) {
  ellipse(pos.x, pos.y, dim, dim);
}

void ellipse(PVector pos, float width, float height) {
  ellipse(pos.x, pos.y, width, height);
}

void rect(PVector pos, float size) {
  rect(pos.x, pos.y, size, size);
}

void text(int data, PVector pos) {
  text(data, pos.x, pos.y);
}

PVector linearTransformation(float x, float y, float a11, float a12, float a21, float a22) {
  return new PVector(x * a11 + y * a12, x * a21 + y * a22);
}

boolean pointInPolygon(PVector pTarget, PVector[] area) {

  int nCountCrossing = 0;
  
  PVector p0 = area[0];
  boolean frag0x = (pTarget.x <= p0.x);
  boolean frag0y = (pTarget.y <= p0.y);
  
  for(int i = 1; i < area.length + 1; i++) {
    PVector p1 = area[i % area.length];
    boolean frag1x = (pTarget.x <= p1.x);
    boolean frag1y = (pTarget.y <= p1.y);
    
    if(frag0y != frag1y) {
      if(frag0x == frag1x) {
    if(frag0x) {
      nCountCrossing += (frag0y ? -1 : 1);
    }
      } else {
  if(pTarget.x <= (p0.x + (p1.x - p0.x) * (pTarget.y - p0.y ) / (p1.y - p0.y))) {
      nCountCrossing += (frag0y ? -1 : 1);
        }
      }
    }
    
    p0 = p1;
    frag0x = frag1x;
    frag0y = frag1y;
  }
  
  return (0 != nCountCrossing);
}

boolean overwrapPolygons(PVector[] p1, PVector[] p2) {
  
  boolean overwrap = false;
  
  for(int i = 0; i < p2.length; i++) {
    if(pointInPolygon(p2[i], p1)) {
      overwrap = true;
      break;
    }
  }
  
  return overwrap;
}

PVector dividingPoint(PVector p1, PVector p2, float rate) {
  float m = rate;
  float n = 1 - rate;
  float x = p1.x * n + p2.x * m;
  float y = p1.y * n + p2.y * m;
  
  return new PVector(x, y);
}

float frameCount() {
  return frameCount;
}


  
