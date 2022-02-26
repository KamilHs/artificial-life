public class Root extends Cell {
  public Root(int sectorId, int x, int y, UUID organizmId, float angle, Wood parent) {
    super(sectorId, x, y, organizmId, 0, angle, RootConfig.organicAfterDeath, RootConfig.chargeAfterDeath, parent);
  }

  public void _draw(){
    rectMode(CENTER);
    fill(255, 128, 0);
    rect(0, 0, RootConfig.size, RootConfig.size);
  }

  public void _live(){
    if(parent == null || !parent.isAlive() || grid.cells[y][x].isTooCharged()){
      kill();
      return;
    }

    float gainedEnergy = min(grid.cells[y][x].organicLevel, RootConfig.generatePerFrame);
    grid.cells[y][x].organicLevel -= gainedEnergy;
    addEnergy(gainedEnergy);
  }
}
