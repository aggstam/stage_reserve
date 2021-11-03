
$(document).ready(function(){

    $('.addButton').click(function(){
        $('#modalTitle').text('Add Stage');
        $('#submitButton').text('Add');
        $('#stageForm').attr('action', '/stagesManagement');
        $('#name').val("");
        $('#description').val("");
        $('#capacity').val("");
        $('#active').prop("checked", false);
        $('#file').val("");
    });

    $('.editButton').click(function(){
        $('#modalTitle').text('Edit Stage');
        $('#submitButton').text('Edit');
        $('#stageForm').attr('action', '/stagesManagement/' + $(this).parents('tr').find('td:eq(0)').html());
        $('#name').val($(this).parents('tr').find('td:eq(1)').html());
        $('#description').val($(this).parents('tr').find('td:eq(2)').html());
        $('#capacity').val($(this).parents('tr').find('td:eq(3)').html());
        if ($(this).parents('tr').find('td:eq(4)').html().includes("check")) {
            $('#active').prop("checked", true);
        } else {
            $('#active').prop("checked", false);
        }
        $('#file').val("");
    });

    $('.deleteButton').click(function(){
        $('#deleteForm').attr('action', '/stagesManagement/delete/' + $(this).parents('tr').find('td:eq(0)').html());
    });

    $('.searchInput').keyup(function(){
        let value = $(this).val().toLowerCase();
        $("#stagesTable tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });

});
