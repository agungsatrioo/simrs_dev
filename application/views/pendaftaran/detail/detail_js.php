<script type="text/javascript">
    $(document).ready(function() {
        $("#tbl_riwayat_obat").dataTable({
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
            dom: 'Bfrtip',
            buttons: [{
                    text: 'Input Obat',
                    className: "btn btn-primary",
                    action: function(e, node, config) {
                        $('#inputObat').modal('show')
                    }
                }, {
                    extend: 'pdfHtml5',
                    text: "<i class=\"fa fa-file-pdf\"></i>&nbsp;&nbsp;Ekspor ke PDF",
                    className: "btn btn-danger",
                    title: "<?php echo "Laporan Riwayat Obat_" . date('Y-m-d') . "_" . str_replace("/", ".", $info_pasien->no_rawat) ?>",
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
            ajax: {
                "url": "<?php echo api_url("dt_riwayat_obat") ?>",
                "type": "POST",
                "data": {
                    "id_pendaftaran": "<?php echo $info_pasien->id; ?>"
                }
            },
            columns: [{
                "data": "id",
            }, {
                "data": "nama_barang"
            }, {
                "data": "tanggal"
            }, {
                "data": "status"
            }, {
                "data": "harga",
                render: function(data, type, row, meta) {
                    return rupiah_reg(data);
                }
            }, {
                "data": "qty"
            }, {
                "data": "subtotal",
                render: function(data, type, row, meta) {
                    return rupiah_reg(data);
                }
            }, ],
            order: [
                [0, 'desc']
            ],
            rowCallback: function(row, data, iDisplayIndex) {
                var info = this.fnPagingInfo();
                var page = info.iPage;
                var length = info.iLength;
                var index = page * length + (iDisplayIndex + 1);
                $('td:eq(0)', row).html(index);
            },
            footerCallback: function(row, data, start, end, display) {
                var api = this.api(),
                    data;

                // Remove the formatting to get integer data for summation
                var intVal = function(i) {
                    return typeof i === 'string' ?
                        i.replace(/[\$,]/g, '') * 1 :
                        typeof i === 'number' ?
                        i : 0;
                };

                // Total over all pages
                total = api
                    .column(6)
                    .data()
                    .reduce(function(a, b) {
                        return intVal(a) + intVal(b);
                    }, 0);

                console.log(total);

                // Total over this page
                pageTotal = api
                    .column(6, {
                        page: 'current'
                    })
                    .data()
                    .reduce(function(a, b) {
                        return intVal(a) + intVal(b);
                    }, 0);

                // Update footer
                $(api.column(6).footer()).html(
                    rupiah_reg(pageTotal) + "(" + rupiah_reg(total) + "total)"
                );
            }
        });

        $("#tbl_riwayat_alkes").dataTable({
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
            dom: 'Bfrtip',
            buttons: [{
                    text: 'Input Alat Kesehatan',
                    className: "btn btn-primary",
                    action: function(e, node, config) {
                        $('#inputAlkes').modal('show')
                    }
                }, {
                    extend: 'pdfHtml5',
                    text: "<i class=\"fa fa-file-pdf\"></i>&nbsp;&nbsp;Ekspor ke PDF",
                    className: "btn btn-danger",
                    title: "<?php echo "Laporan Riwayat Alat Kesehatan_" . date('Y-m-d') . "_" . str_replace("/", ".", $info_pasien->no_rawat) ?>",
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
            ajax: {
                "url": "<?php echo api_url("dt_riwayat_alkes") ?>",
                "type": "POST",
                "data": {
                    "id_pendaftaran": "<?php echo $info_pasien->id; ?>"
                }
            },
            columns: [{
                "data": "id",
            }, {
                "data": "nama_barang"
            }, {
                "data": "tanggal"
            }, {
                "data": "status"
            }, {
                "data": "harga",
                render: function(data, type, row, meta) {
                    return rupiah_reg(data);
                }
            }, {
                "data": "qty"
            }, {
                "data": "subtotal",
                render: function(data, type, row, meta) {
                    return rupiah_reg(data);
                }
            }, ],
            order: [
                [0, 'desc']
            ],
            rowCallback: function(row, data, iDisplayIndex) {
                var info = this.fnPagingInfo();
                var page = info.iPage;
                var length = info.iLength;
                var index = page * length + (iDisplayIndex + 1);
                $('td:eq(0)', row).html(index);
            },
            footerCallback: function(row, data, start, end, display) {
                var api = this.api(),
                    data;

                // Remove the formatting to get integer data for summation
                var intVal = function(i) {
                    return typeof i === 'string' ?
                        i.replace(/[\$,]/g, '') * 1 :
                        typeof i === 'number' ?
                        i : 0;
                };

                // Total over all pages
                total = api
                    .column(6)
                    .data()
                    .reduce(function(a, b) {
                        return intVal(a) + intVal(b);
                    }, 0);

                console.log(total);

                // Total over this page
                pageTotal = api
                    .column(6, {
                        page: 'current'
                    })
                    .data()
                    .reduce(function(a, b) {
                        return intVal(a) + intVal(b);
                    }, 0);

                // Update footer
                $(api.column(6).footer()).html(
                    rupiah_reg(pageTotal) + "(" + rupiah_reg(total) + "total)"
                );
            }
        });

        $('#id_obat').select2({
            placeholder: 'Pilih obat',
            allowClear: true,
            dropdownParent: $('#inputObat'),
            ajax: {
                url: "<?php echo api_url("obat") ?>",
                dataType: 'json',
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
        
        $('#id_alkes').select2({
            placeholder: 'Pilih obat',
            allowClear: true,
            dropdownParent: $('#inputAlkes'),
            ajax: {
                url: "<?php echo api_url("alkes") ?>",
                dataType: 'json',
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