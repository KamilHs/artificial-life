public class GridCell {
  public int x, y;
  public Cell cell = null;
  public float organicLevel = GridCellConfig.initialOrganic;
  public float chargeLevel = GridCellConfig.initialCharge;
  public GridCellType type;

  public GridCell(int x, int y) {
    this.x = x;
    this.y = y;

    int xx = x % clanRows;
    int yy = y % clanCols;

    if (xx < SectorsConfig.borderWidth || xx >= clanRows - SectorsConfig.borderWidth || yy < SectorsConfig.borderWidth || yy >= clanCols - SectorsConfig.borderWidth){
      type = GridCellType.BORDER;
      organicLevel = GridCellConfig.organicPoisoningLimit + 1;
    }
    else if (xx < SectorsConfig.noSpawnNoSun || xx >= clanRows - SectorsConfig.noSpawnNoSun || yy < SectorsConfig.noSpawnNoSun || yy >= clanCols - SectorsConfig.noSunZoneWidth)
      type = GridCellType.NO_SUN_NO_SPAWN_ZONE;
    else if (xx < SectorsConfig.noSunZoneWidth || xx >= clanRows - SectorsConfig.noSunZoneWidth || yy < SectorsConfig.noSunZoneWidth || yy >= clanCols - SectorsConfig.noSunZoneWidth)
      type = GridCellType.NO_SUN_ZONE;
    else
      type = GridCellType.SUN_ZONE;
  }

  void update() {
    chargeLevel = Utils.normaliseCharge(chargeLevel, GridCellConfig.normalCharge);
  }

  void draw() {
    if (ViewModeConfig.mode == ViewModeEnum.ORGANIC) {
      int[] c = getOrganicLevelColor(organicLevel);
      fill(c[0], c[1], c[2]);
    } else {
      if (isOrganicallyPoisoned())
        fill(255, 0, 0);
      else if (chargeLevel > GridCellConfig.poisoningChargeLimit)
        fill(0, 0, 255);
      else if(!hasSun())
        fill((x + y) % 2 == 0 ? 235 : 220);
      else
        fill((x + y) % 2 == 0 ? 255 : 240);
    }
    rect(x * GridCellConfig.size + offsetX, y * GridCellConfig.size + offsetY, GridCellConfig.size, GridCellConfig.size);
  }

  boolean isOrganicallyPoisoned(){
    return organicLevel > GridCellConfig.organicPoisoningLimit;
  }

  boolean canInitiallySpawned(){
    return type != GridCellType.BORDER && type != GridCellType.NO_SUN_NO_SPAWN_ZONE;
  }

  boolean hasSun() {
    return canInitiallySpawned() && type != GridCellType.NO_SUN_ZONE;
  }
}


enum GridCellType {
  BORDER,
  NO_SUN_NO_SPAWN_ZONE,
  NO_SUN_ZONE,
  SUN_ZONE;
}
