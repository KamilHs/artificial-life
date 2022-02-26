public class Seed extends Offshoot {
  public Seed(int sectorId, int x, int y, UUID organizmId, DNA dna, float angle, Wood parent) {
    super(sectorId, x, y, organizmId, 0, angle, SeedConfig.organicAfterDeath, SeedConfig.chargeAfterDeath, dna, parent);
  }

  public void _draw(){
    rectMode(CENTER);
    fill(125, 225, 220);
    rect(0, 0, OffshootConfig.size, OffshootConfig.size);
  }

  private void move(){

  }

  private void transform(){
    
  }

  private void handleParentDeath(){
    parent = null;
    if(getEnergy() < OffshootConfig.energyToTransform){
      kill();
      return;
    }

    organizmEnergies.remove(organizmId);
    byte command = dna.movement[0];
    byte nextCommand = dna.movement[1];
    MovementEnum commandEnum = MovementEnum.valueOf(command);

    if(commandEnum == MovementEnum.MOVE){

    }
    else {
      Offshoot offshoot = new Offshoot(sectorId, x, y, UUID.randomUUID(), new DNA(dna, dna.activeReproductionGen), angle, null);

      grid.cells[y][x].cell = offshoot;
      addedCells.add(offshoot);
      alive = false;
    }

  }

  public void _live(){
    if(parent != null && !parent.isAlive()){
      handleParentDeath();
    }
    if(grid.cells[y][x].isOrganicallyPoisoned() || grid.cells[y][x].isTooCharged()){
      kill();
      return;
    }
  }
}
