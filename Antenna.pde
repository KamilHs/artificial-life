public class Antenna extends Cell {
  public Antenna(int sectorId, int x, int y, UUID organizmId, float angle, Wood parent) {
    super(sectorId, x, y, organizmId, AntennaConfig.initialEnergy, angle, AntennaConfig.organicAfterDeath, parent);
  }

  public void _draw(){
    rectMode(CENTER);
    fill(0, 0, 200);
    rect(0, 0, AntennaConfig.size, AntennaConfig.size);
  }

  public void _live(){
    if(!alive || parent == null) return;
    if(!parent.isAlive()){
      kill();
      return;
    }

    float gainedEnergy = min(grid.cells[y][x].chargeLevel, AntennaConfig.generatePerFrame);
    grid.cells[y][x].chargeLevel -= gainedEnergy;
    parent.storage.addEnergy(gainedEnergy);
  }
}
