public class GridCell {
  public int x, y;
  public Cell cell = null;
  public float organicLevel = GridCellConfig.initialOrganic;

  public GridCell(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void draw() {
    if (ViewModeConfig.mode == ViewModeEnum.ORGANIC) {
      int[] c = getOrganicLevelColor(organicLevel);
      fill(c[0], c[1], c[2]);
    } else {
      if (organicLevel > GridCellConfig.organicPoisoningLimit)
        fill(255, 0, 0);
      else
        fill((x + y) % 2 == 0 ? 255 : 240);
    }
    rect(x *GridCellConfig.size + offsetX, y * GridCellConfig.size + offsetY, GridCellConfig.size, GridCellConfig.size);
  }
}
