package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import bean.Pet;

public class PetDao {

    Db db = new Db();
    String sql = "";
    ResultSet rs = null;

    /**------------------------------ 获取记录总数 */
    public int queryCount(HttpServletRequest request, String search) {

        int count = 0;
        String msg = "";

        try {
            String sqlWhere = "";

            if (search.equals("") == false) {
                sqlWhere = " where concat_ws(',', petNo, petName, breedName, color) like ?";
            }

            if (search.equals("")) {
                sql = "select count(*) from tb_pet";
                rs = db.select(sql);
            } else {
                sql = "select count(*) from tb_pet " + sqlWhere;
                rs = db.select(sql, "%" + search + "%");
            }

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return count;
            }

            if (rs.next() == false) {
                db.close();
                return count;
            }
            count = rs.getInt(1);
            db.close();

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return count;
    }

    /**------------------------------ 获取满足查询条件的要显示的页中的记录列表 */
    public List<Pet> queryAll(HttpServletRequest request, String search, int indexStart, int pageSize) {

        List<Pet> petList = new ArrayList<Pet>();
        String msg = "";

        try {
            String petId, petNo, petName, breedId, breedName, gender, age, weight, color, healthStatus, price, timeRegister, image;

            String sqlWhere = "";

            if (search.equals("") == false) {
                sqlWhere = " where concat_ws(',', petNo, petName, breedName, color) like ?";
            }

            if (search.equals("")) {
                sql = "select * from tb_pet order by petName"
                        + " limit " + indexStart + "," + pageSize;
                rs = db.select(sql);
            } else {
                sql = "select * from tb_pet " + sqlWhere + " order by petName"
                        + " limit " + indexStart + "," + pageSize;
                rs = db.select(sql, "%" + search + "%");
            }

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return petList;
            }

            Pet pet = null;
            long time = (new Date()).getTime();

            while (rs.next()) {
                petId = rs.getString("petId");
                petNo = rs.getString("petNo");
                petName = rs.getString("petName");
                breedId = rs.getString("breedId");
                breedName = rs.getString("breedName");
                gender = rs.getString("gender");
                age = rs.getString("age");
                weight = rs.getString("weight");
                color = rs.getString("color");
                healthStatus = rs.getString("healthStatus");
                price = rs.getString("price");
                timeRegister = rs.getString("timeRegister");
                image = rs.getString("image") + "?t=" + time;

                pet = new Pet();

                pet.setPetId(petId);
                pet.setPetNo(petNo);
                pet.setPetName(petName);
                pet.setBreedId(breedId);
                pet.setBreedName(breedName);
                pet.setGender(gender);
                pet.setAge(age);
                pet.setWeight(weight);
                pet.setColor(color);
                pet.setHealthStatus(healthStatus);
                pet.setPrice(price);
                pet.setTimeRegister(timeRegister);
                pet.setImage(image);

                petList.add(pet);
            }
            db.close();

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return petList;
    }

    /**------------------------------ 根据ID查询记录 */
    public Pet queryByPetId(HttpServletRequest request, String petId) {

        Pet pet = null;
        String msg = "";

        try {
            String petNo, petName, breedId, breedName, gender, age, weight, color, healthStatus, price, timeRegister, image, detail, timeRenew;

            sql = "select * from tb_pet where petId = ?";
            rs = db.select(sql, petId);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return pet;
            }

            if (rs.next() == false) {
                db.close();
                return pet;
            }

            petNo = rs.getString("petNo");
            petName = rs.getString("petName");
            breedId = rs.getString("breedId");
            breedName = rs.getString("breedName");
            gender = rs.getString("gender");
            age = rs.getString("age");
            weight = rs.getString("weight");
            color = rs.getString("color");
            healthStatus = rs.getString("healthStatus");
            price = rs.getString("price");
            timeRegister = rs.getString("timeRegister");
            image = rs.getString("image");
            detail = rs.getString("detail");
            timeRenew = rs.getString("timeRenew");
            db.close();

            pet = new Pet();

            pet.setPetId(petId);
            pet.setPetNo(petNo);
            pet.setPetName(petName);
            pet.setBreedId(breedId);
            pet.setBreedName(breedName);
            pet.setGender(gender);
            pet.setAge(age);
            pet.setWeight(weight);
            pet.setColor(color);
            pet.setHealthStatus(healthStatus);
            pet.setPrice(price);
            pet.setTimeRegister(timeRegister);
            pet.setImage(image);
            pet.setDetail(detail);
            pet.setTimeRenew(timeRenew);

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return pet;
    }

