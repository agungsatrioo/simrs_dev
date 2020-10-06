<script type="text/javascript">
    $(document).ready(function() {
        $.fn.dataTableExt.oApi.fnPagingInfo = function(oSettings) {
            return {
                "iStart": oSettings._iDisplayStart,
                "iEnd": oSettings.fnDisplayEnd(),
                "iLength": oSettings._iDisplayLength,
                "iTotal": oSettings.fnRecordsTotal(),
                "iFilteredTotal": oSettings.fnRecordsDisplay(),
                "iPage": Math.ceil(oSettings._iDisplayStart / oSettings._iDisplayLength),
                "iTotalPages": Math.ceil(oSettings.fnRecordsDisplay() / oSettings._iDisplayLength)
            };
        };

        $("#mytable").dataTable({
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
            "processing": true,
            "ajax": {
                url: "<?php echo base_url('pasien/json_table') ?>",
                method: 'POST',
            },
            dom: 'Bfrtip',
            buttons: buttons("<?php echo $create_link ?>", "<?php echo $file_name ?>", "<?php echo $title ?>", "<?php echo $message ?>"),
            columns: [{
                    "data": "id",
                    "orderable": false
                }, {
                    "data": "no_kartu"
                }, {
                    "data": "nama_pasien"
                }, {
                    "data": "nama_jk"
                }, {
                    "data": "nama_gol_darah"
                }, {
                    "data": "tempat_lahir"
                }, {
                    "data": "tgl_lahir"
                }, {
                    "data": "nama_ibu"
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
            dom: 'Bfrtip',
            buttons: buttons("<?= $create_link ?>", "Laporan menu", "LAPORAN MENU APLIKASI"),
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