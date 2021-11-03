
$(document).ready(function(){

    let access_token = new URLSearchParams(location.hash.substring(1)).get('access_token');
    if (access_token === undefined) {
        alert('User was not authenticated! Redirecting to login page...');
        window.location.href = '/';
    } else {
        let url = 'https://www.googleapis.com/oauth2/v2/userinfo?access_token=' + access_token;
        fetch(url)
            .then((response) => response.json())
            .then((responseJson) => {
                console.log(responseJson);
                $('#email').val(String(responseJson.email));
                $('#name').val(String(responseJson.name));
                $('#surname').val(String(responseJson.given_name));
                $('#image').val(String(responseJson.picture));
                $('#submitForm').submit();
            })
            .catch((error) => {
                console.error(error);
                alert('Error while retrieving user data! Redirecting to login page...');
                window.location.href = '/';
            });
    }

});
