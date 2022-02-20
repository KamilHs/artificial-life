int rows, cols;
int offsetX = 0;
int offsetY = 0;
float zoom = 1.0;
int nbClansPerRow = 4;
int nbClansPerColumn = 2;
int clanRows;
int clanCols;
float translateX = 0.0;
float translateY = 0.0;
Grid grid;
ArrayList<Cell> cells = new ArrayList<Cell>();

void setup() {
    fullScreen();
    int h = displayHeight - 40;
    
    rows = displayWidth / GridCellConfig.size;
    rows = rows - rows % nbClansPerRow;
    cols = h / GridCellConfig.size;
    cols = cols - cols % nbClansPerColumn;
    clanRows = rows / nbClansPerRow;
    clanCols = cols / nbClansPerColumn;
    offsetX = (displayWidth - rows * GridCellConfig.size) / 2;
    offsetY = (h - cols * GridCellConfig.size) / 2;
    OffshootConfig.size = GridCellConfig.size / 2;
    grid = new Grid();
    
    for (int i = 0; i < cols; ++i) {
        for (int j = 0; j < rows; ++j) {
            if (random(1) < Offshoot.probToAppear) {
                Cell cell = new Offshoot(floor(j / clanRows) + floor(i / clanCols) * nbClansPerRow, j, i);
                cells.add(cell);
                grid.cells[i][j].cell = cell;
            }
        }
    }
    
    noStroke();
}

void draw() {
    background(100);
    pushMatrix();
    translate(translateX, translateY);
    scale(zoom);
    grid.draw();
    cells.forEach(cell -> {
        push();
        cell.draw();
        cell.live();
        pop();
    });
    popMatrix();
    
    textSize(64); 
    fill(0);
    text(int(frameRate), displayWidth - 100, 64);
    
    // cells.removeIf(cell -> !cell.isAlive());
}


void mouseWheel(MouseEvent e) {
    float count = e.getCount();
    float delta = count < 0 ? 1.15 : count > 0 ? 1.0 / 1.15 : 1.0;
    zoom *= delta;
    translateX = (delta * translateX) + mouseX * (1 - delta);
    translateY = (delta * translateY) + mouseY * (1 - delta);
}

void mouseDragged(MouseEvent e) {
    translateX += mouseX - pmouseX;
    translateY += mouseY - pmouseY;
}

void keyPressed()
{
    if (key == 'r' || key == 'R') {
        zoom = 1;
        translateX = 0;
        translateY = 0;
    }
}
