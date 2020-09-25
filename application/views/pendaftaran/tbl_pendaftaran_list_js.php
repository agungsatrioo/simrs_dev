<script type="text/javascript">
    $(document).ready(function() {
        $('#mytable').DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: "<?php echo $json_url ?>",
                method: 'POST'
            },
            columns: [{
                    "data": "no_registrasi",
                }, {
                    "data": "no_rawat"
                }, {
                    "data": "no_rekamedis"
                }, {
                    "data": "nama_pasien"
                }, {
                    "data": "cara_masuk"
                }, {
                    "data": "nama_dokter"
                }, {
                    "data": "td_isi"
                }, {
                    "data": "jenis_bayar"
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