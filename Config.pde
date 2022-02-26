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

  static int borderWidth = 3;
  static int noSpawnNoSun;
  static int noSunZoneWidth;
}

static class ViewModeConfig {
  static ViewModeEnum mode = ViewModeEnum.NORMAL;
}

static class AntennaConfig {
  static float generatePerFrame = 0.03;
  static float organicAfterDeath = 0.7;
  static float chargeAfterDeath = 0.5;
  static int size = GridCellConfig.size / 2;
}

static class GridCellConfig {
  static int size = 4;
  static float initialOrganic = 3.0;
  static int[] poisoningOrganicColor = new int[]{255, 0, 0};
  static int[] poisoningChargeColor = new int[]{0, 0, 255};
  static float organicPoisoningLimit = 10.0;
  static float initialCharge = 3.0;
  static float normalCharge = 3.0;
  static float poisoningChargeLimit = 4.5;
}

static class LeafConfig {
  static float photosynthesisFactor = 0.02;
  static float organicAfterDeath = 0.7;
  static float chargeAfterDeath = 0.5;
  static float size = GridCellConfig.size / 2;
  static float generatePerFrame(float sunIntensity) {
    return photosynthesisFactor * sunIntensity;
  }
}

static class OffshootConfig {
  static float probToAppear = 0.15;
  static float consumePerFrame = 0.004;
  static float energyToTransform = 0.7;
  static float organicAfterDeath = 0.7;
  static float chargeAfterDeath = 0.5;
  static float maxEatableOrganic = 0.5;
  static float initialEnergy = 0.4;
  static float size = GridCellConfig.size / 2;
}

static class SeedConfig {
  static float consumePerFrame = 0.02;
}

static class RootConfig {
  static float generatePerFrame = 0.02;
  static float organicAfterDeath = 0.7;
  static float chargeAfterDeath = 0.5;
  static int size = GridCellConfig.size / 2;
}

static class WoodConfig {
  static int lifetime = 100;
  static float organicAfterDeath = 0.7;
  static float chargeAfterDeath = 0.5;
  static float size = Math.max(GridCellConfig.size / 5, 0.5);
}

static class SunConfig {
  static float min = 5;
  static float max = 20;
  static float current;

  static public void calculateIntensity(int currentFrame, int halfPeriodTime) {
    if (currentFrame < halfPeriodTime) {
      SunConfig.current = SunConfig.max - map(currentFrame, 0, halfPeriodTime, SunConfig.min, SunConfig.max);
    } else {
      currentFrame = currentFrame % (2 * halfPeriodTime);
      if (currentFrame > halfPeriodTime)
        SunConfig.current = map(currentFrame, halfPeriodTime, 2*halfPeriodTime, SunConfig.min, SunConfig.max/2);
      else
      SunConfig.current = SunConfig.max/2 - map(currentFrame, 0, halfPeriodTime, SunConfig.min, SunConfig.max/2);
    }
  }
}

static class DNAConfig {
  static int movementSize = 64;
  static int reproductionSize = 25;
  static float mutationRate = 0.01;
}

static class ScreenshotsConfig {
  static int interval = 15;
  static boolean enabled = false;
}

static class RenderConfig {
  static boolean show = false;
}
