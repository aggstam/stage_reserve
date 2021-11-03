
function googleLogin() {
    const clientId = '270385615545-mabca4srlm4lnoash4vdlhdcgp6pnk6i.apps.googleusercontent.com';
    // const redirectUrl = 'http://localhost:8080/oauth_callback';
    const redirectUrl = 'http://safeshopping.ddns.net/oauth_callback';
    const requestParams = 'scope=https://www.googleapis.com/auth/userinfo.email&state=try_sample_request&include_granted_scopes=true&response_type=token&redirect_uri=' + redirectUrl + '&client_id=' + clientId;
    window.location.href = 'https://accounts.google.com/o/oauth2/v2/auth?' + requestParams;
}
