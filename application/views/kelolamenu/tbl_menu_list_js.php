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
            processing: true,
            ajax: {
                "url": "kelolamenu/json",
                "type": "POST"
            },
            columns: [{
                    "data": "id_menu",
                    "orderable": false
                }, {
                    "data": "title"
                }, {
                    "data": "url"
                }, {
                    "data": "icon"
                }, {
                    "data": "is_main_menu"
                }, {
                    "data": "is_aktif"
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
            buttons: [{
                    text: '<i class=\"fa fa-plus\"></i>&nbsp;&nbsp;Tambah data',
                    className: "btn btn-primary",
                    action: function(e, node, config) {
                        window.location = "<?= $create_link ?>";
                    }
                }, {
                    extend: 'pdfHtml5',
                    text: "<i class=\"fa fa-file-pdf\"></i>&nbsp;&nbsp;Ekspor ke PDF",
                    className: "btn btn-danger",
                    exportOptions: {
                        modifier: {
                            order: 'index', // 'current', 'applied','index', 'original'
                            page: 'all', // 'all', 'current'
                            search: 'none' // 'none', 'applied', 'removed'
                        },
                    }
                },
                {
                    extend: 'excelHtml5',
                    text: "<i class=\"fa fa-file-excel\"></i>&nbsp;&nbsp;Ekspor ke Excel",
                    className: "btn btn-success",
                    exportOptions: {
                        columns: 'th:not(:last-child)',
                        modifier: {
                            page: 'all',
                            search: 'none'
                        }
                    }
                }
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