<script>
    moment.locale('id');

    $('.datepicker').datepicker({
        language: "id",
        format: {
            toDisplay: function(date, format, language) {
                let d = new Date(date);
                let str = moment(d).format('Do MMMM YYYY');
                let str2 = moment(d).format('YYYY-MM-DD');

                $("#tgl_lahir").val(str2);

                return str;
            },
            toValue: function(date, format, language) {
                let d = new Date(date);
                let str = moment(d).format('YYYY-MM-DD');

                return str;
            }
        },
        autoclose: true,
        todayBtn: true
    });
</script>