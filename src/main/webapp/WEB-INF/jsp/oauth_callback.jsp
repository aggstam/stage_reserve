<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<head>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="/resources/js/oauth_callback.js"></script>
</head>
<body>

    Redirecting...
    <div style="display: none;">
        <form:form id="submitForm" modelAttribute="userForm" action="/oauth_callback" method="post">
            <form:input path="email" type="email" id="email"/>
            <form:input path="name" type="text" id="name"/>
            <form:input path="surname" type="text" id="surname"/>
            <form:input path="image" type="text" id="image"/>
        </form:form>
    </div>

</body>
</html>
