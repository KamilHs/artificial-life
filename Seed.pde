public class Seed extends Offshoot {
  public boolean isMoving = false;
  public byte distance = 0;
  public Seed(int sectorId, int x, int y, UUID organizmId, DNA dna, float angle, Wood parent) {
    super(sectorId, x, y, organizmId, 0, angle, SeedConfig.organicAfterDeath, SeedConfig.chargeAfterDeath, dna, parent);
  }

  public void _draw() {
    rectMode(CENTER);
    fill(125, 225, 220);
    rect(0, 0, OffshootConfig.size, OffshootConfig.size);
  }

  private void move() {
    distance = dna.seedThrowDistance;
    isMoving = true;
  }

  private void transform() {
    Offshoot offshoot = new Offshoot(sectorId, x, y, UUID.randomUUID(), new DNA(dna, dna.activeReproductionGen), angle, null);

    grid.cells[y][x].cell = offshoot;
    addedCells.add(offshoot);
    alive = false;
  }

  private void handleParentDeath() {
    parent = null;
    if (getEnergy() < OffshootConfig.energyToTransform) {
      kill();
      return;
    }

    organizmEnergies.remove(organizmId);
    if (random(1) < dna.seedThrowProbability)
      move();
    else
      transform();
  }

  public void _live() {
    if (parent != null && !parent.isAlive()) {
      handleParentDeath();
    }
    if (grid.cells[y][x].isOrganicallyPoisoned() || grid.cells[y][x].isTooCharged()) {
      kill();
      return;
    }
    if (isMoving) {
      if (distance > 0) {
        int[] newCellCords = getFrontCell();
        int newX = newCellCords[0];
        int newY = newCellCords[1];

        Cell cellInNewPos = grid.cells[newY][newX].cell;

        if (cellInNewPos != null) {
          cellInNewPos.kill();
          kill();
        } else {
          grid.cells[y][x].cell = null;
          grid.cells[newY][newX].cell = this;
          distance--;

          x = newX;
          y = newY;
        }
      } else{
        transform();
      }
    }
  }
}
