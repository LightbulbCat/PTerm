interface Managed {
  
  /* Update and Draw */
  void update();
  void draw();
  
  /* Event */
  void setMousePressed(boolean isMousePressed);
  void setMouseDragged(boolean isMouseDragged);
  void setMouseOvered(boolean isMouseOvered);
  
  boolean isMousePressed();
  boolean isMouseDragged();  
  boolean isMouseOvered();

  boolean mousePressed();
  boolean mouseClicked();
  boolean mouseDragged();
  boolean mouseReleased();
  boolean mouseMoved();
  boolean keyPressed();

  /* Accessor */
  void setManager(Manager manager);
  Manager getManager();  
}



class DefaultManaged implements Managed {
  
  boolean isMousePressed = false;
  boolean isMouseDragged = false;
  boolean isMouseOvered = false;
  
  Manager manager;
  
  
  /* Update and Draw */
  
  void update() {
  }
  
  void draw() {
  }
  
  
  /* Event */
  
  void setMousePressed(boolean isMousePressed){
    this.isMousePressed = isMousePressed;
  }
  void setMouseDragged(boolean isMouseDragged){
    this.isMouseDragged = isMouseDragged;
  }
  void setMouseOvered(boolean isMouseOvered){
    this.isMouseOvered = isMouseOvered;
  }
  
  boolean isMousePressed(){
    return isMousePressed;
  }
  boolean isMouseDragged(){
    return isMouseDragged;
  }
  boolean isMouseOvered(){
    return isMouseOvered;
  }

  boolean mousePressed(){
    return false;
  }
  boolean mouseClicked(){
    return false;
  }
  boolean mouseDragged(){
    return false;
  }
  boolean mouseReleased(){
    return false;
  }
  boolean mouseMoved(){
    return false;
  }
  
  boolean keyPressed(){
    return false;
  }
  
  
  /* Accessor */
  
  void setManager(Manager manager) {
    this.manager = manager;
  }
  
  Manager getManager() {
    return manager;
  }
}



class Manager<T extends Managed> extends ArrayList<T> implements Managed { 
  
  Manager parentManager = null;
  
  boolean isMousePressed = false;
  boolean isMouseDragged = false;
  boolean isMouseOvered = false;
  
  
  
  /* Update and Draw */
  
  void update() {
    updateManagings();
  }
  
  void updateManagings() {
    for(int i = 0; i < size(); i++) get(i).update();
  }
  
  void draw() {
    drawManagings();
  }
  
  void drawManagings() {
    for(int i = size() - 1; i >= 0; i--) get(i).draw();
  }
  
  
  
  /* Event */
  
  void setMousePressed(boolean isMousePressed){
    this.isMousePressed = isMousePressed;
  }
  void setMouseDragged(boolean isMouseDragged){
    this.isMouseDragged = isMouseDragged;
  }
  void setMouseOvered(boolean isMouseOvered){
    this.isMouseOvered = isMouseOvered;
  }
  
  boolean isMousePressed(){
    return isMousePressed;
  }
  boolean isMouseDragged(){
    return isMouseDragged;
  }
  boolean isMouseOvered(){
    return isMouseOvered;
  }

  boolean mousePressed() {
    boolean done = false;    
    for(int i = 0; i < size(); i++) {
        done = get(i).mousePressed();
        if(done) break;
    }
    return done;
  }
  
  boolean mouseClicked() {
    boolean done = false;    
    for(int i = 0; i < size(); i++) {
      done = get(i).mouseClicked();
      if(done) break;
    }
    return done;
  }
  
  boolean mouseDragged() {
    boolean done = false;    
    for(int i = 0; i < size(); i++) {
      done = get(i).mouseDragged();
      if(done) break;
    }
    return done;
  }
  
  boolean mouseReleased() {
    boolean done = false;    
    for(int i = 0; i < size(); i++) {
      get(i).mouseReleased();
    }
    return done;
  }
 
  boolean mouseMoved() {
    boolean done = false;    
    for(int i = 0; i < size(); i++) {
      done = get(i).mouseMoved();
      if(done) break;
    }
    return done;
  }
  
  boolean keyPressed() {
    boolean done = false;    
    for(int i = 0; i < size(); i++) {
      done = get(i).keyPressed();
      if(done) break;
    }
    return done;
  }
  
  
  
  /* Accessor (and so on) */
  
  void setManager(Manager manager) {
    this.parentManager = manager;
  }
  
  Manager getManager() {
    return parentManager;
  }
  
  boolean add(T managed) {
    managed.setManager(this);
    return super.add(managed);
  }
}
