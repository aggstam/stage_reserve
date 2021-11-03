<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Stage Reserve</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/resources/css/utils.css">
    <script src="/resources/js/utils.js"></script>
    <script src="/resources/js/home.js"></script>
</head>
<body>

    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
        <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="navbar-collapse collapse" id="navbarCollapse" style="">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item"><a class="nav-link" href="/home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="/checkin">Check in</a></li>
                <li class="nav-item active"><a class="nav-link" href="/reservations">My Reservations</a></li>
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

    <main role="main" class="container mw-100">
        <div class="jumbotron text-center header-section">
            <div class="container">
                <h1>Reservations</h1>
                <input type="text" class="searchInput" placeholder="Search"/>
            </div>
        </div>

        <div class="album py-5">
            <div class="container">
                <div class="row">
                    <c:forEach  var="reservation" items="${reservations}">
                        <div class="col-md-4">
                            <div class="card mb-4 shadow-sm">
                                <img src="/resources/images/stages/${reservation.stage.id}/${reservation.stage.image}" width="100%" height="400">
                                <div class="card-body">
                                    <p class="card-text text-center">${reservation.event} @ ${reservation.stage.name}</p>
                                    <p class="card-text text-center">
                                        <fmt:parseDate value="${reservation.reserveFrom}" pattern="yyyy-MM-dd HH:mm" var="reserveFrom"/>
                                        <fmt:formatDate value="${reserveFrom}" pattern="yyyy-MM-dd HH:mm"/>
                                        ->
                                        <fmt:parseDate value="${reservation.reserveTo}" pattern="yyyy-MM-dd HH:mm" var="reserveTo"/>
                                        <fmt:formatDate value="${reserveTo}" pattern="yyyy-MM-dd HH:mm"/>
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-sm btn-outline-secondary" onClick="location.href = '/reservation/${reservation.id}'">View</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:forEach  var="pastReservation" items="${pastReservations}">
                        <div class="col-md-4">
                            <div class="card mb-4 shadow-sm">
                                <img class="card-img" src="/resources/images/stages/${pastReservation.stage.id}/${pastReservation.stage.image}" width="100%" height="400" style="opacity: 0.5";>
                                <div class="card-img-overlay text-center">
                                    <h5 class="card-title">Reservation Concluded</h5>
                                </div>
                                <div class="card-body">
                                    <p class="card-text text-center">${pastReservation.event} @ ${pastReservation.stage.name}</p>
                                    <p class="card-text text-center">
                                        <fmt:parseDate value="${pastReservation.reserveFrom}" pattern="yyyy-MM-dd HH:mm" var="reserveFrom"/>
                                        <fmt:formatDate value="${reserveFrom}" pattern="yyyy-MM-dd HH:mm"/>
                                        ->
                                        <fmt:parseDate value="${pastReservation.reserveTo}" pattern="yyyy-MM-dd HH:mm" var="reserveTo"/>
                                        <fmt:formatDate value="${reserveTo}" pattern="yyyy-MM-dd HH:mm"/>
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-sm btn-outline-secondary" onClick="location.href = '/reservation/${pastReservation.id}'">View</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>

</body>
</html>
