<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${ param.pageTitle } | Javaメニュー</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="format-detection" content="telephone=no">
  <meta name="theme-color" content="#658B3D">
  <!--webフォント-->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sanitize.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css"> --%>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/${ param.css }">
  <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/image/apple-touch-icon.png">
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/image/favicon.ico" type="image/vnd.microsoft.icon">