<script>
    $('#tgl_input').daterangepicker({
        opens: 'left',
        timePicker: true,
        timePicker24Hour: true,
        startDate: moment().startOf('hour'),
        endDate: moment().startOf('hour').add(32, 'hour'),
        locale: {
            format: 'YYYY-MM-DD hh:mm:ss',
            cancelLabel: 'Clear'
        },
        autoUpdateInput: false,
    }, function(start, end, label) {
        let parseFormat = 'YYYY-MM-DD hh:mm:ss';

        let start_f = start.format(parseFormat);
        let end_f = end.format(parseFormat);

        $("#tgl_berangkat").val(start_f);
        $("#tgl_pulang").val(end_f);
    });

    $('#tgl_input').on('apply.daterangepicker', function(ev, picker) {
        let parseFormat = 'dddd, Do MMMM YYYY, h:mm:ss';
        
        let start_f = picker.startDate.format(parseFormat);
        let end_f = picker.endDate.format(parseFormat);

        $(this).val(start_f + ' - ' + end_f);
    });

    $('#tgl_input').on('cancel.daterangepicker', function(ev, picker) {
        $(this).val('');
    });
</script>