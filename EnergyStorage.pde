public class EnergyStorage {
    float energy;

    public EnergyStorage(float energy){
        this.energy = energy;
    }

    public void addEnergy(float e){
        energy += e;
    }
}