public class Offshoot extends Cell {
  public float angle;
  public int programCounter = 0;
  public DNA dna;

  public Offshoot(int sectorId, int x, int y) {
    this(sectorId, x, y, UUID.randomUUID(), new DNA(), 0.0, null);
  }

  public Offshoot(int sectorId, int x, int y, UUID organizmId, DNA dna, float angle, Cell parent) {
    super(sectorId, x, y, organizmId, OffshootConfig.initialEnergy, OffshootConfig.organicAfterDeath, parent);
    this.dna = dna;
    this.angle = angle;
  }

  public void move() {
    programCounter = programCounter % DNAConfig.movementSize;
    byte command = dna.movement[programCounter];
    byte nextCommandCounter = byte((programCounter + 1) % DNAConfig.movementSize);
    byte nextCommand = dna.movement[nextCommandCounter];
    MovementEnum commandEnum = MovementEnum.valueOf(command);
    DirectionEnum nextCommandEnum = DirectionEnum.valueOf(nextCommand);

    if (commandEnum == MovementEnum.ROTATE) {
      this.rotate(nextCommandEnum);
      programCounter++;
    } else if (commandEnum == MovementEnum.MOVE) {
      this.rotate(nextCommandEnum);
      int[] newCellCords = getFrontCell();
      int newX = newCellCords[0];
      int newY = newCellCords[1];

      Cell cellInNewPos = grid.cells[newY][newX].cell;
      if (cellInNewPos == null) {
        grid.cells[y][x].cell = null;
        grid.cells[newY][newX].cell = this;
        x = newX;
        y = newY;
        programCounter += MoveOffsetEnum.EMPTY.getValue();
      } else if (cellInNewPos.organizmId == organizmId) {
        programCounter += MoveOffsetEnum.SIBLING.getValue();
      } else {
        programCounter += MoveOffsetEnum.ENEMY.getValue();
      }
    } else if (commandEnum == MovementEnum.EAT) {
      this.rotate(nextCommandEnum);
      int[] newCellCords = getFrontCell();
      int newX = newCellCords[0];
      int newY = newCellCords[1];

      Cell cellInNewPos = grid.cells[newY][newX].cell;

      if (cellInNewPos == null) {
        programCounter += EatOffsetEnum.EMPTY.getValue();
        float gainedEnergy = min(grid.cells[newY][newX].organicLevel, OffshootConfig.maxEatableOrganic);
        energy += gainedEnergy;
        grid.cells[newY][newX].organicLevel -= gainedEnergy;
      } else {
        programCounter += EatOffsetEnum.EATABLE_CELL.getValue();
        energy += cellInNewPos.energy;
        cellInNewPos.kill();
        grid.cells[newY][newX].cell = null;
      }
    } else {
      programCounter += command;
    }
  }

  public void transform() {
    Wood wood = new Wood(sectorId, x, y, organizmId, angle, parent);

    wood.cells[0] = generateChild(dna.reproduction[0], DirectionEnum.RIGHT);
    wood.cells[1] = generateChild(dna.reproduction[1], DirectionEnum.BACK);
    wood.cells[2] = generateChild(dna.reproduction[2], DirectionEnum.LEFT);
    wood.cells[3] = generateChild(dna.reproduction[3], DirectionEnum.FORWARD);

    boolean hasChild = false;
    for (Cell cell : wood.cells) {
      if (cell != null) {
        cell.parent = wood;
        addedCells.add(cell);
        grid.cells[y][x].cell = cell;
        hasChild = true;
      }
    }
    
    if (hasChild) {
      grid.cells[y][x].cell = wood;
      addedCells.add(wood);
    }

    alive = false;
  }

  public void _live() {
    if (!alive || parent != null) return;
    energy -= OffshootConfig.consumePerFrame;

    if (energy < 0) {
      kill();
      return;
    }

    if (energy >= OffshootConfig.energyToTransform)
      transform();

    if (parent != null) return;

    move();
  }

  public void _draw() {
    rectMode(CENTER);
    fill(0);
    rect(0, 0, OffshootConfig.size, OffshootConfig.size);
  }

  public void rotate(DirectionEnum direction) {
    angle = rotateTo(angle, direction);
  }

  private int[] getFrontCell() {
    return getFrontCellByCoords(x, y, angle);
  }

  private Cell generateChild(byte gen, DirectionEnum direction) {
    float a = rotateTo(angle, direction);
    int[] coords = getFrontCellByCoords(x, y, a);
    int newX = coords[0];
    int newY = coords[1];

    if (grid.cells[newY][newX].cell != null) return null;

    CellTypeEnum cellType = CellTypeEnum.valueOf(gen);

    if (cellType == null) return null;

    switch(cellType) {
    case OFFSHOOT:
      return new Offshoot(sectorId, newX, newY, organizmId, dna, a, null);
    case LEAF:
      return null;
    case ROOT:
      return null;
    case ANTENNA:
      return null;
    case SEED:
      return null;
    default:
      return null;
    }
  }
}


enum CellTypeEnum {
  OFFSHOOT(0), LEAF(1), ROOT(2), ANTENNA(3), SEED(4);

  private final int value;

  CellTypeEnum(int value) {
    this.value = value;
  }

  public static CellTypeEnum valueOf(int value) {
    if (value > 15) return null;

    switch(value % 5) {
    case 0:
      return OFFSHOOT;
    case 1:
      return LEAF;
    case 2:
      return ROOT;
    case 3:
      return ANTENNA;
    case 4:
      return SEED;
    default :
      return null;
    }
  }
}
