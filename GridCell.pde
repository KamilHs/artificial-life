public class GridCell {
    public int x, y;
    
    public GridCell(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    void draw() {
        push();
        fill(240);
        strokeWeight(1);
        stroke(255);
        rect(x * cellSize + offsetX, y * cellSize + offsetY, cellSize, cellSize);
        pop();
    }
}
