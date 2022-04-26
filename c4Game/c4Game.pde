ConnectFour cf;

// We set these here so that the sketch will be the right
// size. Because of how Processing works, all classes have
// access to these constants. So you can (and should) use
// them in the other classes.
final int ROWS = 6;
final int COLS = 7;
final int CELL_WIDTH = 100;

void settings() {
  size(COLS * CELL_WIDTH, ROWS * CELL_WIDTH);
}

void setup() {  
  cf = new ConnectFour(ROWS, COLS); 
  cf.display();
  //cf.updateCell(0, 0, 1);
}
// The column is based on the mouse's x-coordinate
void mousePressed() {
  int whichCol = int(mouseX / CELL_WIDTH);
  cf.makeMove(whichCol);
}

void keyPressed() {
  if (key == 'R') {
    cf.initializeGame();
  }
}

void mouseMoved() {
  int whichCol = int(mouseX / CELL_WIDTH);
  if (cf.getHighlight() == false && cf.isInProgress()) {
    cf.display();
    cf.setHighlight(true);
    cf.turnHighlight(whichCol);
  } else {
    cf.setHighlight(false);  
  }
  
}

  // This method needs to exist, even when there is no
  // code in it. Otherwise, keyPressed and mousePressed won't work.
  void draw() {
  }
