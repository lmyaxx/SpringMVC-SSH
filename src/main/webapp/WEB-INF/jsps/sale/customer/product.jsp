<%--
  Created by IntelliJ IDEA.
  User: zhj
  Date: 2018/6/23
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/sale/addProductToCart" method="post">
    <table>
        <tr>
            <td>${product.name}</td>
        </tr>
    </table>
    <input type="hidden" value="${product.id}" name="productId">
    购买数量：<input type="text" name="num">
    提交：<input type="submit" value="提交">
</form>
</body>
</html>
