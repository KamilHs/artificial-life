public enum ViewModeEnum {
  NORMAL,
    ORGANIC,
    CHARGE,
    SECTORS;
};

static class SectorsConfig {
  static int[][] colors = new int[][]{
    {255, 0, 0},
    {0, 255, 0},
    {0, 0, 255},
    {255, 0, 255},
    {255, 160, 0},
    {200, 200, 0},
    {100, 10, 0},
    {10, 100, 40},
  };

  static int borderWidth = 2;
  static int noSpawnNoSun = 6;
  static int noSunZoneWidth = 16;
}

static class ViewModeConfig {
  static ViewModeEnum mode = ViewModeEnum.NORMAL;
}

static class AntennaConfig {
  static float generatePerFrame = 1;
  static float energyToBeBorn = 0.8;
  static float organicAfterDeath = 1.5;
  static float initialEnergy = 0.3;
  static int size;
}

static class GridCellConfig {
  static int size = 4;
  static float initialOrganic = 3.0;
  static int[] poisoningOrganicColor = new int[]{255, 0, 0};
  static float organicPoisoningLimit = 10.0;
  static float initialCharge = 3.0;
  static float normalCharge = 3.0;
  static float poisoningChargeLimit = 10.0;
}

static class LeafConfig {
  static float photosynthesisFactor = 0.06;
  static float energyToBeBorn = 0.8;
  static float organicAfterDeath = 1.5;
  static float size;
  static float initialEnergy = 0.3;
  static float generatePerFrame(float sunIntensity) {
    return photosynthesisFactor * sunIntensity;
  }
}

static class OffshootConfig {
  static float probToAppear = 0.15;
  static float consumePerFrame = 0.004;
  static float energyToTransform = 0.7;
  static float organicAfterDeath = 1.5;
  static float maxEatableOrganic = 0.5;
  static float initialEnergy = 0.4;
  static float size;
}

static class SeedConfig {
  static float consumePerFrame = 0.02;
}

static class RootConfig {
  static float initialEnergy = 0.3;
  static float generatePerFrame = 0.06;
  static float organicAfterDeath = 1.5;
  static int size;
}

static class WoodConfig {
  static float initialEnergy = 0.3;
  static int lifetime = 200;
  static float organicAfterDeath = 1.5;
  static float size;
}

static class SunConfig {
  static float min = 0;
  static float max = 20;
  static float initial = 10;
}

static class DNAConfig {
  static int movementSize = 64;
  static int reproductionSize = 60;
  static float mutationRate = 0.01;
}
