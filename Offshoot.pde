public class Offshoot extends Cell {
    public byte[] movementDna;
    public byte[] reproductionDna;
    public float angle;
    
    public Offshoot(int sectorId) {
        this(sectorId, new byte[64], new byte[64], 0.0);
    }
    
    public Offshoot(int sectorId,byte[] movementDna, byte[] reproductionDna, float angle) {
        super(sectorId);
        this.movementDna = movementDna;
        this.reproductionDna = reproductionDna;
        this.angle = angle;
    }
}
