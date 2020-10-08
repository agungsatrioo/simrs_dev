<script type="text/javascript">
    $(document).ready(function() {
        var t = $("#mytable").dataTable({
            initComplete: function() {
                var api = this.api();
                $('#mytable_filter input')
                    .off('.DT')
                    .on('keyup.DT', function(e) {
                        if (e.keyCode == 13) {
                            api.search(this.value).draw();
                        }
                    });
            },
            oLanguage: {
                sProcessing: "loading..."
            },
            processing: true,
            dom: dt_dom,
            buttons: buttons("<?php echo $create_link ?>", "<?php echo $file_name ?>", "<?php echo $title ?>", "<?php echo $message ?>"),
            "ajax": {
                url: "<?php echo $json_url ?>",
                method: 'POST'
            },
            columns: [{
                    "data": "id",
                    "orderable" : false
                },{
                    "data": "no_rawat",
                }, {
                    "data": "tgl_daftar"
                }, {
                    "data": "nama_pasien"
                }, {
                    "data": "nama_cara_masuk"
                }, {
                    "data": "isi"
                }, {
                    "data": "jenis_bayar"
                },{
                    "data": "nama_status_rawat"
                },
                {
                    "data": "action",
                    "orderable": false,
                    "className": "text-center"
                }
            ],
            order: [
                [0, 'desc']
            ],
            rowCallback: function(row, data, iDisplayIndex) {
                var info = this.fnPagingInfo();
                var page = info.iPage;
                var length = info.iLength;
                var index = page * length + (iDisplayIndex + 1);
                $('td:eq(0)', row).html(index);
            }
        });
    });
</script>

