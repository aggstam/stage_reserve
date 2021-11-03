
$(document).ready(function(){

    $('.addButton').click(function(){
        $('#modalTitle').text('Add User');
        $('#submitButton').text('Add');
        $('#userForm').attr('action', '/users');
        $('#email').val("");
        $('#password').val("");
        $('#name').val("");
        $('#surname').val("");
        $('#phone').val("");
        $('#file').val("");
        $('#management').prop("checked", false);
        $('#users').prop("checked", false);
    });

    $('.editButton').click(function(){
        $('#modalTitle').text('Edit User');
        $('#submitButton').text('Edit');
        $('#userForm').attr('action', '/users/' + $(this).parents('tr').find('td:eq(0)').html());
        $('#email').val($(this).parents('tr').find('td:eq(1)').html());
        $('#password').val("");
        $('#name').val($(this).parents('tr').find('td:eq(3)').html());
        $('#surname').val($(this).parents('tr').find('td:eq(4)').html());
        $('#phone').val($(this).parents('tr').find('td:eq(5)').html());
        $('#file').val("");
        if ($(this).parents('tr').find('td:eq(6)').html().includes("check")) {
            $('#management').prop("checked", true);
        } else {
            $('#management').prop("checked", false);
        }
        if ($(this).parents('tr').find('td:eq(7)').html().includes("check")) {
            $('#users').prop("checked", true);
        } else {
            $('#users').prop("checked", false);
        }
    });

    $('.deleteButton').click(function(){
        $('#deleteForm').attr('action', '/users/delete/' + $(this).parents('tr').find('td:eq(0)').html());
    });

    $('.searchInput').keyup(function(){
        let value = $(this).val().toLowerCase();
        $("#usersTable tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });

});
