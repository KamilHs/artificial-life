import java.util.Arrays;
import java.util.Optional;

public enum MovementEnum {
  MOVE(15), ROTATE(16), EAT(17);

  private final int value;

  MovementEnum(int value) {
    this.value = value;
  }

  public static MovementEnum valueOf(int value) {
    switch(value) {
    case 15:
      return MOVE;
    case 16:
      return ROTATE;
    case 17:
      return EAT;
    default:
      return null;
    }
  }
}

enum DirectionEnum {
  RIGHT(0), BACK(1), LEFT(2), FORWARD(3);

  private final int value;

  DirectionEnum(int value) {
    this.value = value;
  }

  public static DirectionEnum valueOf(int value) {
    switch(value % 4) {
    case 0:
      return RIGHT;
    case 1:
      return BACK;
    case 2:
      return LEFT;
    case 3:
      return FORWARD;
    default :
      return RIGHT;
    }
  }
}

enum MoveOffsetEnum {
  EMPTY(2),
    ORGANIC_POISON(3),
    CHARGE_POISON(4),
    SIBLING(5),
    ENEMY(6);

  private final int value;

  MoveOffsetEnum(int value) {
    this.value = value;
  }

  public int getValue() {
    return value;
  }
};

enum EatOffsetEnum {
    EATABLE_CELL(2),
      EMPTY(3),
      NOT_EATABLE_CELL(4),
      ORGANIC_POISON(5),
      CHARGE_POISON(6),
      SIBLING(7);

  private final int value;

  EatOffsetEnum(int value) {
    this.value = value;
  }

  public int getValue() {
    return value;
  }
};