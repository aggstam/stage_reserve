<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Stage Reserve</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/resources/css/login.css">
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
                <li class="nav-item active"><a class="nav-link" href="/profile">Welcome ${user.name}! <i class="fa fa-fw fa-user"></i></a></li>
                <li class="nav-item"><a class="nav-link" href="javascript:logout()"><i class="fa fa-fw fa-sign-out"></i></a></li>
            </ul>
        </div>
    </nav>

    <main role="main" class="container">
        <form:form class="modal-content animate" modelAttribute="userForm" action="/profile" method="post" enctype="multipart/form-data">
            <div class="img-container">
                <c:choose>
                    <c:when test="${not empty user.image}">
                        <img src="${user.image}" alt="Avatar" class="avatar">
                    </c:when>
                    <c:otherwise>
                        <img src="/resources/images/profile_picture.png" alt="Avatar" class="avatar">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="info-container">
                <p><b>Update your account information:</b></p>
                <label><b>Email</b></label>
                <form:input path="email" type="email" name="email" minlength="4" maxlength="50" readonly="true"/>
                <label><b>Password</b></label>
                <form:input path="password" type="password" placeholder="Enter Password" name="password" minlength="4" maxlength="20" required="true"/>
                <label><b>Name</b></label>
                <form:input path="name" type="text" placeholder="Enter Name" name="name" minlength="2" maxlength="20" required="true"/>
                <label><b>Surname</b></label>
                <form:input path="surname" type="text" placeholder="Enter Surname" name="surname" minlength="2" maxlength="20" required="true"/>
                <label><b>Phone</b></label>
                <form:input path="phone" type="tel" placeholder="Enter Phone (69********)" name="phone" pattern="69[0-9]{8}" required="true"/>
                <label><b>Image</b></label>
                <form:input path="file" type="file" size="5" accept=".png,.jpg" required="true"/>
                <button type="submit" class="form-button">Save changes</button>
            </div>
        </form:form>
    </main>

</body>
</html>
