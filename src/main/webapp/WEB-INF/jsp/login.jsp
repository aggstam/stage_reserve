<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Stage Reserve Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/login.css">
    <script src="/resources/js/utils.js"></script>
    <script src="/resources/js/login.js"></script>
</head>
<body>

    <main role="main" class="container">
        <form:form class="modal-content animate" modelAttribute="loginForm" action="/login" method="post">
            <div class="img-container">
                <img src="/resources/images/stage_reserve_logo.png" class="login-img">
            </div>
            <div class="info-container">
                <label><b>Email</b></label>
                <form:input path="loginEmail" type="email" placeholder="Enter Email" name="email" minlength="6" maxlength="50" required="true"/>
                <label><b>Password</b></label>
                <form:input path="loginPassword" type="password" placeholder="Enter Password" name="password" minlength="8" maxlength="20" required="true"/>
                <span class="error-message">${loginForm.errorMessage}</span>
                <button type="submit" class="form-button">Login</button>
            </div>
            <div class="info-container" style="background-color:#848B8C">
                <p>New User? You can sign up by clicking here: <a href="javascript:openModal('signupModal')" class="sign-up-text">Sign Up</a></p>
                <p>You can also login using your Google account by clicking here: <a href="javascript:googleLogin()" class="sign-up-text"><i class="google-icon"></i></a></p>
            </div>
        </form:form>

        <div id="signupModal" class="modal sign-up-modal">
            <form:form class="signup-modal modal-content" modelAttribute="userForm" action="/signup" method="post" enctype="multipart/form-data">
                <div class="info-container sign-up-container">
                    <h1>Sign Up</h1>
                    <p>Please fill in this form to create an account.</p>
                    <hr>
                    <label><b>Email</b></label>
                    <form:input path="email" type="email" placeholder="Enter Email" name="email" minlength="4" maxlength="50" required="true"/>
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
                    <div class="clearfix">
                        <button type="button" onclick="closeModal('signupModal')" class="form-button cancel-button">Cancel</button>
                        <button type="submit" class="form-button signup-button">Sign Up</button>
                    </div>
                </div>
            </form:form>
        </div>
    </main>

</body>
</html>