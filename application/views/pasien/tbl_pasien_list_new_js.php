<script type="text/javascript">
    $(document).ready(function() {
        $('#mytable').DataTable({
            "processing": true,
            "ajax": {
                url: "<?php echo base_url('pasien/json_table') ?>",
                method: 'POST',
            },
            dom: 'Bfrtip',
            buttons: buttons("<?php echo $create_link ?>", "<?php echo $file_name ?>", "<?php echo $title ?>", "<?php echo $message ?>"),

            columns: [{
                    "data": "no_rekamedis",
                }, {
                    "data": "nama_pasien"
                }, {
                    "data": "jenis_kelamin"
                }, {
                    "data": "nama_gol_darah"
                }, {
                    "data": "tempat_lahir"
                }, {
                    "data": "tanggal_lahir"
                }, {
                    "data": "nama_ibu"
                }, {
                    "data": "nama_status_menikah"
                },
                {
                    "data": "action",
                    "orderable": false,
                    "className": "text-center"
                }
            ],
        });
    });
</script>