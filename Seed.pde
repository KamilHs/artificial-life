public class Seed extends Offshoot {
  public Seed(int sectorId, int x, int y, UUID organizmId, DNA dna, float angle, Wood parent) {
    super(sectorId, x, y, organizmId, 0, angle, SeedConfig.organicAfterDeath, SeedConfig.chargeAfterDeath, dna, parent);
  }

  public void _draw(){
    rectMode(CENTER);
    fill(125, 225, 220);
    rect(0, 0, OffshootConfig.size, OffshootConfig.size);
  }

  public void _live(){
    if(parent != null && !parent.isAlive())
      parent = null;
    if(grid.cells[y][x].isOrganicallyPoisoned() || grid.cells[y][x].isTooCharged()){
      kill();
      return;
    }
  }
}
