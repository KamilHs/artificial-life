public class Leaf extends Cell {
  public Leaf(int sectorId, int x, int y, UUID organizmId, float angle, Wood parent) {
    super(sectorId, x, y, organizmId, 0, angle, LeafConfig.organicAfterDeath, LeafConfig.chargeAfterDeath, parent);
  }

  public void _draw(){
    rectMode(CENTER);
    fill(0, 200, 0);
    rotate(QUARTER_PI);
    rect(0, 0, LeafConfig.size, LeafConfig.size);
  }

  public void _live(){
    if(parent == null || !parent.isAlive() || grid.cells[y][x].isOrganicallyPoisoned() || grid.cells[y][x].isTooCharged()){
      kill();
      return;
    }

    if(grid.cells[y][x].hasSun())
      addEnergy(LeafConfig.generatePerFrame(SunConfig.current));
  }
}
