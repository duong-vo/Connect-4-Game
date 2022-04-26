class ConnectFour {
  Cell[][] cells;
  private int player;
  private int moveCount;
  private boolean inProgress = true;
  private boolean highlighted = false; // use for highlighting which player turn


  ConnectFour(int rows, int cols) {
    if (rows < 4 || cols < 4) {
      throw new IllegalArgumentException("rows, cols must be >= 4");
    }
    cells = new Cell[rows][cols];

    // This would probably be better in a helper method.
    for (int row = 0; row < cells.length; row++) {
      for (int cell = 0; cell < cells[0].length; cell++) {
        cells[row][cell] = new Cell();
      }
    }
  }

  // Sets a cell to player 1, 2, or empty (0)
  void updateCell(int row, int col, int player) {
    cells[row][col].setPlayer(player);
    display();
  }

  // Displays all the cells, by calling each cell's display() method.
  void display() {
    for (int row = 0; row < cells.length; row++) {
      for (int cell = 0; cell < cells[0].length; cell++) {
        cells[row][cell].display(cell * CELL_WIDTH, row * CELL_WIDTH);
      }
    }
  }

  // Returns the number of rows in the game
  int getRows() {
    return cells.length;
  }

  // Returns the number of columns in the game
  int getCols() {
    return cells[0].length;
  }

  // These methods print useful information to the console
  void printRow(int row) {
    for (int i = 0; i < cells[row].length; i++) {
      print(cells[row][i].getPlayer() + " ");
    }
    println();
  }

  void printColumn(int col) {
    for (int i = 0; i < cells.length; i++) {
      println(cells[i][col].getPlayer());
    }
  }

  void printGrid() {
    for (int row = 0; row < cells.length; row++) {
      printRow(row);
    }
  }

  // return true if the game is in progress and false otherwise;
  boolean isInProgress() {
    return this.inProgress;
  }

  // setter and getter for highlighted instance variable
  void setHighlight(boolean highlighted) {
    this.highlighted = highlighted;
  }

  boolean getHighlight() {
    return this.highlighted;
  }

  void makeMove(int col) {
    if (inProgress) {
      for (int i = cells.length - 1; i >= 0; i--) {
        if (cells[i][col].getPlayer() == 0) {
          if (moveCount % 2 == 0) {
            player = 1;
            this.updateCell(i, col, player); 
            System.out.printf("Player %d at %d, %d \n", player, i, col);
          } else {
            player = 2;
            this.updateCell(i, col, player);
            System.out.printf("Player %d at %d, %d \n", player, i, col);
          }
          moveCount++;
          break;
        } else if (cells[0][col].getPlayer() != 0) {
          System.out.println("Column " + col + " is full!");
          break;
        }
      }
    } else {
      System.out.println("Game is over!");
    }
    checkTie();
    checkWin();
  }

  void checkWin() {
    // Check for winning through rows
    if (inProgress) {
      for (int i = 0; i < this.getRows(); i++) {
        for (int j = 0; j < this.getCols(); j++) {
          if (this.getPlayer(i, j) != 0 && this.getPlayer(i, j) == this.getPlayer(i, j+1)
            && this.getPlayer(i, j) == this.getPlayer(i, j+2) 
            && this.getPlayer(i, j) == this.getPlayer(i, j+3)) {

            // Highlight the winner  
            cells[i][j].winnerDisplay(j * CELL_WIDTH, i * CELL_WIDTH);
            cells[i][j].winnerDisplay((j + 1) * CELL_WIDTH, i * CELL_WIDTH);
            cells[i][j].winnerDisplay((j + 2) * CELL_WIDTH, i * CELL_WIDTH);
            cells[i][j].winnerDisplay((j + 3) * CELL_WIDTH, i * CELL_WIDTH);
            System.out.println("PLAYER " + player +  " WINS!");  
            this.inProgress = false;
            return;
          }
        }
      }

      // Check for winning through columns
      for (int i = 0; i < this.getRows(); i++) {
        for (int j = 0; j < this.getCols(); j++) {
          if (this.getPlayer(i, j) != 0 && this.getPlayer(i, j) == this.getPlayer(i + 1, j)
            && this.getPlayer(i, j) == this.getPlayer(i + 2, j) 
            && this.getPlayer(i, j) == this.getPlayer(i + 3, j)) {

            // Highlight the winner
            cells[i][j].winnerDisplay(j * CELL_WIDTH, i * CELL_WIDTH);
            cells[i][j].winnerDisplay(j * CELL_WIDTH, (i + 1) * CELL_WIDTH);
            cells[i][j].winnerDisplay(j * CELL_WIDTH, (i + 2) * CELL_WIDTH);
            cells[i][j].winnerDisplay(j * CELL_WIDTH, (i + 3) * CELL_WIDTH);


            System.out.println("PLAYER " + player +  " WINS!"); 
            this.inProgress = false;
            return;
          }
        }
      }

      // Check for diagonal win
      for (int i = 0; i < this.getRows(); i++) {
        for (int j = 0; j < this.getCols(); j++) {
          for (int diagonal = -1; diagonal <= 1; diagonal++) {
            if (this.getPlayer(i, j) != 0 
              && this.getPlayer(i, j) == this.getPlayer(i + 1 * diagonal, j+1)
              && this.getPlayer(i, j) == this.getPlayer(i + 2 * diagonal, j+2) 
              && this.getPlayer(i, j) == this.getPlayer(i + 3 * diagonal, j+3)) {

              // Highlight the winnder  
              cells[i][j].winnerDisplay(j * CELL_WIDTH, i * CELL_WIDTH);
              cells[i][j].winnerDisplay((j + 1) * CELL_WIDTH, (i + 1 * diagonal) * CELL_WIDTH);
              cells[i][j].winnerDisplay((j + 2) * CELL_WIDTH, (i + 2 * diagonal) * CELL_WIDTH);
              cells[i][j].winnerDisplay((j + 3) * CELL_WIDTH, (i + 3 * diagonal) * CELL_WIDTH);
              System.out.println("PLAYER " + player +  " WINS!");  
              this.inProgress = false;
              return;
            }
          }
        }
      }
    }
  }


  // This method check for a tie game
  void checkTie() {
    if (inProgress) {
      if (moveCount == this.getRows() * this.getCols()) {
        System.out.println("TIE GAME!");
        this.inProgress = false;
      }
    }
  }


  // a helper method to return player of a cell
  int getPlayer(int row, int col) {
    if (col < 0 || row < 0 || col >= this.getCols() || row >= this.getRows()) {
      return 0;
    }
    return cells[row][col].getPlayer();
  }


  // Turn on highlight which player turn is it
  void turnHighlight(int col) {
    if (moveCount % 2 == 0 && highlighted) {
      fill(255, 0, 0);
      circle(CELL_WIDTH * col + CELL_WIDTH/2, 0 + CELL_WIDTH/2, CELL_WIDTH * 0.9);
      fill(100);
      circle(CELL_WIDTH * col + CELL_WIDTH/2, 0 + CELL_WIDTH/2, CELL_WIDTH * 0.7);
    } else {
      fill(0);
      circle(CELL_WIDTH * col + CELL_WIDTH/2, 0 + CELL_WIDTH/2, CELL_WIDTH * 0.9);
      fill(100);
      circle(CELL_WIDTH * col + CELL_WIDTH/2, 0 + CELL_WIDTH/2, CELL_WIDTH * 0.7);
    }
  }

  void initializeGame() {
    moveCount = 0;
    inProgress = true;
    cells = new Cell[this.getRows()][this.getCols()];

    for (int row = 0; row < cells.length; row++) {
      for (int cell = 0; cell < cells[0].length; cell++) {
        cells[row][cell] = new Cell();
      }
    }
    this.display();
  }
}
