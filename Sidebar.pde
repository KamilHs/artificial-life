public class Sidebar {
  public void draw() {
    if (selectedCell == null) return;
    push();
    fill(255);
    translate(width - SidebarConfig.width, 0);
    rect(0, 0, SidebarConfig.width, height);
    textSize(32);
    fill(0);
    text(selectedCell.getClass().getSimpleName(), SidebarConfig.width / 2, 32);
    textAlign(LEFT);
    textSize(16);
    text("Organizm ID: " + selectedCell.organizmId.toString(), SidebarConfig.textOffsetLeft, 96);
    text("Sector ID: " + (selectedCell.sectorId + 1), SidebarConfig.textOffsetLeft, 128);
    text("Total energy: " + selectedCell.getEnergy(), SidebarConfig.textOffsetLeft, 160);
    if (selectedCell instanceof Wood) {
      text("Age: " + ((Wood)selectedCell).age, SidebarConfig.textOffsetLeft, 192);
      text("Root: " + (selectedCell.parent == null ? "True": "False"), SidebarConfig.textOffsetLeft, 224);
    } else if (selectedCell instanceof Seed || selectedCell instanceof Offshoot) {
      textAlign(CENTER);
      textSize(24);
      text("Genes", SidebarConfig.width / 2, 192);
      textAlign(LEFT);
      textSize(16);
      text("Movement", SidebarConfig.textOffsetLeft, 224);

      stroke(0);
      strokeWeight(2);
      textSize(20);
      textAlign(CENTER);

      int size = SidebarConfig.movementCellSize;
      int offsetY = 256;
      int offsetX = (SidebarConfig.width - size * 8) / 2;
      boolean showCurrentCommand = selectedCell.parent == null && selectedCell.isAlive() && selectedCell instanceof Offshoot;
      Offshoot o = (Offshoot)selectedCell;

      for (int i = 0; i < 8; ++i) {
        int dy = offsetY + size * i;
        for (int j = 0; j < 8; ++j) {
          int dx = offsetX + size * j;

          if (showCurrentCommand && i * 8 + j == o.programCounter)
            fill(255, 0, 255, 126);
          else
            noFill();

          rect(dx, dy, size, size);
          fill(0);
          text(o.dna.movement[i * 8 + j], dx + size / 2, dy + size / 2 + 8);
        }
      }


      textAlign(LEFT);
      textSize(16);
      text("Reproduction", SidebarConfig.textOffsetLeft, 580);

      int marginX = 18;
      int groupsCount = DNAConfig.reproductionSize / 4;
      offsetY = 630;
      offsetX = (SidebarConfig.width - marginX * (groupsCount - 1) - SidebarConfig.reproductionCellSize * 2 * groupsCount) / 2;
      size = SidebarConfig.reproductionCellSize;

      textSize(20);
      textAlign(CENTER);
      rectMode(CENTER);

      for (int i = 0; i < groupsCount; ++i) {
        int dx = offsetX + size * i * 2 + marginX * i;
        if (o.dna.activeReproductionGen == i)
          fill(255, 0, 255, 126);
        else
          noFill();
        rect(dx + size, offsetY, size, size);
        fill(0);
        text(i, dx + size, offsetY + 8);
        noFill();

        int dy = offsetY + 12;

        rect(dx + size, dy + size, size, size);
        rect(dx + size * 0.5, dy + size * 2, size, size);
        rect(dx + size * 1.5, dy + size * 2, size, size);
        rect(dx + size, dy + size * 3, size, size);

        fill(0);
        text(o.dna.reproduction[i * 4], dx + size * 1.5, dy + size * 2 + 8);
        text(o.dna.reproduction[i * 4 + 1], dx + size, dy + size * 3 + 8);
        text(o.dna.reproduction[i * 4 + 2], dx + size * 0.5, dy + size * 2 + 8);
        text(o.dna.reproduction[i * 4 + 3], dx + size, dy + size + 8);
      }
    }
    pop();
  }

  public boolean isMouseOverSidebar() {
    return selectedCell != null && mouseX >= width - SidebarConfig.width;
  }
}
