<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Stage Reserve</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" href="/resources/css/utils.css">
    <script src="/resources/js/utils.js"></script>
    <script src="/resources/js/stage.js"></script>
    <script src="/resources/js/autoresize.js"></script>
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

    <main role="main" class="container mw-100">
        <div class="jumbotron text-center header-section">
            <div class="container">
                <h1>Stage</h1>
            </div>
        </div>

        <div class="album py-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <img src="/resources/images/stages/${stage.id}/${stage.image}" width="100%" height="400" class="listing-image">
                    </div>
                    <div class="details col-md-8">
                        <h2>Name: ${stage.name}</h2>
                        <p><strong>Description: </strong>${stage.description}</p>
                        <p><strong>Capacity: </strong>${stage.capacity}</p>
                        <p><strong>Reservations: </strong></p>
                        <p>
                            <ul class="list-group">
                                <c:forEach var="reservation" items="${reservations}">
                                    <li class="list-group-item">
                                        <a class="redirect-link" href="/checkin?code=${reservation.id}">${reservation.event}:</a>
                                        <fmt:parseDate value="${reservation.reserveFrom}" pattern="yyyy-MM-dd HH:mm" var="reserveFrom"/>
                                        <fmt:formatDate value="${reserveFrom}" pattern="yyyy-MM-dd HH:mm"/>
                                        ->
                                        <fmt:parseDate value="${reservation.reserveTo}" pattern="yyyy-MM-dd HH:mm" var="reserveTo"/>
                                        <fmt:formatDate value="${reserveTo}" pattern="yyyy-MM-dd HH:mm"/>
                                    </li>
                                </c:forEach>
                            </ul>
                        </p>
                        <button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#reservationModal">Make reservation</button>
                    </div>
                </div>
            </div>
        </div>

        <div id="reservationModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form:form class="modal-content" modelAttribute="reservationForm" action="/stage/makeReservation/${stage.id}" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title">Reservation</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="event" class="col-form-label">Name</label>
                                <form:input path="event" type="text" class="form-input" placeholder="Enter Event" id="event" minlength="2" maxlength="20" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="datesTimeString" class="col-form-label">Date Rage</label>
                                <form:input path="datesTimeString" type="text" class="form-input" name="datesTimeString" id="datesTimeString" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="invites" class="col-form-label">Invite (emails separated by comma)</label>
                                <form:textarea  path="invites" class="form-input" id="invites"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-sm btn-outline-secondary cancel-button" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-sm btn-outline-secondary">Make</button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </main>

</body>
</html>
