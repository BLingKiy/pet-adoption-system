package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import bean.Breed;

public class BreedDao {

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
                sqlWhere = " where concat_ws(',', breedName, breedDesc) like ?";
            }

            if (search.equals("")) {
                sql = "select count(*) from tb_breed";
                rs = db.select(sql);
            } else {
                sql = "select count(*) from tb_breed " + sqlWhere;
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
    public List<Breed> queryAll(HttpServletRequest request, String search, int indexStart, int pageSize) {

        List<Breed> breedList = new ArrayList<Breed>();
        String msg = "";

        try {
            String breedId, breedName, breedDesc;

            String sqlWhere = "";

            if (search.equals("") == false) {
                sqlWhere = " where concat_ws(',', breedName, breedDesc) like ?";
            }

            if (search.equals("")) {
                sql = "select * from tb_breed order by breedId"
                        + " limit " + indexStart + "," + pageSize;
                rs = db.select(sql);
            } else {
                sql = "select * from tb_breed " + sqlWhere + " order by breedId"
                        + " limit " + indexStart + "," + pageSize;
                rs = db.select(sql, "%" + search + "%");
            }

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return breedList;
            }

            Breed breed = null;

            while (rs.next()) {
                breedId = rs.getString("breedId");
                breedName = rs.getString("breedName");
                breedDesc = rs.getString("breedDesc");

                breed = new Breed();

                breed.setBreedId(breedId);
                breed.setBreedName(breedName);
                breed.setBreedDesc(breedDesc);

                breedList.add(breed);
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

        return breedList;
    }

    /**------------------------------ 获取所有品种（用于下拉列表） */
    public List<Breed> queryAllForSelect(HttpServletRequest request) {

        List<Breed> breedList = new ArrayList<Breed>();
        String msg = "";

        try {
            String breedId, breedName, breedDesc;

            sql = "select * from tb_breed order by breedId";
            rs = db.select(sql);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return breedList;
            }

            Breed breed = null;

            while (rs.next()) {
                breedId = rs.getString("breedId");
                breedName = rs.getString("breedName");
                breedDesc = rs.getString("breedDesc");

                breed = new Breed();

                breed.setBreedId(breedId);
                breed.setBreedName(breedName);
                breed.setBreedDesc(breedDesc);

                breedList.add(breed);
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

        return breedList;
    }

    /**------------------------------ 根据ID查询记录 */
    public Breed queryByBreedId(HttpServletRequest request, String breedId) {

        Breed breed = null;
        String msg = "";

        try {
            String breedName, breedDesc;

            sql = "select * from tb_breed where breedId = ?";
            rs = db.select(sql, breedId);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return breed;
            }

            if (rs.next() == false) {
                db.close();
                return breed;
            }

            breedName = rs.getString("breedName");
            breedDesc = rs.getString("breedDesc");
            db.close();

            breed = new Breed();

            breed.setBreedId(breedId);
            breed.setBreedName(breedName);
            breed.setBreedDesc(breedDesc);

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return breed;
    }

    /**------------------------------ 是否存在品种名称相同的记录 */
    public boolean existByBreedName(HttpServletRequest request, String breedName) {

        String msg = "";

        try {
            sql = "select * from tb_breed where breedName = ?";
            rs = db.select(sql, breedName);

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

    /**------------------------------ 是否存在品种名称相同而与ID不同的记录 */
    public boolean existByBreedNameExptId(HttpServletRequest request, String breedName, String breedId) {

        String msg = "";

        try {
            sql = "select * from tb_breed where breedName = ? and breedId != ?";
            rs = db.select(sql, breedName, breedId);

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
    public String addBreed(HttpServletRequest request, Breed breed) {

        String breedId = "0";
        String msg = "";

        try {
            String breedName, breedDesc;

            breedName = breed.getBreedName();
            breedDesc = breed.getBreedDesc();

            // 查找最小可用ID
            breedId = findAvailableBreedId(request);

            if (breedId.equals("0")) {
                msg += "获取可用ID失败！";
                return breedId;
            }

            // 使用指定ID插入
            sql = "insert into tb_breed (breedId, breedName, breedDesc) values (?, ?, ?)";
            int count = db.update(sql, breedId, breedName, breedDesc);

            if (count == 0) {
                breedId = "0";
                return breedId;
            }

            return breedId;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return breedId;
    }

    /**------------------------------ 查找最小可用ID（包括已删除的ID） */
    public String findAvailableBreedId(HttpServletRequest request) {

        String availableId = "0";
        String msg = "";

        try {
            // 查找所有现有ID，按升序排列
            sql = "select breedId from tb_breed order by breedId";
            rs = db.select(sql);

            if (rs == null) {
                msg += "数据库操作发生错误！";
                return availableId;
            }

            int expectedId = 1;
            boolean found = false;

            // 遍历现有ID，找到第一个缺失的ID
            while (rs.next()) {
                int currentId = rs.getInt("breedId");
                if (currentId > expectedId) {
                    // 找到缺失的ID
                    found = true;
                    break;
                }
                expectedId++;
            }
            db.close();

            // 如果没有缺失的ID，使用下一个顺序ID
            availableId = String.valueOf(expectedId);

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);
        }

        return availableId;
    }

    /**------------------------------ 更新记录 */
    public int editBreed(HttpServletRequest request, Breed breed) {

        int count = 0;
        String msg = "";

        try {
            String breedId, breedName, breedDesc;

            breedId = breed.getBreedId();
            breedName = breed.getBreedName();
            breedDesc = breed.getBreedDesc();

            sql = "update tb_breed set breedName = ?, breedDesc = ? where breedId = ?";
            count = db.update(sql, breedName, breedDesc, breedId);

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
    public boolean deleteByBreedId(HttpServletRequest request, String breedId) {

        String msg = "";

        try {
            sql = "delete from tb_breed where breedId = ?";
            int count = db.delete(sql, breedId);

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
    public boolean deleteByBreedIdLot(HttpServletRequest request, String breedIdLot) {

        String msg = "";

        try {
            sql = "delete from tb_breed where breedId in (" + breedIdLot + ")";
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