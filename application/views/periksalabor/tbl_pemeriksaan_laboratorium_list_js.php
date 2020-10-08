<script type="text/javascript">
    $(document).ready(function() {

        $('#mytable').DataTable({
            "processing": true,
            "ajax": {
                url: "<?php echo base_url('periksalabor/json') ?>",
                method: 'POST',
            },
            dom: dt_dom,
            buttons: buttons("<?php echo $create_link ?>", "<?php echo $file_name ?>", "<?php echo $title ?>", "<?php echo $message ?>"),

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