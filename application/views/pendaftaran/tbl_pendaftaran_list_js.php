<script type="text/javascript">
    $(document).ready(function() {
        $('#mytable').DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: 'pegawai/json',
                method: 'POST'
            }
        });
    });
</script>