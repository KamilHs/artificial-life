public class Wood extends Cell {
  public Cell[] cells = new Cell[4];

  public Wood(int sectorId, int x, int y, UUID organizmId, float angle, Cell parent) {
    super(sectorId, x, y, organizmId, WoodConfig.initialEnergy, angle, WoodConfig.organicAfterDeath, parent);
  }

  public void _draw() {
    stroke(255, 0, 0);
    strokeWeight(WoodConfig.size);
    strokeCap(PROJECT);
    point(0, 0);
    strokeCap(SQUARE);


    for (int i = 0; i < 4; ++i) {
      Cell cell = cells[i];
      if (cell != null) {
        if(!cell.isAlive()){
          cells[i] = null;
          continue;
        }

        boolean isOnTheEdge = abs(cell.x - x) + abs(cell.y - y) > 1;

        if (!isOnTheEdge) {
          line(0, 0, (cell.x - x) * GridCellConfig.size / 2, (cell.y - y) * GridCellConfig.size / 2);
        } else if (x < cell.x) {
          line(0, 0, -GridCellConfig.size / 2, 0);
        } else if (x > cell.x) {
          line(0, 0, GridCellConfig.size / 2, 0);
        } else if (y < cell.y) {
          line(0, 0, 0, -GridCellConfig.size / 2);
        } else {
          line(0, 0, 0, GridCellConfig.size / 2);
        }
      }
    }
  }

  public void _live() {
  }
}
