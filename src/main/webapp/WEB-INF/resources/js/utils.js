
function openModal(id) {
    document.getElementById(id).style.display='block'
}

function closeModal(id) {
    document.getElementById(id).style.display='none';
}

function logout() {
    let form = $('<form action="/logout" method="post"></form>');
    $('body').append(form);
    form.submit();
}
