public class Wood extends Cell {
    public float angle;
    public Cell[] cells = new Cell[4];
    
    public Wood(int sectorId, int x, int y, UUID organizmId, float angle) {
        super(sectorId, x, y, organizmId, WoodConfig.organicAfterDeath, WoodConfig.initialEnergy);
        this.angle = angle;
    }
    
    public void _draw() {
        fill(0, 255, 0);
        
        rectMode(CENTER);
        rect(0, 0, WoodConfig.size + 4, WoodConfig.size + 4);
        stroke(255, 0, 0);
        strokeWeight(WoodConfig.size);

        for (Cell cell : cells) {
            if (cell != null) {
                line(0, 0, (cell.x - x) * GridCellConfig.size, (cell.y - y) * GridCellConfig.size);
            }
        }
    }
    
    public void live() {
    }
}
