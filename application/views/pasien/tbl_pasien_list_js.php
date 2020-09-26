<script type="text/javascript">
    $(document).ready(function() {
        $('#mytable').DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: "<?php echo base_url('pasien/json_table') ?>",
                method: 'POST',
            },
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