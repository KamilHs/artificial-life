public class Wood extends Cell {
  public Cell[] cells = new Cell[4];
  public int age = 0;

  public Wood(int sectorId, int x, int y, UUID organizmId, float angle, Wood parent) {
    super(sectorId, x, y, organizmId, 0, angle, WoodConfig.organicAfterDeath, WoodConfig.chargeAfterDeath, parent);
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

  public boolean doesntGenerate(int level){
    boolean hasGenerate = Arrays.asList(cells).stream().filter(c -> c != null && !(c instanceof Offshoot) && !(c instanceof Wood)).count() == 0;

    return level == 0 || parent == null ? hasGenerate : hasGenerate && parent.doesntGenerate(level - 1);
  }

  public void _live() {
    if(parent != null && !parent.isAlive()){
      parent = null;
    }
    if(age++ > WoodConfig.lifetime || grid.cells[y][x].isOrganicallyPoisoned() || grid.cells[y][x].isTooCharged() || doesntGenerate(4)) {
      long nbOfChildren = Arrays.asList(cells).stream().filter(c -> c != null && c instanceof Wood).count();
      float energyPerCell = parent == null ? getEnergy() / nbOfChildren : 0;

      for (Cell cell : cells) {
        if(cell != null && cell instanceof Wood){
          cell.organizmId = UUID.randomUUID();
          organizmEnergies.put(cell.organizmId, energyPerCell);
        }
      }
      if(parent == null){
        organizmEnergies.remove(organizmId);
      }
      
      kill();
    }
  }
}