    /**------------------------------ 是否存在宠物编号相同的记录 */
    public boolean existByPetNo(HttpServletRequest request, String petNo) {

        String msg = "";

        try {
            sql = "select * from tb_pet where petNo = ?";
            rs = db.select(sql, petNo);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return false;
            }

            if (rs.next() == false) {
                db.close();
                return false;
            }
            db.close();

            return true;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return false;
    }

    /**------------------------------ 是否存在宠物编号相同而与ID不同的记录 */
    public boolean existByPetNoExptId(HttpServletRequest request, String petNo, String petId) {

        String msg = "";

        try {
            sql = "select * from tb_pet where petNo = ? and petId != ?";
            rs = db.select(sql, petNo, petId);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return false;
            }

            if (rs.next() == false) {
                db.close();
                return false;
            }
            db.close();

            return true;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return false;
    }

    /**------------------------------ 新添记录 */
    public String addPet(HttpServletRequest request, Pet pet) {

        String petId = "0";
        String msg = "";

        try {
            String petNo, petName, breedId, breedName, gender, age, weight, color, healthStatus, price, detail;

            petNo = pet.getPetNo();
            petName = pet.getPetName();
            breedId = pet.getBreedId();
            breedName = pet.getBreedName();
            gender = pet.getGender();
            age = pet.getAge();
            weight = pet.getWeight();
            color = pet.getColor();
            healthStatus = pet.getHealthStatus();
            price = pet.getPrice();
            detail = pet.getDetail();

            sql = "insert tb_pet (petNo, petName, breedId, breedName, gender, age, weight, color, healthStatus, price, detail)"
                    + " values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            petId = db.insert(sql, petNo, petName, breedId, breedName, gender, age, weight, color, healthStatus, price, detail);

            if (petId.equals("0")) {
                return petId;
            }

            return petId;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return petId;
    }

    /**------------------------------ 更新记录 */
    public int editPet(HttpServletRequest request, Pet pet) {

        int count = 0;
        String msg = "";

        try {
            String petId, petNo, petName, breedId, breedName, gender, age, weight, color, healthStatus, price, detail;

            petId = pet.getPetId();
            petNo = pet.getPetNo();
            petName = pet.getPetName();
            breedId = pet.getBreedId();
            breedName = pet.getBreedName();
            gender = pet.getGender();
            age = pet.getAge();
            weight = pet.getWeight();
            color = pet.getColor();
            healthStatus = pet.getHealthStatus();
            price = pet.getPrice();
            detail = pet.getDetail();

            sql = "update tb_pet set petNo = ?, petName = ?, breedId = ?, breedName = ?, gender = ?"
                    + ", age = ?, weight = ?, color = ?, healthStatus = ?, price = ?, detail = ?, timeRenew = (now()) where petId = ?";
            count = db.update(sql, petNo, petName, breedId, breedName, gender, age, weight, color, healthStatus, price, detail, petId);

            if (count == 0) {
                return count;
            }

            return count;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return count;
    }

    /**------------------------------ 更新记录：更新宠物图片image */
    public int editImage(HttpServletRequest request, String image, String petId) {

        int count = 0;
        String msg = "";

        try {
            sql = "update tb_pet set image = ?, timeRenew = (now()) where petId = ?";
            count = db.update(sql, image, petId);

            if (count == 0) {
                return count;
            }

            return count;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return count;
    }

    /**------------------------------ 删除ID对应的记录 */
    public boolean deleteByPetId(HttpServletRequest request, String petId) {

        String msg = "";

        try {
            sql = "delete from tb_pet where petId = ?";
            int count = db.delete(sql, petId);

            if (count == 0) {
                return false;
            }

            return true;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return false;
    }

    /**------------------------------ 删除ID列表中的记录 */
    public boolean deleteByPetIdLot(HttpServletRequest request, String petIdLot) {

        String msg = "";

        try {
            sql = "delete from tb_pet where petId in (" + petIdLot + ")";
            int count = db.delete(sql);

            if (count == 0) {
                return false;
            }

            return true;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return false;
    }

    /**------------------------------ 是否存在拥有该breedId的宠物记录 */
    public boolean existByBreedId(HttpServletRequest request, String breedId) {

        String msg = "";

        try {
            sql = "select * from tb_pet where breedId = ?";
            rs = db.select(sql, breedId);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return false;
            }

            if (rs.next() == false) {
                db.close();
                return false;
            }
            db.close();

            return true;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return false;
    }
}