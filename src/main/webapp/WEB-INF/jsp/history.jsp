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
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/resources/css/utils.css">
    <script src="/resources/js/utils.js"></script>
    <script src="/resources/js/history.js"></script>
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
                    <li class="nav-item active"><a class="nav-link" href="/history">History</a></li>
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
                <h1>Reservations History</h1>
                <input type="text" class="searchInput" placeholder="Search"/>
            </div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Stage</th>
                        <th>User</th>
                        <th>Event</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Rate</th>
                        <th>Attended</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="reservationsTable">
                    <c:forEach  var="reservation" items="${reservations}">
                        <tr>
                            <td>${reservation.id}</td>
                            <td>${reservation.stage.name}</td>
                            <td>${reservation.createdBy.email}</td>
                            <td>${reservation.event}</td>
                            <td>
                                <fmt:parseDate value="${reservation.reserveFrom}" pattern="yyyy-MM-dd HH:mm" var="reserveFrom"/>
                                <fmt:formatDate value="${reserveFrom}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                            <td>
                                <fmt:parseDate value="${reservation.reserveTo}" pattern="yyyy-MM-dd HH:mm" var="reserveTo"/>
                                <fmt:formatDate value="${reserveTo}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                            <td>${capacityRateMap[reservation.id]}</td>
                            <td>${reservation.attendees.size()}</td>
                            <td>
                                <button type="button" class="btn btn-sm btn-outline-secondary cancel-button" data-toggle="modal" data-target="#deleteModal">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div id="deleteModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form id="deleteForm" class="modal-content" action="/history/delete/" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title">Delete Reservation</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to delete the reservation?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-sm btn-outline-secondary cancel-button" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-sm btn-outline-secondary">Delete</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

</body>
</html>
