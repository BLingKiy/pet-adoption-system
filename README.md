# 宠物领养与商城管理系统

基于 Java Servlet + JSP + MySQL 的宠物领养/交易管理网站，前台供游客浏览与下单，后台完成用户、宠物、品种、订单的完整管理。

## 功能

**前台（游客 / 用户）**
- 游客浏览宠物列表与详情
- 注册 / 登录（图形验证码校验）
- 购物车：加入、修改数量、删除
- 下单与订单查询、订单详情

**后台（管理）**
- 用户管理：列表、新增、编辑、查看
- 宠物管理：列表、新增、编辑、详情、**图片上传**
- 品种管理：列表、新增、编辑、详情
- 订单管理：列表、新增、编辑、详情、订单处理
- 数据导入导出（`webapp/data_数据导入导出/` 内含 MySQL 导出脚本）

## 技术栈

| 层次 | 技术 |
|---|---|
| 后端 | Java Servlet、JSP、JDBC |
| 数据库 | MySQL 8（`mysql-connector-java-8.0.26.jar`） |
| 容器 | Tomcat（Servlet 3.x+） |
| 分层 | `bean`（实体）/ `dao`（数据访问）/ `service`（业务）/ `servlet_*`（控制器）/ `util`（工具） |
| 前端 | JSP + CSS + JS，UEditor 富文本编辑器 |
| 安全相关 | `PreparedStatement` 防 SQL 注入、MD5 处理口令、图形验证码、Session 登录校验 |
| 文件处理 | `commons-fileupload` 图片上传 |

## 目录结构

```
src/main/java/
├── bean/               实体类（6）
├── dao/                数据访问对象（7）
├── service/            业务逻辑（6）
├── servlet_user/       用户控制器（9）
├── servlet_pet/        宠物控制器（9）
├── servlet_order/      订单控制器（8）
├── servlet_breed/      品种控制器（7）
├── servlet_cart/       购物车控制器（4）
├── servlet_guest/      游客浏览（2）
├── servlet_login/      登录（2）
├── servlet_verifyCode/ 验证码（1）
└── util/               工具类（3）
src/main/webapp/
├── index.jsp  login.jsp  main.jsp  header.jsp  footer.jsp
├── user/ pet/ breed/ order/ cart/ guest/      功能页面（28 个 JSP）
├── css/ js/ image/                           静态资源
├── UEditor/                                  富文本编辑器
├── WEB-INF/lib/                              依赖 jar
└── data_数据导入导出/                          MySQL 脚本
```

规模：64 个 Java 类（约 8,500 行）+ 28 个 JSP（约 4,900 行）。

## 配置与运行

1. **建库**：用 `src/main/webapp/data_数据导入导出/` 下的 SQL 脚本创建数据库与表
2. **配置连接**：复制 `db.properties.example` 为 `db.properties`，填入自己的库名、账号与口令

```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/pet_db?useSSL=false&serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=utf-8
db.username=root
db.password=YOUR_DB_PASSWORD
```

   > `db.properties` 已被 `.gitignore` 排除，**不会进仓库**。可放在项目根目录或 `src/main/webapp/WEB-INF/` 下；也支持环境变量 `DB_USERNAME` / `DB_PASSWORD`。
3. **部署**：将工程部署到 Tomcat（IDEA 中配置 Tomcat Server，Deployment 选本工程），启动后访问 `http://localhost:8080/<上下文路径>/`
4. **依赖**：`src/main/webapp/WEB-INF/lib/` 已包含 MySQL 驱动与上传组件，无需额外下载

## 说明

- `Db` 工具类统一封装连接的获取与释放，并集中执行查询/更新，所有 SQL 均使用 `PreparedStatement` 参数绑定。
- 验证码由 `util` 中的工具类生成，登录时与 Session 中的值比对。
- 图片上传目录与静态资源路径按 Tomcat 上下文相对路径配置。
