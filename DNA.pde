public class DNA {
  public byte[] movement;
  public byte[] reproduction;

  public DNA() {
    movement = new byte[DNAConfig.movementSize];
    reproduction = new byte[DNAConfig.reproductionSize];

    for (int i = 0; i < DNAConfig.movementSize; ++i) {
      movement[i] = byte(random(DNAConfig.movementSize));
    }
    for (int i = 0; i < DNAConfig.reproductionSize; ++i) {
      reproduction[i] = byte(random(DNAConfig.reproductionSize));
    }
  }

  public DNA(byte[] movement, byte[] reproduction) {
    this.movement = movement;
    this.reproduction = reproduction;
  }
}
