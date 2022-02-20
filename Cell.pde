import java.util.UUID;

abstract public class Cell {
    public int sectorId, x, y;
    public UUID organizmId;
    public boolean alive = true;
    
    public Cell(int sectorId, int x, int y, UUID organizmId) {
        this.sectorId = sectorId;
        this.x = x;
        this.y = y;
        this.organizmId = organizmId;
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
        alive = false;
    }
}
