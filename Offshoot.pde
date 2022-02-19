public class Offshoot extends Cell {
    public byte[] movementDna;
    public byte[] reproductionDna;
    public float angle;
    public int programCounter = 0;
    
    public Offshoot(int sectorId) {
        this(sectorId, new byte[64], new byte[64], 0.0);
    }
    
    public Offshoot(int sectorId, byte[] movementDna, byte[] reproductionDna, float angle) {
        super(sectorId);
        this.movementDna = movementDna;
        this.reproductionDna = reproductionDna;
        this.angle = angle;
    }
    
    public void live() {
        //byte command = movementDna[programCounter];
    }
    
    public void draw() {
        fill(0);
        rect(0, 0, cellSize / 2, cellSize / 2);
    }
}
