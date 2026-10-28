package bean;

public class Breed {

    private String breedId;     // 品种ID
    private String breedName;   // 品种名称
    private String breedDesc;   // 品种描述

    public String getBreedId() {
        return breedId;
    }

    public void setBreedId(String breedId) {
        this.breedId = breedId;
    }

    public String getBreedName() {
        return breedName;
    }

    public void setBreedName(String breedName) {
        this.breedName = breedName;
    }

    public String getBreedDesc() {
        return breedDesc;
    }

    public void setBreedDesc(String breedDesc) {
        this.breedDesc = breedDesc;
    }
}