package service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import bean.Breed;
import dao.BreedDao;

public class BreedService {

    BreedDao breedDao = new BreedDao();

    public boolean queryAll(HttpServletRequest request) {

        List<Breed> breedList = null;
        String search = "";
        int indexStart = 0;
        int pageShow = 1;
        String page = "";
        String msg = "";

        try {
            if (request.getParameter("buttonDelete") != null) {
                String[] breedIdArray = request.getParameterValues("breedId");

                if (breedIdArray != null) {
                    deleteByBreedIdLot(request, breedIdArray);
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

            int countRow = breedDao.queryCount(request, search);

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
                searchUrl = java.net.URLEncoder.encode(search, "UTF-8");
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
            page += "	<input type='text' name='pageShow' value='" + pageShow
                    + "' style='width:40px; text-align:center;'>";
            page += "	<input type='submit' name='buttonPage' value='提交'>&emsp;";

            if (pageShow > 0) {
                indexStart = (pageShow - 1) * pageSize;
            }

            breedList = breedDao.queryAll(request, search, indexStart, pageSize);

            if (breedList == null || breedList.size() == 0) {
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
            request.setAttribute("breedList", breedList);
        }

        return false;
    }

    public boolean queryAllForPET(HttpServletRequest request) {

        List<Breed> breedList = null;
        String msg = "";

        try {
            breedList = breedDao.queryAllForSelect(request);

            if (breedList == null || breedList.size() == 0) {
                msg += "（查无品种记录）";
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

            request.setAttribute("breedList", breedList);
        }

        return false;
    }

    public boolean queryByBreedId(HttpServletRequest request) {

        Breed breed = null;
        String msg = "";

        try {
            String breedId = request.getParameter("breedId");

            try {
                Integer.parseInt(breedId);
            } catch (Exception e) {
                msg += "参数breedId错误！";
                return false;
            }

            breed = breedDao.queryByBreedId(request, breedId);

            if (breed == null) {
                msg += "（查无此品种记录）";
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

            request.setAttribute("breed", breed);
        }

        return false;
    }

    public String addBreed(HttpServletRequest request) {

        String breedId = "0";
        String msg = "";

        try {
            String breedName, breedDesc;

            breedName = request.getParameter("breedName");
            breedDesc = request.getParameter("breedDesc");

            if (breedName == null || breedDesc == null) {
                msg = "输入不正确！";
                return breedId;
            }
            breedName = breedName.trim();
            breedDesc = breedDesc.trim();

            if (breedName.equals("")) {
                msg += "请输入品种名称。";
                return breedId;
            }

            if (breedName.length() > 45) {
                msg += "品种名称的字符数不能超过45。";
                return breedId;
            }

            if (breedDao.existByBreedName(request, breedName)) {
                msg += "所输入的品种名称已经存在，请修改后再提交！";
                return breedId;
            }

            Breed breed = new Breed();

            breed.setBreedName(breedName);
            breed.setBreedDesc(breedDesc);

            breedId = breedDao.addBreed(request, breed);

            if (breedId.equals("0")) {
                msg += "新添记录失败！请重试。";
                return breedId;
            }

            msg += "新添记录成功。";
            request.getSession().setAttribute("msg", msg);
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

    public boolean editBreed(HttpServletRequest request) {

        String msg = "";

        try {
            String breedId = request.getParameter("breedId");

            try {
                Integer.parseInt(breedId);
            } catch (Exception e) {
                msg += "参数breedId错误！";
                return false;
            }

            String breedName, breedDesc;

            breedName = request.getParameter("breedName");
            breedDesc = request.getParameter("breedDesc");

            if (breedName == null || breedDesc == null) {
                msg = "输入不正确！";
                return false;
            }
            breedName = breedName.trim();
            breedDesc = breedDesc.trim();

            if (breedName.equals("")) {
                msg += "请输入品种名称。";
                return false;
            }

            if (breedName.length() > 45) {
                msg += "品种名称的字符数不能超过45。";
                return false;
            }

            if (breedDao.queryByBreedId(request, breedId) == null) {
                msg += "breedId号对应的记录已不存在，请刷新页面后重试！";
                return false;
            }

            if (breedDao.existByBreedNameExptId(request, breedName, breedId)) {
                msg += "所输入的品种名称已经存在，请修改后再提交！";
                return false;
            }

            Breed breed = new Breed();

            breed.setBreedId(breedId);
            breed.setBreedName(breedName);
            breed.setBreedDesc(breedDesc);

            int count = breedDao.editBreed(request, breed);

            if (count == 0) {
                msg += "品种信息修改失败！请重试。";
                return false;
            }

            msg += "品种信息修改成功！";
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

    public boolean deleteByBreedId(HttpServletRequest request) {

        String msg = "";

        try {
            String breedId = request.getParameter("breedId");

            try {
                Integer.parseInt(breedId);
            } catch (Exception e) {
                msg += "参数breedId错误！";
                return false;
            }

            Breed breed = breedDao.queryByBreedId(request, breedId);

            if (breed == null) {
                msg += "breedId号对应的记录已不存在，请刷新页面后重试！";
                return false;
            }

            if (breedDao.existByBreedId(request, breedId)) {
                msg += "该品种下还有宠物记录，无法删除！";
                return false;
            }

            boolean result = breedDao.deleteByBreedId(request, breedId);

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

            request.getSession().setAttribute("msg", msg);
        }

        return false;
    }

    public boolean deleteByBreedIdLot(HttpServletRequest request, String[] breedIdArray) {

        String msg = "";

        try {
            String breedId = "";
            String breedIdLot = "";

            for (int i = 0; i < breedIdArray.length; i++) {
                try {
                    breedId = String.valueOf(Integer.parseInt(breedIdArray[i]));
                } catch (Exception e) {
                    continue;
                }

                if (breedDao.existByBreedId(request, breedId)) {
                    msg += "品种ID " + breedId + " 下还有宠物记录，无法删除！";
                    continue;
                }

                breedIdLot += "," + breedId;
            }

            if (breedIdLot.equals("")) {
                return false;
            }
            breedIdLot = breedIdLot.substring(1);

            boolean result = breedDao.deleteByBreedIdLot(request, breedIdLot);

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