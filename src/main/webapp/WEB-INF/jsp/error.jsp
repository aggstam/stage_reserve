<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Stage Reserve</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/resources/css/error.css">
    <script src="/resources/js/utils.js"></script>
</head>
<body>

    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
        <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="navbar-collapse collapse" id="navbarCollapse" style="">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item"><a class="nav-link" href="/home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="/checkin">Check in</a></li>
                <li class="nav-item"><a class="nav-link" href="/reservations">My Reservations</a></li>
                <c:if test="${user.management}">
                    <li class="nav-item"><a class="nav-link" href="/stagesManagement">Stages</a></li>
                    <li class="nav-item"><a class="nav-link" href="/history">History</a></li>
                </c:if>
                <c:if test="${user.users}">
                    <li class="nav-item"><a class="nav-link" href="/users">Users</a></li>
                </c:if>
            </ul>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="/profile">Welcome ${user.name}! <i class="fa fa-fw fa-user"></i></a></li>
                <li class="nav-item"><a class="nav-link" href="javascript:logout()"><i class="fa fa-fw fa-sign-out"></i></a></li>
            </ul>
        </div>
    </nav>

    <div class="wrapper">
        <div class="box">
            <h1>500</h1>
            <p>Sorry, it's me, not you.</p>
            <p>&#58;&#40;</p>
        </div>
    </div>

</body>
</html>
