public class Wood extends Cell {
    public float angle;
    public Cell left = null, forward = null, right = null, back = null;
    
    public Wood(int sectorId, int x, int y, UUID organizmId, float angle) {
        super(sectorId, x, y, organizmId, WoodConfig.organicAfterDeath, WoodConfig.initialEnergy);
        this.angle = angle;
    }
    
    public void _draw() {
        fill(0, 255,0 );
        
        float a = angle;
        int[] coords;
        rectMode(CENTER);
        rect(0, 0, WoodConfig.size + 4, WoodConfig.size + 4);
        stroke(255, 0, 0);
        strokeWeight(WoodConfig.size);
        if (left != null) {
            line(0, 0, (left.x - x) * GridCellConfig.size, (left.y - y) * GridCellConfig.size);
        }
        if (right != null) {
            line(0, 0, (right.x - x) * GridCellConfig.size, (right.y - y) * GridCellConfig.size);
        }
        if (back != null) {
            line(0, 0, (back.x - x) * GridCellConfig.size, (back.y - y) * GridCellConfig.size);
        }
        if (forward != null) {
            line(0, 0, (forward.x - x) * GridCellConfig.size, (forward.y - y) * GridCellConfig.size);
        }
        
    }
    
    public void live() {
    }
}
