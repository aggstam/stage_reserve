
$(document).ready(function(){

    $('#datesTimeString').daterangepicker({
        timePicker: true,
        timePicker24Hour: true,
        autoUpdateInput: false,
        minDate: moment().startOf('hour'),
        startDate: moment().startOf('hour'),
        endDate: moment().startOf('hour'),
        locale: {
            format: 'MM/DD/YYYY H:mm'
        }
    });

    $('#datesTimeString').on('apply.daterangepicker', function(ev, picker) {
        if (isValidRange(picker.startDate, picker.endDate)) {
            $(this).val(picker.startDate.format('MM/DD/YYYY H:mm') + ' - ' + picker.endDate.format('MM/DD/YYYY H:mm'));
        } else {
            alert("Reservation already exists for that range!");
            $(this).val('');
        }
    });

    $('#datesTimeString').on('cancel.daterangepicker', function(ev, picker) {
        $(this).val('');
    });

    let dateRanges = [];
    let listGroupItems = document.getElementsByClassName('list-group-item');
    for (let i = 0; i < listGroupItems.length; i++) {
        let dateRange = listGroupItems[i].innerHTML.replace(/<a.*<\/a>/g, ' ').split('-&gt;');
        dateRanges.push({startDate: new Date(dateRange[0]), endDate: new Date(dateRange[1])})
    }
    function isValidRange(startDate, endDate) {
        for (let i = 0; i < dateRanges.length; i++) {
            if (!(dateRanges[i].endDate < startDate || dateRanges[i].startDate > endDate)) {
                return false;
            }
        }
        return true;
    }

    $('textarea').autoResize();
    
});
