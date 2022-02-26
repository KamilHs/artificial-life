static class Utils {
  static public float normaliseCharge(float charge, float normalCharge) {
    return Math.abs(charge - normalCharge) < 0.1 ? charge : charge + (normalCharge - charge) * 0.001;
  }

  static public int[] wrapCoords(int x, int y, int rows, int cols) {
    if (x < 0)
      x = rows - 1;
    else if (x >= rows)
      x = 0;
    if (y < 0)
      y = cols - 1;
    else if (y >= cols)
      y = 0;

    return new int[]{x, y};
  }
}
