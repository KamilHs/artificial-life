public class GridCell {
    public int x, y;
    public Cell cell = null;
    
    public GridCell(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    void draw() {
        fill((x + y) % 2 == 0 ? 255 : 240);
        rect(x * cellSize + offsetX,  y * cellSize + offsetY, cellSize, cellSize);
    }
}
