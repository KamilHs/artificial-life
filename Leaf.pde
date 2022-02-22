public class Leaf extends Cell {
  public Leaf(int sectorId, int x, int y, UUID organizmId, float angle, Cell parent) {
    super(sectorId, x, y, organizmId, RootConfig.initialEnergy, angle, RootConfig.organicAfterDeath, parent);
  }

  public void _draw(){
    rectMode(CENTER);
    fill(0, 200, 0);
    rotate(QUARTER_PI);
    rect(0, 0, LeafConfig.size, LeafConfig.size);
  }

  public void _live(){
    if(!alive) return;
    if(parent != null && !parent.isAlive()){
      kill();
      return;
    }
  }
}
