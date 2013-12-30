void text(String str, BoundingBox box) {
  text(str, box.left, box.top, box.boxWidth, box.boxHeight);
}

void roundedRect(PVector pos, PVector dim, float r) {
  roundedRect(pos.x, pos.y, dim.x, dim.y, r);
}

void roundedRect(float x, float y, float w, float h, float r, int resolution) {
  
  if(w < 2 * r) r = w / 2;
  if(h < 2 * r) r = h / 2;
  
  float top = x + r;
  float bottom = x + w - r;
  float left = y + r;
  float right = y + h - r;
  
  float argStep = TWO_PI / (resolution * 4);

  beginShape();
    for(int i = 0; i < resolution + 1; i++) {
      float arg = argStep * i;
      vertex(bottom + r * cos(arg), right + r * sin(arg));
    }
    for(int i = resolution; i < resolution * 2 + 1; i++) {
      float arg = argStep * i;
      vertex(top + r * cos(arg), right + r * sin(arg));
    }
    for(int i = resolution * 2; i < resolution * 3 + 1; i++) {
      float arg = argStep * i;
      vertex(top + r * cos(arg), left + r * sin(arg));
    }
    for(int i = resolution * 3; i < resolution * 4 + 1; i++) {
      float arg = argStep * i;
      vertex(bottom + r * cos(arg), left + r * sin(arg));
    }
  endShape(CLOSE); 
}

void roundedRect(float x, float y, float w, float h, float r) {
  
  if(w < 2 * r) r = w / 2;
  if(h < 2 * r) r = h / 2;
  
  float a = 4 * (sqrt(2) - 1) / 3 * r;
  
  float top = x + r;
  float bottom = x + w - r;
  float left = y + r;
  float right = y + h - r;
  
  int resolution = 4;
  float argStep = TWO_PI / (resolution * 4);

  float sX, sY, eX, eY;
  beginShape();
    sX = x + w;
    eX = x + w - r;
    sY = y + h - r;
    eY = y + h;
    vertex(sX, sY); bezierVertex(sX, sY + a, eX + a, eY, eX, eY);
    sX = x + r;
    eX = x;
    sY = y + h;
    eY = y + h - r;
    vertex(sX, sY); bezierVertex(sX - a, sY, eX, eY + a, eX, eY);
    sX = x;
    eX = x + r;
    sY = y + r;
    eY = y;
    vertex(sX, sY); bezierVertex(sX, sY - a, eX - a, eY, eX, eY);
    sX = x + w -r;
    eX = x + w;
    sY = y;
    eY = y + r;
    vertex(sX, sY); bezierVertex(sX + a, sY, eX, eY - a, eX, eY);
    vertex(eX, eY);
  endShape(CLOSE); 
}


