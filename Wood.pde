public class Wood extends Cell {
    public float angle;
    public Cell left = null, forward = null, right = null, back = null;
    
    public Wood(int sectorId, int x, int y, UUID organizmId, float angle) {
        super(sectorId, x, y, organizmId, WoodConfig.organicAfterDeath, WoodConfig.initialEnergy);
        this.angle = angle;
    }
    
    public void _draw() {
        fill(255,0 ,0);
        
        if (left != null) {
            float a = rotateTo(angle, DirectionEnum.left);
        }
        
        rect(0, 0, WoodConfig.size, WoodConfig.size);
    }
    
    public void live() {
    }
}
