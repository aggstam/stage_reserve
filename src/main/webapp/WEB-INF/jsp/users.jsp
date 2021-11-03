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
    <link rel="stylesheet" href="/resources/css/utils.css">
    <script src="/resources/js/utils.js"></script>
    <script src="/resources/js/users.js"></script>
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
                    <li class="nav-item active"><a class="nav-link" href="/users">Users</a></li>
                </c:if>
            </ul>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="/profile">Welcome ${user.name}! <i class="fa fa-fw fa-user"></i></a></li>
                <li class="nav-item"> <a class="nav-link" href="javascript:logout()"><i class="fa fa-fw fa-sign-out"></i></a></li>
            </ul>
        </div>
    </nav>

    <main role="main" class="container mw-100">
        <div class="jumbotron text-center header-section">
            <div class="container">
                <h1>User Management  <button type="button" class="btn btn-sm btn-outline-secondary addButton" data-toggle="modal" data-target="#userModal">Add</button></h1>
                <input type="text" class="searchInput" placeholder="Search"/>
            </div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Email</th>
                        <th>Password</th>
                        <th>Name</th>
                        <th>Surname</th>
                        <th>Phone</th>
                        <th>Management</th>
                        <th>Users</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="usersTable">
                    <c:forEach  var="u" items="${users}">
                        <tr>
                            <td>${u.id}</td>
                            <td>${u.email}</td>
                            <td>**********</td>
                            <td>${u.name}</td>
                            <td>${u.surname}</td>
                            <td>${u.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.management}">
                                        <i class="fa fa-fw fa-check"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa fa-fw fa-times"></i>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.users}">
                                        <i class="fa fa-fw fa-check"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa fa-fw fa-times"></i>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button type="button" class="btn btn-sm btn-outline-secondary editButton" data-toggle="modal" data-target="#userModal">Edit</button>
                                <button type="button" class="btn btn-sm btn-outline-secondary cancel-button deleteButton" data-toggle="modal" data-target="#deleteModal">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div id="userModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form:form id="userForm" class="modal-content" modelAttribute="userForm" action="/users" method="post" enctype="multipart/form-data">
                        <div class="modal-header">
                            <h5 id="modalTitle" class="modal-title">Add User</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="email" class="col-form-label">Email</label>
                                <form:input path="email" type="email" class="form-input" placeholder="Enter Email" id="email" minlength="4" maxlength="50" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="password" class="col-form-label">Password</label>
                                <form:input path="password" type="password" class="form-input" placeholder="Enter Password" id="password" minlength="4" maxlength="20" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="name" class="col-form-label">Name</label>
                                <form:input path="name" type="text" class="form-input" placeholder="Enter Name" id="name" minlength="2" maxlength="20" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="surname" class="col-form-label">Surname</label>
                                <form:input path="surname" type="text" class="form-input" placeholder="Enter Surname" id="surname" minlength="2" maxlength="20" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="phone" class="col-form-label">Phone</label>
                                <form:input path="phone" type="tel" class="form-input" placeholder="Enter Phone (69********)" id="phone" pattern="69[0-9]{8}" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="image" class="col-form-label">Image</label>
                                <form:input path="file" type="file" class="form-input" id="image" size="5" accept=".png,.jpg"/>
                            </div>
                            <div class="form-group">
                                <label for="management" class="col-form-label">Management</label>
                                <form:checkbox path="management" class="form-input custom-checkbox" id="management"/>
                            </div>
                            <div class="form-group">
                                <label for="users" class="col-form-label">Users</label>
                                <form:checkbox path="users" class="form-input custom-checkbox" id="users"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-sm btn-outline-secondary cancel-button" data-dismiss="modal">Close</button>
                            <button id="submitButton" type="submit" class="btn btn-sm btn-outline-secondary">Add</button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>

        <div id="deleteModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form id="deleteForm" class="modal-content" action="/users/delete/" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title">Delete User</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to permanently remove the user?</p>
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
