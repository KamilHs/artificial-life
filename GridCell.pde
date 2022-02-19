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
        rectMode(CENTER);
        translate(x * cellSize + offsetX + cellSize / 2, y * cellSize + offsetY + cellSize / 2);
        fill((x + y) % 2 == 0 ? 255: 240);
        rect(0, 0, cellSize, cellSize);
        if (cell != null) {
            cell.draw();
        }
        pop();
    }
}
