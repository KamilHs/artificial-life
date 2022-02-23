public class Grid {
  public GridCell[][] cells;
  public Grid() {
    cells = new GridCell[cols][rows];
    for (int i = 0; i < cols; ++i) {
      for (int j = 0; j < rows; ++j) {
        cells[i][j] = new GridCell(j, i);
      }
    }
  }

  void draw() {
    for (int i = 0; i < cols; ++i) {
      for (int j = 0; j < rows; ++j) {
        cells[i][j].draw();
        cells[i][j].update();
      }
    }
  }
}
