class BoundingBox {
  
  float top = 0;
  float left = 0;
  float bottom = 0;
  float right = 0;
  float boxWidth = 0;
  float boxHeight = 0;
  
  ArrayList<BoundingBox> bindings;
  
  boolean bgBlur = false;
  
  
  /* Constructor */
  
  BoundingBox() {
    initialize();
  }
    
  BoundingBox(float left, float top, float boxWidth, float boxHeight) {
    this.left = left;
    this.top = top;
    this.boxWidth = boxWidth;
    this.boxHeight = boxHeight;
    this.right = left + boxWidth;
    this.bottom = top + boxHeight;
    initialize();
  }
  
  void initialize() {
    bindings = new ArrayList<BoundingBox>();
  }
 
  
  /* Accessor (and so on) */
  
  void set(float left, float top, float boxWidth, float boxHeight) {
    this.left = left;
    this.top = top;
    this.boxWidth = boxWidth;
    this.boxHeight = boxHeight;
    this.right = left + boxWidth;
    this.bottom = top + boxHeight;
  }
  
  void setSize(float boxWidth, float boxHeight) {
    this.boxWidth = boxWidth;
    this.boxHeight = boxHeight;
  }

  void move(float x, float y) {
    set(left + x, top + y, boxWidth, boxHeight);
    for(BoundingBox b: bindings) b.move(x, y);
  }
  
  void moveTo(float left, float top) {
    move(left - this.left, top - this.top);
  }
  
  void addBinding(BoundingBox binding) {
    bindings.add(binding);
  }
  
  void draw() {
    if(bgBlur) {
      PImage bg = screenCapture((int) left, (int) top, (int) boxWidth, (int) boxHeight);
      bg.filter(BLUR, 2);
      image(bg, left, top);
      rect(left, top, boxWidth, boxHeight);
    } else {
      roundedRect(left, top, boxWidth, boxHeight, 4);
    }
  }
  
  boolean mouseOvered() {
    return ((left < mouseX && mouseX < right) && (top < mouseY && mouseY < bottom)) ? true : false;
  }
  
  void setBGBlur(boolean bgBlur) {
    this.bgBlur = bgBlur;
  }
  
  PImage screenCapture(int x, int y, int w, int h) {
    if(x + w > width) w = width - x;
    if(y + h > height) h = height - y;
    PImage img = createImage(w, h, RGB);
    img.loadPixels();
    loadPixels();
    for(int i = 0; i < h; i++) {
      for(int j = 0; j < w; j++) {
        img.pixels[i * w + j] = pixels[(i + y) * width + (x + j)];
      }
    }
    return img;
  }
  
  
  void roundedRect(PVector pos, PVector dim, float r) {
    roundedRect(pos.x, pos.y, dim.x, dim.y, r);
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
      sX = x + w; eX = x + w - r;
      sY = y + h - r; eY = y + h;
      vertex(sX, sY); bezierVertex(sX, sY + a, eX + a, eY, eX, eY);
      sX = x + r; eX = x;
      sY = y + h; eY = y + h - r;
      vertex(sX, sY); bezierVertex(sX - a, sY, eX, eY + a, eX, eY);
      sX = x; eX = x + r;
      sY = y + r; eY = y;
      vertex(sX, sY); bezierVertex(sX, sY - a, eX - a, eY, eX, eY);
      sX = x + w -r; eX = x + w;
      sY = y; eY = y + r;
      vertex(sX, sY); bezierVertex(sX + a, sY, eX, eY - a, eX, eY);
      vertex(eX, eY);
    endShape(CLOSE); 
  }
}
