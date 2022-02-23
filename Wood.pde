public class Wood extends Cell {
  public Cell[] cells = new Cell[4];
  public EnergyStorage storage;
  public int age = 0;

  public Wood(int sectorId, int x, int y, UUID organizmId, float angle, Wood parent) {
    super(sectorId, x, y, organizmId, WoodConfig.initialEnergy, angle, WoodConfig.organicAfterDeath, parent);
    storage = parent != null ? parent.storage: new EnergyStorage(0);
  }

  public void _draw() {
    stroke(128, 0, 0);
    strokeWeight(WoodConfig.size);
    strokeCap(PROJECT);
    point(0, 0);
    strokeCap(SQUARE);


    for (int i = 0; i < 4; ++i) {
      Cell cell = cells[i];
      if (cell != null) {
        if (!cell.isAlive()) {
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

  public void replaceChild(Cell prevChild, Cell newChild) {
    for (int i = 0; i < 4; ++i) {
      if (prevChild == cells[i])
      {
        cells[i] = newChild;
        return;
      }
    }
  }

  public void _live() {
    if(parent != null && !parent.isAlive()){
      storage = new EnergyStorage(0);
      parent = null;
    }
    if(grid.cells[y][x].isOrganicallyPoisoned())
      kill();
    if(age++ > WoodConfig.lifetime) kill();
  }
}
