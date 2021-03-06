public class DNA {
  public byte[] movement;
  public byte[] reproduction;
  public byte activeReproductionGen;
  public float seedProbability;
  public float seedThrowProbability;
  public byte seedThrowDistance;

  public DNA() {
    movement = new byte[DNAConfig.movementSize];
    reproduction = new byte[DNAConfig.reproductionSize];
    seedProbability = random(1) / 10;
    seedThrowProbability = random(1);
    seedThrowDistance = byte(random(DNAConfig.movementSize));
    activeReproductionGen = 0;
    for (int i = 0; i < DNAConfig.movementSize; ++i) {
      movement[i] = byte(random(DNAConfig.movementSize));
    }
    for (int i = 0; i < DNAConfig.reproductionSize; ++i) {
      reproduction[i] = byte(random(10));
    }
  }

  public DNA(DNA dna, byte activeReproductionGen) {
    movement = dna.movement.clone();
    reproduction = dna.reproduction.clone();
    this.activeReproductionGen = activeReproductionGen;
    this.seedProbability = dna.seedProbability;
    this.seedThrowProbability = dna.seedThrowProbability;
    this.seedThrowDistance = dna.seedThrowDistance;

    mutate();
  }

  public void mutate() {
    for (int i = 0; i < DNAConfig.movementSize; ++i) {
      if (random(1)  < DNAConfig.mutationRate) {
        movement[i] = byte(random(DNAConfig.movementSize));
        break;
      }
    }
    for (int i = 0; i < DNAConfig.reproductionSize; ++i) {
      if (random(1)  < DNAConfig.mutationRate) {
        reproduction[i] = byte(random(10));
        break;
      }
    }

    if(random(1) < DNAConfig.mutationRate)
      seedProbability = random(1) / 10;
    if(random(1) < DNAConfig.mutationRate)
      seedThrowProbability = random(1);
    if(random(1) < DNAConfig.mutationRate)
      seedThrowDistance = byte(random(DNAConfig.movementSize));
  }
}
