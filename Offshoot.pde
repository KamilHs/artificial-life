public class Offshoot extends Cell {
  public float angle;
  public int programCounter = 0;
  public DNA dna;
  public boolean attached;

  public Offshoot(int sectorId, int x, int y) {
    this(sectorId, x, y, UUID.randomUUID(), new DNA(), 0.0, false);
  }

  public Offshoot(int sectorId, int x, int y, UUID organizmId, DNA dna, float angle, boolean attached) {
    super(sectorId, x, y, organizmId, OffshootConfig.initialEnergy, OffshootConfig.organicAfterDeath);
    this.dna = dna;
    this.angle = angle;
    this.attached = attached;
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
    Wood wood = new Wood(sectorId, x, y, organizmId, angle);

    grid.cells[y][x].cell = wood;

    int newY = y - 1 < 0 ? cols - 1: y- 1;
    wood.left = generateChild(dna.reproduction[0], DirectionEnum.LEFT);
    wood.forward = generateChild(dna.reproduction[1], DirectionEnum.FORWARD);
    wood.right = generateChild(dna.reproduction[2], DirectionEnum.RIGHT);
    wood.back = generateChild(dna.reproduction[3], DirectionEnum.BACK);

    if (wood.left != null)
      addedCells.add(wood.left);
    if (wood.forward != null)
      addedCells.add(wood.forward);
    if (wood.right != null)
      addedCells.add(wood.right);
    if (wood.back != null)
      addedCells.add(wood.back);

    if(wood.left != null || wood.right != null || wood.forward != null || wood.back != null)
      addedCells.add(wood);
    alive = false;
  }

  public void live() {
    if (!alive) return;
    energy -= OffshootConfig.consumePerFrame;

    if (energy < 0) {
      kill();
      return;
    }

    if (energy >= OffshootConfig.energyToTransform)
      transform();

    if (attached) return;

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

    if(cellType == null) return null;

    switch(cellType) {
    case OFFSHOOT:
      return new Offshoot(sectorId, newX, newY, organizmId, dna, a, true);
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
