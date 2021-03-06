public class Offshoot extends Cell {
  public int programCounter = 0;
  public DNA dna;

  public Offshoot(int sectorId, int x, int y) {
    this(sectorId, x, y, UUID.randomUUID(), new DNA(), 0.0, null);
  }

  public Offshoot(int sectorId, int x, int y, UUID organizmId, DNA dna, float angle, Wood parent) {
    this(sectorId, x, y, organizmId, OffshootConfig.initialEnergy, angle, OffshootConfig.organicAfterDeath, OffshootConfig.chargeAfterDeath, dna, parent);
  }

  public Offshoot(int sectorId, int x, int y, UUID organizmId, float initialEnergy, float angle, float organicAfterDeath, float chargeAfterDeath, DNA dna, Wood parent) {
    super(sectorId, x, y, organizmId, initialEnergy, angle, organicAfterDeath, chargeAfterDeath, parent);
    this.dna = dna;
    if (organizmEnergies.get(organizmId) == null) {
      organizmEnergies.put(organizmId, 0.0);
    }
  }

  public void update() {
    byte command = dna.movement[programCounter];
    byte nextCommandCounter = byte((programCounter + 1) % DNAConfig.movementSize);
    byte nextCommand = dna.movement[nextCommandCounter];
    MovementEnum commandEnum = MovementEnum.valueOf(command);
    DirectionEnum nextCommandEnum = DirectionEnum.valueOf(nextCommand);

    if (commandEnum == MovementEnum.ROTATE && parent == null) {
      this.rotate(nextCommandEnum);
      programCounter++;
    } else if (commandEnum == MovementEnum.MOVE && parent == null) {
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

        if (parent == null) {
          float gainedEnergy = min(grid.cells[newY][newX].organicLevel, OffshootConfig.maxEatableOrganic);
          energy += gainedEnergy;
          grid.cells[newY][newX].organicLevel -= gainedEnergy;
        }
      } else if (cellInNewPos instanceof Wood || cellInNewPos instanceof Root) {
        programCounter += EatOffsetEnum.NOT_EATABLE_CELL.getValue();
      } else {
        programCounter += EatOffsetEnum.EATABLE_CELL.getValue();
        if (parent == null)
          energy += OffshootConfig.maxEatableOrganic;
        else
          addEnergy(OffshootConfig.maxEatableOrganic);
        cellInNewPos.kill();
      }
    } else {
      programCounter += command;
    }

    programCounter = programCounter % DNAConfig.movementSize;
  }

  private void transform() {
    if (parent != null) {
      useEnergy(OffshootConfig.energyToTransform);
    }
    Wood wood = new Wood(sectorId, x, y, organizmId, angle, parent);
    byte genOffset = byte(dna.activeReproductionGen * 4);

    wood.cells[0] = generateChild(dna.reproduction[genOffset], DirectionEnum.RIGHT);
    wood.cells[1] = generateChild(dna.reproduction[genOffset + 1], DirectionEnum.BACK);
    wood.cells[2] = generateChild(dna.reproduction[genOffset + 2], DirectionEnum.LEFT);
    wood.cells[3] = generateChild(dna.reproduction[genOffset + 3], DirectionEnum.FORWARD);

    if (Arrays.asList(wood.cells).stream().filter(cell -> cell != null).count() > 0) {
      if (parent != null) {
        parent.replaceChild(this, wood);
      }
      grid.cells[y][x].cell = wood;
      addedCells.add(wood);
    }

    for (Cell cell : wood.cells) {
      if (cell != null) {
        cell.parent = wood;
        addedCells.add(cell);
        grid.cells[cell.y][cell.x].cell = cell;
      }
    }
    alive = false;
  }

  public void _live() {
    if (parent == null) {
      energy -= OffshootConfig.consumePerFrame;
    }

    if (energy < 0 || grid.cells[y][x].isOrganicallyPoisoned() || grid.cells[y][x].isTooCharged() || parent != null && !parent.isAlive()) {
      kill();
      return;
    }

    if (energy >= OffshootConfig.energyToTransform || parent != null && getEnergy() >= OffshootConfig.energyToTransform)
      transform();

    update();
  }

  public void _draw() {
    rectMode(CENTER);
    fill(0);
    rect(0, 0, OffshootConfig.size, OffshootConfig.size);
  }

  public void rotate(DirectionEnum direction) {
    angle = rotateTo(angle, direction);
  }

  protected int[] getFrontCell() {
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
      return random(1) < dna.seedProbability ?
        new Seed(sectorId, newX, newY, organizmId, new DNA(dna, gen), a, null) :
        new Offshoot(sectorId, newX, newY, organizmId, new DNA(dna, gen), a, null);
    case LEAF:
      return new Leaf(sectorId, newX, newY, organizmId, a, null);
    case ROOT:
      return new Root(sectorId, newX, newY, organizmId, a, null);
    case ANTENNA:
      return new Antenna(sectorId, newX, newY, organizmId, a, null);
    default:
      return null;
    }
  }
}


enum CellTypeEnum {
  OFFSHOOT(0), LEAF(1), ROOT(2), ANTENNA(3);

  private final int value;

  CellTypeEnum(int value) {
    this.value = value;
  }

  public static CellTypeEnum valueOf(int value) {
    if (value > 4) return null;

    switch(value % 4) {
    case 0:
      return OFFSHOOT;
    case 1:
      return LEAF;
    case 2:
      return ROOT;
    case 3:
      return ANTENNA;
    default :
      return null;
    }
  }
}
