static class Utils {
    double normaliseCharge(double charge, double normalCharge) {
        return Math.abs(charge - normalCharge) < 0.1 ? charge : charge + (normalCharge - charge) * 0.02;
    }
}