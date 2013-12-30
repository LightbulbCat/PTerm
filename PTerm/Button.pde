interface Button {
  
  void draw();
  
  void setPosition(PVector pos);
  void setPosition(float x, float y);
  void setSize(float size);
  boolean isMouseOvered();
}



class DefaultButton implements Button {
  
  PVector pos;
  float size = 10;
  
  /* Constructor */
  
  DefaultButton() {
    this.pos = new PVector();
  }
  
  DefaultButton(PVector pos, float size) {
    this.pos = pos;
    this.size = size;
  }
  
  /* Draw */
  
  void draw() {
    rect(pos, size);
  }
  
  /* Accessor */
  
  void setPosition(PVector pos) {
    this.pos = pos;
  }
  
  void setPosition(float x, float y) {
    this.pos.x = x;
    this.pos.y = y;
  }
  
  void setSize(float size) {
    this.size = size;
  }
  
  boolean isMouseOvered() {
    return pos.x < mouseX && mouseX < pos.x + size && pos.y < mouseY && mouseY < pos.y + size;
  } 
}




class CircleButton extends DefaultButton {
  
  CircleButton() {
    super();
  }
  
  CircleButton(PVector pos, float size) {
    super(pos, size);
  }
  
  void draw() {
    ellipse(pos, size);
  }
  
  boolean isMouseOvered() {
    float x = mouseX - pos.x;
    float y = mouseY - pos.y;
    return x * x + y * y < size * size;
  }
}



class CloseButton extends CircleButton {
  
  float clossLeft;
  float clossTop;
  float clossRight;
  float clossBottom;
  
  CloseButton() {
    super();
  }
  
  CloseButton(PVector pos, float size) {
    super(pos, size);
  }
  
  void setClossPosition() {
    float clossSize = size * 0.3;
    clossLeft = pos.x - clossSize;
    clossTop = pos.y - clossSize;
    clossRight = pos.x + clossSize;
    clossBottom = pos.y + clossSize;
  }
  
  void setPosition(float x, float y) {
    super.setPosition(x, y);
    setClossPosition();
  }
  
  void setPosition(PVector pos) {
    super.setPosition(pos.x, pos.y);
    setClossPosition();
  }
  
  void setSize(float size) {
    super.setSize(size);
    setClossPosition();
  }
  
  void draw() {
    if(isMouseOvered()) {
      line(clossLeft, clossTop, clossRight, clossBottom);
      line(clossLeft, clossBottom, clossRight, clossTop);
    }
    ellipse(pos, size);
  }
}
  
  
