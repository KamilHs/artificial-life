public enum ViewModeEnum {
    NORMAL,
    ORGANIC,
    CHARGE,
    CLANS;
};

static class ViewModeConfig {
    ViewModeEnum current = ViewModeEnum.NORMAL;
}

static class AntennaConfig {
    double generatePerFrame = 1;
    double energyToBeBorn = 0.8;
    double organicAfterDeath = 1.5;
    int size;
}

static class GridConfig {
    int width = 2000;
    int height = 1000;
}

static class GridCellConfig {
    int size = 40;
    double initialOrganic = 3.0;
    double organicPoisoningLimit = 10.0;
    double initialCharge = 3.0;
    double normalCharge = 3.0;
    double poisoningChargeLimit = 10.0;
}

static class LeafConfig {
    double photosynthesisFactor = 0.005;
    double energyToBeBorn = 0.8;
    double organicAfterDeath = 1.5;
    double width;
    double length;
    
    double generatePerFrame(double sunIntensity) {
        return photosynthesisFactor * sunIntensity;
    }
}

static class OffshootConfig {
    double probToAppear = 0.2;
    double consumePerFrame = 0.04;
    double energyToBeBorn = 0.8;
    double organicAfterDeath = 1.5;
    int size;
}

static class SeedConfig {
    double consumePerFrame = 0.02;
}

static class RootConfig {
    double generatePerFrame = 0.05;
    int lifetime = 20;
    double energyToBeBorn = 0.8;
    double organicAfterDeath = 1.5;
    int size;
}

static class WoodConfig {
    int lifetime = 600;
    double organicAfterDeath = 1.5;
    int width;
}

static class SunConfig {
    double min = 0;
    double max = 20;
    double initial = 10;
}

static class DNAConfig {
    static int movementSize = 64;
    static int reproductionSize = 64;
}