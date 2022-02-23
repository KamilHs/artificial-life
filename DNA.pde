public class DNA {
  public byte[] movement;
  public byte[] reproduction;
  public byte activeReproductionGen;

  public DNA() {
    movement = new byte[DNAConfig.movementSize];
    reproduction = new byte[DNAConfig.reproductionSize];
    activeReproductionGen = 0;

    for (int i = 0; i < DNAConfig.movementSize; ++i) {
      movement[i] = byte(random(DNAConfig.movementSize));
    }
    for (int i = 0; i < DNAConfig.reproductionSize; ++i) {
      reproduction[i] = byte(random(DNAConfig.reproductionSize));
    }
  }

  public DNA(DNA dna, byte activeReproductionGen) {
    movement = dna.movement.clone();
    reproduction = dna.reproduction.clone(); 
    this.activeReproductionGen = activeReproductionGen;
    mutate();
  }

  public void mutate(){
    for (int i = 0; i < DNAConfig.movementSize; ++i) {
      movement[i] = random(1) < DNAConfig.mutationRate ? byte(random(DNAConfig.movementSize)): movement[i];
    }
    for (int i = 0; i < DNAConfig.reproductionSize; ++i) {
      reproduction[i] = random(1) < DNAConfig.mutationRate ? byte(random(DNAConfig.movementSize)) : reproduction[i];
    }
  }
}
