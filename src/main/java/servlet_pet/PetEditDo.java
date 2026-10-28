package servlet_pet;

import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import service.PetService;

@WebServlet("/PetEditDo")
public class PetEditDo extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        java.io.PrintWriter out = response.getWriter();

        // 权限检查
        if (!util.AuthUtil.requireUserOrAdmin(request, response)) {
            return;
        }

        String msg = "";
        String url = "";

        try {
            // 检查是否为multipart请求
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            
            if (isMultipart) {
                // 处理multipart表单数据
                handleMultipartRequest(request, response);
                return;
            } else {
                PetService petService = new PetService();
                boolean result = petService.editPet(request);

                if (result) {
                    String petId = request.getParameter("petId");
                    url = "PetShow?petId=" + petId;
                } else {
                    if (request.getAttribute("msg") != null) {
                        msg = request.getAttribute("msg").toString();
                    } else {
                        msg = "修改失败！";
                    }
                }
            }

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (!url.equals("")) {
                out.print(url);
            } else if (!msg.equals("")) {
                out.print(msg);
            }
        }
    }
    
    private void handleMultipartRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        java.io.PrintWriter out = response.getWriter();
        String msg = "";
        String url = "";
        String petId = "";
        
        try {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(request);
            
            String petNo = "", petName = "", breedId = "", gender = "", age = "", 
                   weight = "", color = "", healthStatus = "", price = "", detail = "";
            FileItem imageFile = null;
            
            // 解析表单字段
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString("UTF-8");
                    
                    switch (fieldName) {
                        case "petId": petId = fieldValue; break;
                        case "petNo": petNo = fieldValue; break;
                        case "petName": petName = fieldValue; break;
                        case "breedId": breedId = fieldValue; break;
                        case "gender": gender = fieldValue; break;
                        case "age": age = fieldValue; break;
                        case "weight": weight = fieldValue; break;
                        case "color": color = fieldValue; break;
                        case "healthStatus": healthStatus = fieldValue; break;
                        case "price": price = fieldValue; break;
                        case "detail": detail = fieldValue; break;
                    }
                } else if (item.getFieldName().equals("image")) {
                    // 保存图片文件项
                    if (item.getName() != null && !item.getName().equals("")) {
                        imageFile = item;
                    }
                }
            }
            
            // 设置request参数以便PetService处理
            request.setAttribute("petId", petId);
            request.setAttribute("petNo", petNo);
            request.setAttribute("petName", petName);
            request.setAttribute("breedId", breedId);
            request.setAttribute("gender", gender);
            request.setAttribute("age", age);
            request.setAttribute("weight", weight);
            request.setAttribute("color", color);
            request.setAttribute("healthStatus", healthStatus);
            request.setAttribute("price", price);
            request.setAttribute("detail", detail);
            
            // 处理图片上传（如果有新图片）
            if (imageFile != null) {
                String path = request.getServletContext().getRealPath("\\") + "\\";
                String uploadFolder = "fileUpload\\petImage\\";
                path += uploadFolder;
                
                File folder = new File(path);
                if (!folder.exists()) {
                    folder.mkdirs();
                }
                
                String fileName = imageFile.getName();
                fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
                
                if (ext.equalsIgnoreCase("jpg") || ext.equalsIgnoreCase("jpeg") ||
                    ext.equalsIgnoreCase("png") || ext.equalsIgnoreCase("gif")) {
                    
                    // 直接使用petId作为文件名
                    String newFileName = petId + "." + ext;
                    File file = new File(path, newFileName);
                    
                    // 删除旧文件
                    if (file.exists()) {
                        file.delete();
                    }
                    
                    imageFile.write(file);
                    
                    // 更新数据库中的图片名称
                    dao.PetDao petDao = new dao.PetDao();
                    petDao.editImage(request, newFileName, petId);
                }
            }
            
            // 调用Service处理
            PetService petService = new PetService();
            boolean result = petService.editPet(request);
            
            if (result) {
                url = "PetShow?petId=" + petId;
            } else {
                if (request.getAttribute("msg") != null) {
                    msg = request.getAttribute("msg").toString();
                } else {
                    msg = "修改失败！";
                }
            }
            
        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (!url.equals("")) {
                out.print(url);
            } else if (!msg.equals("")) {
                out.print(msg);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}