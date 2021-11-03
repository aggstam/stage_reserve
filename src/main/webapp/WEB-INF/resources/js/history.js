
$(document).ready(function(){

    $('.deleteButton').click(function(){
        $('#deleteForm').attr('action', '/history/delete/' + $(this).parents('tr').find('td:eq(0)').html());
    });

    $('.searchInput').keyup(function(){
        let value = $(this).val().toLowerCase();
        $("#reservationsTable tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });

});
