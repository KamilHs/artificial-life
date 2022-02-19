int cellSize = 40;
int rows, cols;
int offsetX = 0;
int offsetY = 0;
float zoom = 1.0;
float translateX = 0.0;
float translateY = 0.0;
Grid grid;

void setup() {
    fullScreen();
    int h = displayHeight - 40;
    rows = displayWidth / cellSize;
    cols = h / cellSize;
    offsetX = (displayWidth - rows * cellSize) / 2;
    offsetY = (h - cols * cellSize) / 2;
    grid = new Grid();
}

void draw() {
    background(100);
    pushMatrix();
    translate(translateX, translateY);
    scale(zoom);
    grid.draw();
    popMatrix();
}


void mouseWheel(MouseEvent e) {
    float count = e.getCount();
    float delta = count < 0 ? 1.05 : count > 0 ? 1.0 / 1.05 : 1.0;
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
