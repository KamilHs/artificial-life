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
ArrayList<Cell> addedCells = new ArrayList<Cell>();

int[] getFrontCellByCoords(int x, int y, float a) {
  int newX = x + int(cos(a));
  int newY = y + int(sin(a));
  return Utils.wrapCoords(newX, newY, rows, cols);
}


float rotateTo(float a, DirectionEnum direction) {
  switch(direction) {
  case LEFT:
    a -= HALF_PI;
    break;
  case RIGHT:
    a += HALF_PI;
    break;
  case FORWARD:
    break;
  case BACK:
    a += PI;
    break;
  default :
    break;
  }

  return a % TWO_PI;
}

int[] mapValueToColor(float curr, float min, float max, int[] overflowColor){
  if(curr < min) return new int[]{255,255,255};
  if(curr > max) return overflowColor;

  int mappedColor = int(map(curr, min, max, 255, 0));

  return new int[]{mappedColor, mappedColor, mappedColor};
}

int[] getOrganicLevelColor(float level){
  return mapValueToColor(level, GridCellConfig.initialOrganic, GridCellConfig.organicPoisoningLimit, GridCellConfig.poisoningOrganicColor);
}

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
  LeafConfig.size = GridCellConfig.size / 2;
  RootConfig.size = GridCellConfig.size / 2;
  AntennaConfig.size = GridCellConfig.size / 2;
  WoodConfig.size = max(GridCellConfig.size / 5, 0.5);
  grid = new Grid();

  int n = 0;
  for (int i = 0; i < cols; ++i) {
    for (int j = 0; j < rows; ++j) {
      if (j % 2 == 0 && i % 2 == 0 && grid.cells[i][j].canInitiallySpawned()) {
        Cell cell = new Offshoot(floor(j / clanRows) + floor(i / clanCols) * nbClansPerRow, j, i);
        cells.add(cell);
        n++;
        grid.cells[i][j].cell = cell;
      }
    }
  }
  println(n);

  noStroke();
  textAlign(CENTER, CENTER);
  strokeCap(SQUARE);
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

  cells.removeIf(cell -> !cell.isAlive());
  addedCells.forEach(cell -> cells.add(cell));
  addedCells.clear();
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
  } else if (key == '1') {
    ViewModeConfig.mode = ViewModeEnum.NORMAL;
  } else if (key == '2') {
    ViewModeConfig.mode = ViewModeEnum.SECTORS;
  } else if (key == '3') {
    ViewModeConfig.mode = ViewModeEnum.ORGANIC;
  }
}
