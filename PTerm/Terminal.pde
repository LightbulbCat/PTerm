class Terminal extends DefaultManaged {

  String name;
  
  TerminalManager manager;
  
  ArrayList<String> buffer;
  
  BoundingBox window;
  BoundingBox header;
  BoundingBox inner;
  BoundingBox content;
  
  Button closeButton;

  float lineHeight;
  float textHeight;
  float padding = 5;
  int nLine;

  float bgOpacity = 192;
  
  boolean isMousePressed = false;

  PVector target = null;
  PVector posRelative = null;
  boolean positionRelatively = false;
  
  boolean isHidden = false;
  boolean fullWindow = false;
  
  boolean debug = true;



  /* Constractor */

  Terminal(String name) {
    this.name = name;
    initialize();
  }

  void initialize() {
    buffer = new ArrayList<String>();
    buffer.add("");
    
    window = new BoundingBox();
    
    header = new BoundingBox();
    window.addBinding(header);
    
    inner = new BoundingBox();
    window.addBinding(inner);
    
    content = new BoundingBox();
    window.addBinding(content);
    
    nLine = 1;
    setTextSize(10);
    
    closeButton = new CloseButton();
    closeButton.setSize(10);
  }
  
  

  /* Update and Draw */

  void update() {
    if(!isHidden && positionRelatively && !isMousePressed) moveTo(target.x + posRelative.x, target.y + posRelative.y);
  }

  void draw() {
    if(!isHidden) {
      if(target != null) {
        stroke(0, 128); fill(0, 64); strokeWeight(2);
        drawTargetPointer();
        strokeWeight(1);
        stroke(255, 128); noFill();
        drawTargetPointer();
      }
      
      stroke(128, bgOpacity); fill(0, bgOpacity); 
      textSize(textHeight);
      window.draw();
      
      if(closeButton.isMouseOvered()) {
        stroke(255, 64); fill(255, 16);
      } else {
        stroke(255, 64); noFill();
      }
      closeButton.draw();
      
      stroke(128, bgOpacity/2); fill(255, 16);
      inner.draw();
      
      noStroke(); 
      fill(255);
      text(name, header.left, header.top, header.boxWidth, header.boxHeight);
      
      float linePosition = padding;
      for (int i = 0; i < buffer.size(); i++) {            
        noStroke(); 
        fill(255);
        text(buffer.get(i), content.left, content.top + linePosition, content.boxWidth, lineHeight);
        
        linePosition += lineHeight;
        if (linePosition > content.boxHeight) break;
      }
    }
  }
  
  void drawTargetPointer() {
    if (
      (target.x <= window.left || window.right <= target.x) ||
      (target.y <= window.top || window.bottom <= target.y)
    ) {
      PVector windowCenter = new PVector(window.left + window.boxWidth, window.top + window.boxHeight);
      PVector pointerBase = new PVector();
      float pointerInset = 3;
      if (target.x <= windowCenter.x && target.y <= windowCenter.y) {
        pointerBase.set(window.left + pointerInset, window.top + pointerInset, 0);
      } else if (target.x <= windowCenter.x && target.y > windowCenter.y) {
        pointerBase.set(window.left + pointerInset, window.bottom - pointerInset, 0);
      } else if (target.x > windowCenter.x && target.y <= windowCenter.y) { 
        pointerBase.set(window.right - pointerInset , window.top + pointerInset, 0);
      } else if (target.x > windowCenter.x && target.y > windowCenter.y) {
        pointerBase.set(window.right - pointerInset, window.bottom - pointerInset, 0);
      }
      //println(pointerBase);
      line(pointerBase, target);
      ellipse(target, 10);
    }
  }
  
  
  
  /* Event */

  boolean keyPressed() {
    if (key == ENTER || key == RETURN) {
      inputCr();
    } 
    else if (key == DELETE || key == BACKSPACE) {
      inputDelete();
    } 
    else if (key == TAB) {
      inputTab();
    } 
    else if (key != CODED) {
      input(key);
    }
    if (debug) println("EVENT.TERMINAL.KEY.PRESSED: " + key + " -> " + name);
    
    return true;
  }
  
  void input(char c) {
    buffer.set(buffer.size() - 1, buffer.get(buffer.size() - 1) + c);
  }
  
  void input(String str) {
    buffer.set(buffer.size() - 1, buffer.get(buffer.size() - 1) + str);
  }  
  
  void inputln(String str) {
    input(str);
    inputCr();
  }  
  
  void inputCr() {
    buffer.add("");
    if (buffer.size() > nLine) buffer.remove(0);
  }
  
  void inputDelete() {
    if (buffer.size() > 0) {
      String deleted = buffer.remove(buffer.size() - 1);
      if (deleted.length() > 0) deleted = deleted.substring(0, deleted.length()-1);
      buffer.add(deleted);
    }
  }
  
  void inputTab() {
    input("    ");
  }
  
  
  boolean mousePressed() {
    boolean done = false;
    if (closeButton.isMouseOvered()) {
      hide();
      done = true;
    } else if (header.mouseOvered()) {
      isMousePressed = true;
      done = true;
      if (debug) println("EVENT.TERMINAL.MOUSE.PRESSED: " + name);
    } 
    else if (window.mouseOvered()) {
      done = true;
    }
    return done;
  }
  
  boolean mouseReleased() {
    boolean done = false;
    if(isMousePressed) {
      if(debug) println("EVENT.TERMINAL.CLOSEBUTTON.PRESSED");
      if(positionRelatively) setRelativePosition();
      isMousePressed = false;
    }
    if (debug) println("EVENT.TERMINAL.RELEASED: " + name);
    return done;
  }
  
  boolean mouseDragged() {
    boolean done = false;
    if (isMousePressed) {
      move(mouseX - pmouseX, mouseY - pmouseY);
      if (debug) println("EVENT.TERMINAL.DRAGGED: " + name);
    }
    return done;
  }
  
  
  
  /* Accessor (and so on) */

  void setWindow(float left, float top, float width, float height) {
    window.set(left, top, width, height);
    //window.setBGBlur(true);
    
    header.set(left + padding, top + padding, width - 2 * padding, lineHeight);
    inner.set(left + padding, top + lineHeight + padding, width - 2 * padding, height - lineHeight - 2 * padding);
    content.set(left + padding * 2, top + lineHeight + padding, width - 4 * padding, height - lineHeight - 3 * padding);
    
    setButtonPosition();
    
    nLine = floor(inner.boxHeight / lineHeight);
  }
  
  void setLineNum(int nLine) {
    setWindow(window.left, window.top, window.boxWidth, lineHeight * (nLine + 1) + 4 * padding);
  }
  
  void setTarget(PVector target) {
    this.target = target;
  }
  
  void unsetTarget() {
    this.target = null;
    setPositionRelatively(false);
  }
  
  void setPositionRelatively(boolean positionRelatively) {
    this.positionRelatively = positionRelatively;
    setRelativePosition();
  }
  
  void setRelativePosition() {
    this.posRelative = new PVector(window.left - target.x, window.top - target.y);
  }
  
  void setButtonPosition() {
    closeButton.setPosition(window.right - (lineHeight + padding)/2, window.top + (lineHeight + padding)/2);
  }
  
  void move(float x, float y) {
    window.move(x, y);
    setButtonPosition();
  }
  
  void moveTo(float x, float y) {
    window.moveTo(x, y);
    setButtonPosition();
  }
  
  void hide() {
    isHidden = true;
  }
  
  void show() {
    isHidden = false;
    if(positionRelatively) moveTo(target.x + posRelative.x, target.y + posRelative.y);
  }
    
  void clear() {
    buffer.clear();
    buffer.add("");
  }
  
  void fullWindow(boolean fullWindow) {
    this.fullWindow = fullWindow;
  }
  
  void setManager(TerminalManager manager) {
    this.manager = manager;
  }
  
  void setBGOpacity(float bgOpacity) {
    this.bgOpacity = bgOpacity;
  }

  void setTextSize(float size) {
    textHeight = size;
    lineHeight = size + 5;
  }

  void setDebug(boolean debug) {
    this.debug = debug;
  }
}

