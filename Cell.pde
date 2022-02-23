import java.util.UUID;

abstract public class Cell {
    public int sectorId, x, y;
    public UUID organizmId;
    public boolean alive = true;
    public float energy;
    public float angle;
    public float organicAfterDeath;
    public Wood parent = null;
    
    public Cell(int sectorId, int x, int y, UUID organizmId, float energy, float angle, float organicAfterDeath, Wood parent) {
        this.sectorId = sectorId;
        this.x = x;
        this.y = y;
        this.organizmId = organizmId;
        this.energy = energy;
        this.angle = angle;
        this.organicAfterDeath = organicAfterDeath;
        this.parent = parent;
    }
    
    abstract public void _draw();
    abstract public void _live();
    public void draw() {
        if (!alive) return;
        
        translate(x * GridCellConfig.size + offsetX + GridCellConfig.size / 2, y * GridCellConfig.size + offsetY + GridCellConfig.size / 2);
        if (ViewModeConfig.mode == ViewModeEnum.SECTORS) {
            int[] c = SectorsConfig.colors[sectorId];
            fill(c[0], c[1], c[2]);
            rectMode(CENTER);
            rect(0, 0, GridCellConfig.size, GridCellConfig.size);
            fill(255);
            textSize(GridCellConfig.size);
            text(sectorId + 1, 0, 0);
        }else {
            if (parent != null) {
                push();
                stroke(128, 0, 0);
                strokeWeight(WoodConfig.size);
                boolean isOnTheEdge = abs(parent.x - x) + abs(parent.y - y) > 1;
                
                if (!isOnTheEdge) {
                    line(0, 0,(parent.x - x) * GridCellConfig.size / 2,(parent.y - y) * GridCellConfig.size / 2);
                } else if (x < parent.x) {
                    line(0, 0, -GridCellConfig.size / 2, 0);
                } else if (x > parent.x) {
                    line(0, 0, GridCellConfig.size / 2, 0);
                } else if (y < parent.y) {
                    line(0, 0,0, -GridCellConfig.size / 2);
                } else {
                    line(0, 0,0, GridCellConfig.size / 2);
                }
                pop();
            }
            _draw();
        }
    }
    public void live() {
        _live();
    }
    
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

        grid.cells[y][x].chargeLevel += min(energy, GridCellConfig.maxChargeAfterDeath);
        
        alive = false;
    }
}
