public class DNA {
    public byte[] movementDna;
    public byte[] reproductionDna;
    
    public DNA() {
        movementDna = new byte[DNAConfig.movementSize];
        reproductionDna = new byte[DNAConfig.reproductionSize];

        for (int i = 0; i < DNAConfig.movementSize; ++i) {
            movementDna[i] = byte(random(64));
            reproductionDna[i] = byte(random(64));
        }

        // movementDna[0] = 15;
        // movementDna[1] = 2;
        // println(movementDna);
    }
    
    public DNA(byte[] movementDna, byte[] reproductionDna) {
        this.movementDna = movementDna;
        this.reproductionDna = reproductionDna;
    }
}