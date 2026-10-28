package bean;

public class OrderDetail {

    private String detailId;         // 订单详情ID
    private String orderId;          // 订单ID
    private String orderNo;          // 订单编号
    private String petId;            // 宠物ID
    private String petNo;            // 宠物编号
    private String petName;          // 宠物名称
    private String breedName;        // 品种名称
    private String price;            // 价格
    private String quantity;         // 数量
    private String image;            // 宠物图片

    public String getDetailId() {
        return detailId;
    }

    public void setDetailId(String detailId) {
        this.detailId = detailId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
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
}