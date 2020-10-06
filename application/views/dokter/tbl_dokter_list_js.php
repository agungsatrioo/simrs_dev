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

        var t = $("#mytable").dataTable({
            initComplete: function() {
                var api = this.api();
                $(' #mytable_filter input').off('.DT').on('keyup.DT', function(e) {
                    if (e.keyCode == 13) {
                        api.search(this.value).draw();
                    }
                });
            },
            oLanguage: {
                sProcessing: "loading..."
            },
            processing: true,
            ajax: {
                "url": "<?php echo base_url("dokter/json") ?>",
                "type": "POST"
            },
            columns: [{
                "data": "id",
                "orderable": false
            }, {
                "data": "nama_dokter"
            }, {
                "data": "no_telepon"
            }, {
                "data": "nama_spesialis"
            }, {
                "data": "no_izin_praktik"
            }, {
                "data": "alumni"
            }, {
                "data": "action",
                "orderable": false,
                "className": "text-center"
            }],
            order: [
                [0, 'desc']
            ],
            dom: 'Bfrtip',
            buttons: buttons("<?= $create_link ?>", "Data Dokter", "DATA DOKTER"),
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