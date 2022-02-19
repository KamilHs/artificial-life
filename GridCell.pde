public class GridCell {
    public int x, y;
    public Cell cell = null;
    
    public GridCell(int x, int y, int sectorId) {
        this.x = x;
        this.y = y;
        this.cell = random(1) < 0.7 ? new Offshoot(sectorId) : null;
    }
    
    void draw() {
        push();
        fill(240);
        stroke(255);
        rect(x * cellSize + offsetX, y * cellSize + offsetY, cellSize, cellSize);
        pop();
    }
}
