int cellSize = 8;
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

void setup() {
    fullScreen();
    int h = displayHeight - 40;
    
    rows = displayWidth / cellSize;
    rows = rows - rows % nbClansPerRow;
    cols = h / cellSize;
    cols = cols - cols % nbClansPerColumn;
    clanRows = rows / nbClansPerRow;
    clanCols = cols / nbClansPerColumn;
    offsetX = (displayWidth - rows * cellSize) / 2;
    offsetY = (h - cols * cellSize) / 2;
    grid = new Grid();
    frameRate(2000);
    noStroke();
}

void draw() {
    background(100);
    pushMatrix();
    translate(translateX, translateY);
    scale(zoom);
    grid.draw();
    popMatrix();
    
    textSize(64); 
    fill(0);
    text(int(frameRate), displayWidth - 100, 64);
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
