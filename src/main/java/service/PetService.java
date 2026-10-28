package service;

import java.io.File;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import bean.Breed;
import bean.Pet;
import dao.PetDao;

public class PetService {

    PetDao petDao = new PetDao();

    public boolean queryAll(HttpServletRequest request) {

        List<Pet> petList = null;
        String search = "";
        int indexStart = 0;
        int pageShow = 1;
        String page = "";
        String msg = "";

        try {
            if (request.getParameter("buttonDelete") != null) {
                String[] petIdArray = request.getParameterValues("petId");

                if (petIdArray != null) {
                    deleteByPetIdLot(request, petIdArray);
                }
            }

            String buttonSearch = request.getParameter("buttonSearch");
            String buttonPage = request.getParameter("buttonPage");
            String pageInput = "1";

            if (buttonSearch != null && request.getParameter("search") != null) {
                search = request.getParameter("search").trim();
            } else if (buttonPage != null && request.getParameter("search") != null) {
                search = request.getParameter("search").trim();
                pageInput = request.getParameter("pageShow");
            } else {
                if (request.getParameter("searchUrl") != null) {
                    search = request.getParameter("searchUrl");
                }

                if (request.getParameter("pageUrl") != null) {
                    pageInput = request.getParameter("pageUrl");
                }
            }

            if (request.getParameter("buttonFilter") != null) {
                String breedName = request.getParameter("breedName");

                if (breedName != null && breedName.equals("") == false) {
                    search = breedName;
                }
            }

            int countRow = petDao.queryCount(request, search);

            int pageSize = 6;
            int pageCount = 0;

            if (countRow % pageSize == 0) {
                pageCount = countRow / pageSize;
            } else {
                pageCount = countRow / pageSize + 1;
            }

            try {
                pageShow = Integer.parseInt(pageInput);
            } catch (Exception e) {
            }

            if (pageShow < 1) {
                pageShow = 1;
            } else if (pageShow > pageCount && pageCount >= 1) {
                pageShow = pageCount;
            }

            String searchUrl = "";

            if (search.equals("") == false) {
                searchUrl = URLEncoder.encode(search, "UTF-8");
            }

            String mapName = request.getServletPath();
            mapName = mapName.substring(1);

            if (pageShow <= 1) {
                page += "<span style='color:gray;'>首页&ensp;";
                page += "上一页&ensp;</span>";
            } else {
                page += "<a href='" + mapName + "?pageUrl=1"
                        + "&searchUrl=" + searchUrl + "'>首页</a>&ensp;";
                page += "<a href='" + mapName + "?pageUrl=" + (pageShow - 1)
                        + "&searchUrl=" + searchUrl + "'>上一页</a>&ensp;";
            }

            if (pageShow >= pageCount) {
                page += "<span style='color:gray;'>下一页&ensp;";
                page += "尾页</span>";
            } else {
                page += "<a href='" + mapName + "?pageUrl=" + (pageShow + 1)
                        + "&searchUrl=" + searchUrl + "'>下一页</a>&ensp;";
                page += "<a href='" + mapName + "?pageUrl=" + pageCount
                        + "&searchUrl=" + searchUrl + "'>尾页</a>";
            }

            page += "&emsp;&emsp;";
            page += "页码：" + pageShow + "/" + pageCount + "&emsp;";
            page += "记录数：" + countRow + "&emsp;&emsp;";

            page += "输入页码:";
            page += "\t<input type='text' name='pageShow' value='" + pageShow
                    + "' style='width:40px; text-align:center;'>";
            page += "\t<input type='submit' name='buttonPage' value='提交'>&emsp;";

            if (pageShow > 0) {
                indexStart = (pageShow - 1) * pageSize;
            }

            petList = petDao.queryAll(request, search, indexStart, pageSize);

            if (petList == null || petList.size() == 0) {
                msg += "（查无记录）";
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

            if (request.getSession().getAttribute("msg") != null) {
                msg += request.getSession().getAttribute("msg").toString();
                request.getSession().removeAttribute("msg");
                request.setAttribute("msg", msg);
            }

            request.setAttribute("search", search);
            request.setAttribute("indexStart", indexStart);
            request.setAttribute("page", page);
            request.setAttribute("petList", petList);
        }

        return false;
    }

    public boolean queryByPetId(HttpServletRequest request) {

        Pet pet = null;
        String msg = "";

        try {
            String petId = request.getParameter("petId");

            try {
                Integer.parseInt(petId);
            } catch (Exception e) {
                msg += "参数petId错误！";
                return false;
            }

            pet = petDao.queryByPetId(request, petId);

            if (pet == null) {
                msg += "（查无此宠物记录）";
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

            if (request.getSession().getAttribute("msg") != null) {
                msg += request.getSession().getAttribute("msg").toString();
                request.getSession().removeAttribute("msg");
                request.setAttribute("msg", msg);
            }

            request.setAttribute("pet", pet);
        }

        return false;
    }

    public String addPet(HttpServletRequest request) {

        String petId = "0";
        String msg = "";

        try {
            String petNo, petName, breedId, breedName, gender, age, weight, color, healthStatus, price, detail;

            // 支持从multipart表单（attribute）和普通表单（parameter）获取数据
            petNo = getRequestValue(request, "petNo");
            petName = getRequestValue(request, "petName");
            breedId = getRequestValue(request, "breedId");
            gender = getRequestValue(request, "gender");
            age = getRequestValue(request, "age");
            weight = getRequestValue(request, "weight");
            color = getRequestValue(request, "color");
            healthStatus = getRequestValue(request, "healthStatus");
            price = getRequestValue(request, "price");
            detail = getRequestValue(request, "detail");

            if (petNo == null || petName == null || breedId == null || gender == null
                    || age == null || weight == null || color == null || healthStatus == null || price == null || detail == null) {
                msg = "输入不正确！";
                return petId;
            }
            petNo = petNo.trim();
            petName = petName.trim();
            breedId = breedId.trim();
            gender = gender.trim();
            age = age.trim();
            weight = weight.trim();
            color = color.trim();
            healthStatus = healthStatus.trim();
            price = price.trim();
            detail = detail.trim();

            if (petName.equals("")) {
                msg += "请输入宠物名称。";
                return petId;
            }

            if (petName.length() > 45) {
                msg += "宠物名称的字符数不能超过45。";
                return petId;
            }

            if (petNo.equals("")) {
                msg += "请输入宠物编号。";
                return petId;
            }

            if (petNo.length() > 45) {
                msg += "宠物编号的字符数不能超过45。";
                return petId;
            }

            if (breedId.equals("")) {
                msg += "请选择宠物品种。";
                return petId;
            }

            if (gender.equals("")) {
                msg += "请选择宠物性别。";
                return petId;
            }

            if (age.equals("")) {
                msg += "请输入宠物年龄。";
                return petId;
            }

            try {
                Integer.parseInt(age);
            } catch (Exception e) {
                msg += "请输入正确的年龄！";
                return petId;
            }

            if (weight.equals("")) {
                msg += "请输入宠物体重。";
                return petId;
            }

            try {
                Float.parseFloat(weight);
            } catch (Exception e) {
                msg += "请输入正确的体重！";
                return petId;
            }

            if (color.equals("")) {
                msg += "请输入宠物颜色。";
                return petId;
            }

            if (healthStatus.equals("")) {
                msg += "请选择健康状况。";
                return petId;
            }

            if (price.equals("")) {
                msg += "请输入宠物价格。";
                return petId;
            }

            try {
                Float.parseFloat(price);
            } catch (Exception e) {
                msg += "请输入正确的价格！";
                return petId;
            }

            if (petDao.existByPetNo(request, petNo)) {
                msg += "所输入的宠物编号已经存在，请修改后再提交！";
                return petId;
            }

            breedName = "待查询";
            dao.BreedDao breedDao = new dao.BreedDao();
            Breed breed = breedDao.queryByBreedId(request, breedId);

            if (breed == null) {
                msg += "宠物品种对应的记录已不存在，请刷新页面后重试！";
                return petId;
            }
            breedName = breed.getBreedName();

            Pet pet = new Pet();

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
            pet.setDetail(detail);

            petId = petDao.addPet(request, pet);

            if (petId.equals("0")) {
                msg += "新添记录失败！请重试。";
                return petId;
            }

            String path = request.getServletContext().getRealPath("\\") + "\\";
            String uploadFolder = "fileUpload\\petImage\\";
            path += uploadFolder;

            String petUUID = getRequestValue(request, "petUUID");

            if (petUUID == null || petUUID.equals("")) {
                msg += "获取通用唯一识别码发生错误。";
                return petId;
            }

            String imageUUID = (String) request.getSession().getAttribute("image" + petUUID);

            if (imageUUID != null && imageUUID.equals("") == false) {
                File fileOld = new File(path, imageUUID);

                if (fileOld.exists() == false || fileOld.isFile() == false) {
                    msg += "上传的文件已不存在。";
                    return petId;
                }

                int index = imageUUID.lastIndexOf(".");
                String nameExt = imageUUID.substring(index + 1);

                String imageNew = petId + "." + nameExt;
                File fileNew = new File(path, imageNew);

                if (fileNew.exists()) {
                    if (fileNew.delete() == false) {
                        msg += "删除旧文件失败。";
                        return petId;
                    }
                }

                if (fileOld.renameTo(fileNew) == false) {
                    msg += "文件重命名失败。";
                    return petId;
                }

                int count = petDao.editImage(request, imageNew, petId);

                if (count == 0) {
                    msg += "数据表中的宠物图片名称更新失败！";
                    return petId;
                }
            }

            msg += "新添记录成功。";
            request.getSession().setAttribute("msg", msg);
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

    // 辅助方法：同时支持从attribute和parameter获取值
    private String getRequestValue(HttpServletRequest request, String name) {
        // 先尝试从attribute获取（multipart表单）
        Object attrValue = request.getAttribute(name);
        if (attrValue != null) {
            return attrValue.toString();
        }
        // 再尝试从parameter获取（普通表单）
        return request.getParameter(name);
    }

    public boolean editPet(HttpServletRequest request) {

        String msg = "";

        try {
            String petId = getRequestValue(request, "petId");

            try {
                Integer.parseInt(petId);
            } catch (Exception e) {
                msg += "参数petId错误！";
                return false;
            }

            String petNo, petName, breedId, breedName, gender, age, weight, color, healthStatus, price, detail;

            petNo = getRequestValue(request, "petNo");
            petName = getRequestValue(request, "petName");
            breedId = getRequestValue(request, "breedId");
            gender = getRequestValue(request, "gender");
            age = getRequestValue(request, "age");
            weight = getRequestValue(request, "weight");
            color = getRequestValue(request, "color");
            healthStatus = getRequestValue(request, "healthStatus");
            price = getRequestValue(request, "price");
            detail = getRequestValue(request, "detail");

            if (petNo == null || petName == null || breedId == null || gender == null
                    || age == null || weight == null || color == null || healthStatus == null || price == null || detail == null) {
                msg = "输入不正确！";
                return false;
            }
            petNo = petNo.trim();
            petName = petName.trim();
            breedId = breedId.trim();
            gender = gender.trim();
            age = age.trim();
            weight = weight.trim();
            color = color.trim();
            healthStatus = healthStatus.trim();
            price = price.trim();
            detail = detail.trim();

            if (petName.equals("")) {
                msg += "请输入宠物名称。";
                return false;
            }

            if (petName.length() > 45) {
                msg += "宠物名称的字符数不能超过45。";
                return false;
            }

            if (petNo.equals("")) {
                msg += "请输入宠物编号。";
                return false;
            }

            if (petNo.length() > 45) {
                msg += "宠物编号的字符数不能超过45。";
                return false;
            }

            if (breedId.equals("")) {
                msg += "请选择宠物品种。";
                return false;
            }

            if (gender.equals("")) {
                msg += "请选择宠物性别。";
                return false;
            }

            if (age.equals("")) {
                msg += "请输入宠物年龄。";
                return false;
            }

            try {
                Integer.parseInt(age);
            } catch (Exception e) {
                msg += "请输入正确的年龄！";
                return false;
            }

            if (weight.equals("")) {
                msg += "请输入宠物体重。";
                return false;
            }

            try {
                Float.parseFloat(weight);
            } catch (Exception e) {
                msg += "请输入正确的体重！";
                return false;
            }

            if (color.equals("")) {
                msg += "请输入宠物颜色。";
                return false;
            }

            if (healthStatus.equals("")) {
                msg += "请选择健康状况。";
                return false;
            }

            if (price.equals("")) {
                msg += "请输入宠物价格。";
                return false;
            }

            try {
                Float.parseFloat(price);
            } catch (Exception e) {
                msg += "请输入正确的价格！";
                return false;
            }

            if (petDao.queryByPetId(request, petId) == null) {
                msg += "petId号对应的记录已不存在，请刷新页面后重试！";
                return false;
            }

            if (petDao.existByPetNoExptId(request, petNo, petId)) {
                msg += "所输入的宠物编号已经存在，请修改后再提交！";
                return false;
            }

            breedName = "待查询";
            dao.BreedDao breedDao = new dao.BreedDao();
            Breed breed = breedDao.queryByBreedId(request, breedId);

            if (breed == null) {
                msg += "宠物品种对应的记录已不存在，请刷新页面后重试！";
                return false;
            }
            breedName = breed.getBreedName();

            Pet pet = new Pet();

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
            pet.setDetail(detail);

            int count = petDao.editPet(request, pet);

            if (count == 0) {
                msg += "宠物信息修改失败！请重试。";
                return false;
            }

            msg += "宠物信息修改成功！";
            request.getSession().setAttribute("msg", msg);
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

    public boolean deleteByPetId(HttpServletRequest request) {

        String msg = "";

        try {
            String petId = request.getParameter("petId");

            try {
                Integer.parseInt(petId);
            } catch (Exception e) {
                msg += "参数petId错误！";
                return false;
            }

            Pet pet = petDao.queryByPetId(request, petId);

            if (pet == null) {
                msg += "petId号对应的记录已不存在，请刷新页面后重试！";
                return false;
            }

            boolean result = petDao.deleteByPetId(request, petId);

            if (result == false) {
                msg += "删除记录失败！请重试。";
                return false;
            }

            msg += "删除记录成功。";

            String path = request.getServletContext().getRealPath("\\") + "\\";
            String uploadFolder = "fileUpload\\petImage\\";
            path += uploadFolder;

            String image = pet.getImage();

            if (image == null || image.trim().equals("")) {
                return true;
            }

            File file = new File(path, image);

            if (file.exists()) {
                if (file.delete() == false) {
                    msg += "将文件" + image + "删除时失败。";
                    return false;
                }
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

            request.getSession().setAttribute("msg", msg);
        }

        return false;
    }

    public boolean deleteByPetIdLot(HttpServletRequest request, String[] petIdArray) {

        String msg = "";

        try {
            String path = request.getServletContext().getRealPath("\\") + "\\";
            String uploadFolder = "fileUpload\\petImage\\";
            path += uploadFolder;
            File file = null;
            Pet pet = null;
            String petId = "";

            String petIdLot = "";

            for (int i = 0; i < petIdArray.length; i++) {
                try {
                    petId = String.valueOf(Integer.parseInt(petIdArray[i]));
                } catch (Exception e) {
                    continue;
                }

                petIdLot += "," + petId;

                pet = petDao.queryByPetId(request, petId);

                if (pet == null) {
                    continue;
                }

                String image = pet.getImage();

                if (image == null || image.trim().equals("")) {
                    continue;
                }

                file = new File(path, image);

                if (file.exists()) {
                    if (file.delete() == false) {
                        msg += "将文件" + image + "删除时失败。";
                        continue;
                    }
                }
            }

            if (petIdLot.equals("")) {
                return false;
            }
            petIdLot = petIdLot.substring(1);

            boolean result = petDao.deleteByPetIdLot(request, petIdLot);

            if (result == false) {
                msg += "删除记录失败！请重试。";
                return false;
            }

            msg += "删除记录成功。";
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