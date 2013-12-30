class TerminalManager extends Manager<Terminal> {
  
  Terminal activeTerminal = null;
  
  
  /* Event */
  
  boolean keyPressed() {
    if(activeTerminal != null) activeTerminal.keyPressed();
    return true;
  }
  
  boolean mousePressed() {
    boolean done = false;
    for(int i = 0; i < this.size(); i++) {
      if(!get(i).isHidden && get(i).mousePressed()) {
        done = true;
        activate(this.get(i));
        break;
      }
    }
    return done;
  }
  
  
  /* Accessor (and os on) */
  
  void activate(Terminal terminal) {
    if(this.contains(terminal)) {
      this.remove(terminal);
      this.add(0,terminal);
      activeTerminal = terminal;
    }
  }
  
  void inputln(String str) {
    if(activeTerminal != null) activeTerminal.inputln(str);
  }

  void showAll() {
    for(Terminal t: this) t.show();
  }

  void hideAll() {
    for(Terminal t: this) t.hide();
  }
  
  void setDebug(boolean debug) {
    for(Terminal t: this) t.setDebug(debug);
  }
}

