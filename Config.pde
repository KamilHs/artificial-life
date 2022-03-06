public enum ViewModeEnum {
  NORMAL,
    ORGANIC,
    CHARGE,
    SECTORS;
};

static class SectorsConfig {
  static int[][] colors = new int[][]{
    {255, 247, 8},
    {34, 184, 20},
    {12, 102, 176},
    {255, 0, 0},
    {255, 129, 3},
    {255, 36, 120},
    {44, 242, 176},
    {126, 19, 240},
  };

  static int borderWidth = 4;
  static int noSpawnNoSun;
  static int noSunZoneWidth;
}

static class ViewModeConfig {
  static ViewModeEnum mode = ViewModeEnum.NORMAL;
}

static class AntennaConfig {
  static float generatePerFrame = 0.03;
  static float organicAfterDeath = 0.4;
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
  static float organicAfterDeath = 0.4;
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
  static float organicAfterDeath = 0.4;
  static float chargeAfterDeath = 0.5;
  static float maxEatableOrganic = 0.5;
  static float initialEnergy = 0.4;
  static float size = GridCellConfig.size / 2;
}

static class SeedConfig {
  static float organicAfterDeath = 0.4;
  static float chargeAfterDeath = 0.5;
  static float size = GridCellConfig.size / 2;
}

static class RootConfig {
  static float generatePerFrame = 0.02;
  static float organicAfterDeath = 0.4;
  static float chargeAfterDeath = 0.5;
  static int size = GridCellConfig.size / 2;
}

static class WoodConfig {
  static int lifetime = 200;
  static float organicAfterDeath = 0.4;
  static float chargeAfterDeath = 0.5;
  static float size = Math.max(GridCellConfig.size / 5, 0.5);
}

static class SunConfig {
  static float min = 5;
  static float max = 20;
  static float current;
  static int halfPeriodTime = 2500;

  static public void calculateIntensity(int currentFrame) {
    if (currentFrame < SunConfig.halfPeriodTime) {
      SunConfig.current = SunConfig.max - map(currentFrame, 0, SunConfig.halfPeriodTime, SunConfig.min, SunConfig.max);
    } else {
      currentFrame = currentFrame % (2 * SunConfig.halfPeriodTime);
      if (currentFrame > SunConfig.halfPeriodTime)
        SunConfig.current = map(currentFrame, SunConfig.halfPeriodTime, 2 * SunConfig.halfPeriodTime, SunConfig.min, SunConfig.max / 2);
      else
      SunConfig.current = SunConfig.max / 2 - map(currentFrame, 0, SunConfig.halfPeriodTime, SunConfig.min, SunConfig.max / 2);
    }
  }
}

static class DNAConfig {
  static int movementSize = 64;
  static int reproductionSize = 20;
  static float mutationRate = 0.01;
}

static class ScreenshotsConfig {
  static int interval = 200;
  static boolean enabled = false;
}

static class RenderConfig {
  static boolean show = true;
  static boolean paused = false;
  static int frameRate = 2000;
}

static class SidebarConfig {
  static int width = 400;
  static int textOffsetLeft = 12;
  static int movementCellSize = 36;
  static int reproductionCellSize = 30;
}