import java.util.UUID;

abstract public class Cell {
    public int sectorId, x, y;
    public UUID organizmId;
    public boolean alive = true;
    public float energy;
    public float organicAfterDeath;
    
    public Cell(int sectorId, int x, int y, UUID organizmId, float organicAfterDeath) {
        this.sectorId = sectorId;
        this.x = x;
        this.y = y;
        this.organizmId = organizmId;
        this.organicAfterDeath = organicAfterDeath;
    }
    
    abstract public void _draw();
    public void draw() {
        translate(x * GridCellConfig.size + offsetX + GridCellConfig.size / 2, y * GridCellConfig.size + offsetY + GridCellConfig.size / 2);
        _draw();
    }
    abstract public void live();
    
    public boolean isAlive() {
        return alive;
    }
    
    public void kill() {
        grid.cells[y][x].cell = null;
        float totalEnergy = organicAfterDeath;
        
        ArrayList<GridCell> neighbors = new ArrayList<GridCell>();
        
        for (int i = -1; i <= 1; ++i) {
            for (int j = -1; j <= 1; ++j) {
                int newY = y + i;
                int newX  = x + j;
                int[] wrappedCoords = Utils.wrapCoords(newX, newY, rows, cols);
                newX = wrappedCoords[0];
                newY = wrappedCoords[1];
                neighbors.add(grid.cells[newY][newX]);
                
                totalEnergy += grid.cells[newY][newX].organicLevel;
            }
        }
        
        float organicPerCell = totalEnergy / 9.0;
        
        neighbors.forEach(neighbor -> {
            neighbor.organicLevel = organicPerCell;
        });
        
        alive = false;
    }
}
