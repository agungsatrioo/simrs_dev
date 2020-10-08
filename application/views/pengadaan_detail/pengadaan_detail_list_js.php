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
                "url": "<?php echo $dt_url ?>",
                "type": "POST"
            },
            columns: [{
                    "data": "id",
                    "orderable": false
                }, {
                    "data": "no_faktur"
                }, {
                    "data": "nama_barang"
                }, {
                    "data": "qty"
                }, {
                    "data": "harga"
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
            dom: dt_dom,
            buttons: [{
                    text: '<i class=\"fa fa-plus\"></i>&nbsp;&nbsp;Input Barang',
                    className: "btn btn-primary",
                    action: function(e, node, config) {
                        $('#inputBarang').modal('show')
                    }
                }, {
                    extend: 'pdfHtml5',
                    text: "<i class=\"fa fa-file-pdf\"></i>&nbsp;&nbsp;Ekspor ke PDF",
                    className: "btn btn-danger",
                    title: "<?php echo "Laporan Detail Pengadaan_" . date('Y-m-d') ?>",
                    customize: function(doc) {
                        filename: "sample.pdf"
                    }
                },
                {
                    extend: 'excelHtml5',
                    text: "<i class=\"fa fa-file-excel\"></i>&nbsp;&nbsp;Ekspor ke Excel",
                    className: "btn btn-success"
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

        $('#id_barang').select2({
            placeholder: 'Pilih obat',
            allowClear: true,
            dropdownParent: $('#inputBarang'),
            ajax: {
                url: "<?php echo base_url("barang/ajax") ?>",
                dataType: 'json',
                type: 'post',
                data: function(term) {
                    return {
                        term: term.term,
                    };
                },
                processResults: function(data) {
                    return {
                        results: $.map(data, function(item) {
                            return {
                                text: item.nama_barang,
                                id: item.id,
                                other: item
                            }
                        })
                    };
                },
            },
        });
    });
</script>