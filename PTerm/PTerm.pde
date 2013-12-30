TerminalManager terminalManager;
PVector target;
Terminal terminal3;

void setup() {
  size(500, 500);
  
  target = new PVector(width/2, height/2);
  
  terminalManager  = new TerminalManager();
  
  Terminal terminal = new Terminal("test window");
  terminal.setWindow(10, 10, 203, 203);
  terminalManager.add(terminal);
  
  Terminal terminal2 = new Terminal("test termianl 2");
  terminal2.setWindow(100, 100, 300, 300);
  terminalManager.add(terminal2);
  
  //Terminal 
  terminal3 = new Terminal("another Terminal!: set Target, position relatively");
  terminal3.setWindow(200, 50, 300, 60);
  terminal3.setLineNum(5);
  terminal3.setTarget(target);
  terminal3.setPositionRelatively(true);
  terminalManager.add(terminal3);
  
  Terminal terminal4 = new Terminal("Yet another Terminal!: set target");
  terminal4.setWindow(200, 200, 200, 60);
  terminal4.setLineNum(10);
  terminal4.setTarget(target);
  terminalManager.add(terminal4);
  
  //terminalManager.activate(terminal2);
}

void draw() {
  background(128);
  target.x = width/2 + 100 * cos(0.01 * frameCount);
  target.y = height/2 + 100 * sin(0.01 * frameCount);
  ellipse(target, 10);
  text("target", target.x + 5, target.y);
  terminalManager.update();
  terminalManager.draw();
  //text("(" + mouseX + ", " + mouseY + ")", 200, 200);
}

void keyPressed() {
  terminalManager.keyPressed();
}

void keyReleased() {
}

void mouseMoved() {
  terminalManager.mouseMoved();
}

void mousePressed() {
  terminalManager.mousePressed();
}

void mouseReleased() {
  terminalManager.mouseReleased();
}

void mouseDragged() {
  terminalManager.mouseDragged();
}
