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

@WebServlet("/PetImageUploadDo")
public class PetImageUploadDo extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 权限检查
        if (!util.AuthUtil.requireUserOrAdmin(request, response)) {
            return;
        }

        String msg = "";
        String url = "";

        try {
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);

            if (isMultipart == false) {
                msg = "请上传文件！";
                url = "PetImageUpload";
                return;
            }

            String path = request.getServletContext().getRealPath("\\") + "\\";
            String uploadFolder = "fileUpload\\petImage\\";
            path += uploadFolder;

            File folder = new File(path);
            if (folder.exists() == false) {
                folder.mkdirs();
            }

            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);

            List<FileItem> items = upload.parseRequest(request);

            String petUUID = "";
            String fileName = "";

            for (FileItem item : items) {
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    String value = item.getString("UTF-8");

                    if (name.equals("petUUID")) {
                        petUUID = value;
                    }
                } else {
                    fileName = item.getName();

                    if (fileName == null || fileName.equals("")) {
                        continue;
                    }

                    fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);

                    String ext = fileName.substring(fileName.lastIndexOf(".") + 1);

                    if (ext.equalsIgnoreCase("jpg") == false && ext.equalsIgnoreCase("jpeg") == false
                            && ext.equalsIgnoreCase("png") == false && ext.equalsIgnoreCase("gif") == false) {
                        msg = "只支持jpg、jpeg、png、gif格式的图片！";
                        url = "PetImageUpload?petUUID=" + petUUID;
                        return;
                    }

                    String newFileName = java.util.UUID.randomUUID().toString() + "." + ext;

                    File file = new File(path, newFileName);
                    item.write(file);

                    request.getSession().setAttribute("image" + petUUID, newFileName);
                }
            }

            url = "PetImageUpload?petUUID=" + petUUID;

        } catch (Exception e) {
            msg += "系统发生错误。";
            e.printStackTrace();
        } finally {
            if (request.getAttribute("msg") != null) {
                msg += request.getAttribute("msg").toString();
            }
            request.setAttribute("msg", msg);

            response.sendRedirect(url);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}