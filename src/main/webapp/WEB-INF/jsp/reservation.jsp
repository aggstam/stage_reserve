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
    <script src="/resources/js/autoresize.js"></script>
    <script src="/resources/js/reservation.js"></script>
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
                <h1>Reservation</h1>
            </div>
        </div>

        <div class="album py-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <img src="/resources/images/stages/${reservation.stage.id}/${reservation.stage.image}" width="100%" height="400" class="listing-image">
                    </div>
                    <div class="details col-md-8">
                        <h2>Event: ${reservation.event}</h2>
                        <p><strong>Reservation ID: </strong>${reservation.id}</p>
                        <p><strong>Stage: </strong><a class="redirect-link2" href="/stage/${reservation.stage.id}">${reservation.stage.name}</a></p>
                        <p>
                            <strong>Reserved from: </strong>
                            <fmt:parseDate value="${reservation.reserveFrom}" pattern="yyyy-MM-dd HH:mm" var="reserveFrom"/>
                            <fmt:formatDate value="${reserveFrom}" pattern="yyyy-MM-dd HH:mm"/>
                        </p>
                        <p>
                            <strong>Reserved to: </strong>
                            <fmt:parseDate value="${reservation.reserveTo}" pattern="yyyy-MM-dd HH:mm" var="reserveTo"/>
                            <fmt:formatDate value="${reserveTo}" pattern="yyyy-MM-dd HH:mm"/>
                        </p>
                        <p><strong>Capacity reached: </strong>${capacityRate}%</p>
                        <p><strong>Attended: </strong>${reservation.attendees.size()}</p>
                        <p><strong>Attendees: </strong></p>
                        <p>
                            <ul class="list-group">
                                <c:forEach var="attendee" items="${reservation.attendees}">
                                    <li class="list-group-item">
                                            ${attendee.user.email},
                                            <fmt:parseDate value="${attendee.timestamp}" pattern="yyyy-MM-dd HH:mm" var="timestamp"/>
                                            <fmt:formatDate value="${timestamp}" pattern="yyyy-MM-dd HH:mm"/>
                                    </li>
                                </c:forEach>
                            </ul>
                        </p>
                        <c:if test="${isActive}">
                            <button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#inviteModal">Invite</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary cancel-button" data-toggle="modal" data-target="#deleteModal">Cancel</button>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${isActive}">
            <div id="deleteModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <form class="modal-content" action="/reservation/delete/${reservation.id}" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title">Cancel Reservation</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to cancel your reservation?</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-sm btn-outline-secondary cancel-button" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-sm btn-outline-secondary">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div id="inviteModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <form class="modal-content" action="/reservation/invite/${reservation.id}" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title">Invite attendees</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="invites" class="col-form-label">Emails (separated by comma)</label>
                                    <textarea  class="form-input" name="invites" id="invites"></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-sm btn-outline-secondary cancel-button" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-sm btn-outline-secondary">Invite</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:if>
    </main>

</body>
</html>
