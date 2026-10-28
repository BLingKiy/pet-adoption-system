package bean;

public class Cart {

    private String cartId;           // 购物车ID
    private String userId;           // 用户ID（游客使用session ID）
    private String petId;            // 宠物ID
    private String petNo;            // 宠物编号
    private String petName;          // 宠物名称
    private String breedName;        // 品种名称
    private String price;            // 价格
    private String quantity;         // 数量
    private String image;            // 宠物图片
    private String timeAdd;          // 添加时间

    public String getCartId() {
        return cartId;
    }

    public void setCartId(String cartId) {
        this.cartId = cartId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPetId() {
        return petId;
    }

    public void setPetId(String petId) {
        this.petId = petId;
    }

    public String getPetNo() {
        return petNo;
    }

    public void setPetNo(String petNo) {
        this.petNo = petNo;
    }

    public String getPetName() {
        return petName;
    }

    public void setPetName(String petName) {
        this.petName = petName;
    }

    public String getBreedName() {
        return breedName;
    }

    public void setBreedName(String breedName) {
        this.breedName = breedName;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTimeAdd() {
        return timeAdd;
    }

    public void setTimeAdd(String timeAdd) {
        this.timeAdd = timeAdd;
    }
}