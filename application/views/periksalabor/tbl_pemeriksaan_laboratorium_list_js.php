<script type="text/javascript">
    $(document).ready(function() {

        $('#mytable').DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: "<?php echo base_url('periksalabor/json') ?>",
                method: 'POST',
            },
            columns: [{
                "data": "kode_periksa",
                "orderable": false
            }, {
                "data": "kode_periksa"
            }, {
                "data": "nama_periksa"
            }, {
                "data": "tarif",
                render: function(data, type, row, meta) {
                    return rupiah(data);
                }
            }, {
                "data": "action",
                "orderable": false,
                "className": "text-center"
            }],
        });
    });
</script>