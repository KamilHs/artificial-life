public class Offshoot extends Cell {
    public float angle;
    public int programCounter = 0;
    public DNA dna;
    
    public Offshoot(int sectorId, int x, int y) {
        this(sectorId, x, y, UUID.randomUUID(), new DNA(), 0.0);
    }
    
    public Offshoot(int sectorId, int x, int y, UUID organizmId, DNA dna, float angle) {
        super(sectorId, x, y, organizmId);
        this.dna = dna;
        this.angle = angle;
    }
    
    public void live() {
        if (!alive) return;
        
        programCounter = programCounter % DNAConfig.movementSize;
        byte command = dna.movementDna[programCounter];
        byte nextCommandCounter = byte((programCounter + 1) % DNAConfig.movementSize);
        byte nextCommand = dna.movementDna[nextCommandCounter];
        MovementEnum commandEnum = MovementEnum.valueOf(command);
        DirectionEnum nextCommandEnum = DirectionEnum.valueOf(nextCommand);
        
        if (commandEnum == MovementEnum.ROTATE) {
            this.rotate(nextCommandEnum);
            programCounter++;
        }
        else if (commandEnum == MovementEnum.MOVE) {
            this.rotate(nextCommandEnum);
            int[] newCellCords = getFrontCell();
            int newX = newCellCords[0];
            int newY = newCellCords[1];
            
            Cell cellInNewPos = grid.cells[newY][newX].cell;
            if (cellInNewPos == null) {
                grid.cells[y][x].cell = null;
                grid.cells[newY][newX].cell = this;
                x = newX;
                y = newY;
                programCounter += MoveOffsetEnum.EMPTY.getValue();  
            } else if (cellInNewPos.organizmId == organizmId) {
                programCounter += MoveOffsetEnum.SIBLING.getValue();  
            } else{
                programCounter += MoveOffsetEnum.ENEMY.getValue();  
            }            
        }
        else if (commandEnum == MovementEnum.EAT) {
            this.rotate(nextCommandEnum);
            int[] newCellCords = getFrontCell();
            int newX = newCellCords[0];
            int newY = newCellCords[1];
            
            Cell cellInNewPos = grid.cells[newY][newX].cell;
            
            if (cellInNewPos == null) {
                programCounter += EatOffsetEnum.EMPTY.getValue();  
            }
            else {
                programCounter += EatOffsetEnum.EATABLE_CELL.getValue();
                cellInNewPos.kill();
                grid.cells[newY][newX].cell = null;
            }
        }
        else {
            programCounter += command;
        }
        
    }
    
    public void _draw() {
        if (alive)
            fill(0);
        else
            fill(255,0,0);
        rectMode(CENTER);
        rect(0, 0, OffshootConfig.size, OffshootConfig.size);
    }
    
    public void rotate(DirectionEnum direction) {
        switch(direction) {
            case LEFT:
                angle -= HALF_PI;
                break;
            case RIGHT:
                angle += HALF_PI;
                break;
            case FORWARD:
                break;
            case BACK:
                angle += PI;
                break;
            default :  
            break;
        }
        
        angle = angle % TWO_PI;
    }
    
    private int[] getFrontCell() {
        int newX = x + int(cos(angle));
        int newY = y + int(sin(angle));
        if (newX < 0)
            newX = rows - 1;
        else if (newX >= rows)
            newX = 0;
        if (newY < 0)
            newY = cols - 1;
        else if (newY >= cols)
            newY = 0;
        
        return new int[]{newX, newY};
    }
}
