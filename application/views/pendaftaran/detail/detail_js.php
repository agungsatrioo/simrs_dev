<script type="text/javascript">
    $(document).ready(function() {
        var id_gedung;
        var id_kelas;
        var api_url = "";

        <?php
        $barangs = [
            ["#tbl_riwayat_obat", "#inputObat", "#id_obat"],
            ["#tbl_riwayat_alkes", "#inputAlkes", "#id_alkes"]
        ];
        ?>

        function formatBarang(item) {
            if (!item.id) {
                return item.text;
            }

            let nama = item.other.nama_barang;
            let stok = item.other.stok;

            let template = "<span>" + nama + "<br><b>Stok: </b>" + stok + "</span>";

            return $(template);
        }
        
        function formatTindakan(item) {
            if (!item.id) {
                return item.text;
            }

            let nama = item.other.nama_tindakan;
            let tarif = item.other.tarif;

            let template = "<span>" + nama + "<br><b>Tarif: </b>" + rupiah_reg(tarif) + "</span>";

            return $(template);
        }

        $('#id_kelas_div').hide();

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
            dom: dt_dom,
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
            }, {
                "data": "action",
                "orderable": false,
                "className": "text-center"
            }],
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
            dom: dt_dom,
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
            }, {
                "data": "action",
                "orderable": false,
                "className": "text-center"
            }],
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

        $("#tbl_riwayat_tindakan").dataTable({
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
            buttons: [{
                    text: 'Input Tindakan',
                    className: "btn btn-primary",
                    action: function(e, node, config) {
                        $('#inputTindakan').modal('show')
                    }
                }, {
                    extend: 'pdfHtml5',
                    text: "<i class=\"fa fa-file-pdf\"></i>&nbsp;&nbsp;Ekspor ke PDF",
                    className: "btn btn-danger",
                    title: "<?php echo "Laporan Riwayat Tindakan_" . date('Y-m-d') . "_" . str_replace("/", ".", $info_pasien->no_rawat) ?>",
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
                "url": "<?php echo api_url("dt_riwayat_tindakan") ?>",
                "type": "POST",
                "data": {
                    "id_pendaftaran": "<?php echo $info_pasien->id; ?>"
                }
            },
            columns: [{
                "data": "id",
            }, {
                "data": "tanggal"
            }, {
                "data": "nama_tindakan"
            }, {
                "data": "hasil_periksa"
            }, {
                "data": "perkembangan"
            },  {
                "data": "status"
            }, {
                "data": "tarif",
                render: function(data, type, row, meta) {
                    return rupiah_reg(data);
                }
            }, {
                "data": "action",
                "orderable": false,
                "className": "text-center"
            }],
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
                type: "post",
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
            templateResult: formatBarang
        });

        $('#id_alkes').select2({
            placeholder: 'Pilih obat',
            allowClear: true,
            dropdownParent: $('#inputAlkes'),
            ajax: {
                url: "<?php echo api_url("alkes") ?>",
                dataType: 'json',
                type: "post",
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
            templateResult: formatBarang

        });

        $('#id_gedung').select2({
            placeholder: 'Cari gedung',
            dropdownParent: $('#input2Ranap'),
            ajax: {
                url: "<?php echo api_url("gedung") ?>",
                dataType: 'json',
                type: "post",
                data: function(term) {
                    return {
                        term: term.term,
                    };
                },
                processResults: function(data) {
                    return {
                        results: $.map(data, function(item) {
                            return {
                                text: item.nama_gedung,
                                id: item.id,
                                other: item
                            }
                        })
                    };
                },
            },
        });

        $('#id_kelas').select2({
            placeholder: 'Cari kelas gedung',
            dropdownParent: $('#input2Ranap'),
            ajax: {
                url: "<?php echo api_url("kelas_ruang") ?>",
                dataType: 'json',
                type: "post",
                data: function(term) {
                    return {
                        term: term.term,
                        "id_gedung": id_gedung
                    };
                },
                processResults: function(data) {
                    return {
                        results: $.map(data, function(item) {
                            return {
                                text: item.nama_kelas_ruang_ranap,
                                id: item.id,
                                other: item
                            }
                        })
                    };
                },
            },
        });

        $('#id_ruang_ranap').select2({
            placeholder: 'Cari ruangan rawat inap',
            dropdownParent: $('#input2Ranap'),
            ajax: {
                url: "<?php echo api_url("ruang_filtered") ?>",
                dataType: 'json',
                type: "post",
                data: function(term) {
                    return {
                        term: term.term,
                        "id_kelas": id_kelas,
                        "id_gedung": id_gedung,
                    };
                },
                processResults: function(data) {
                    return {
                        results: $.map(data, function(item) {
                            return {
                                text: item.nama_ruangan,
                                id: item.id,
                                other: item
                            }
                        })
                    };
                },
            },
        });

        $('#id_tindakan').select2({
            placeholder: 'Pilih tindakan',
            allowClear: true,
            dropdownParent: $('#inputTindakan'),
            ajax: {
                url: "<?php echo api_url("tindakan") ?>",
                dataType: 'json',
                type: "post",
                data: function(term) {
                    return {
                        term: term.term,
                    };
                },
                processResults: function(data) {
                    return {
                        results: $.map(data, function(item) {
                            return {
                                text: item.nama_tindakan,
                                id: item.id,
                                other: item
                            }
                        })
                    };
                },
            },
            templateResult: formatTindakan
        });

        $('#id_gedung').on('select2:select', function(e) {
            var data = e.params.data;

            id_gedung = data.id;
            $('#id_kelas').empty();
        });

        $('#id_kelas').on('select2:select', function(e) {
            var data = e.params.data;

            id_kelas = data.id;
            $('#id_ruang_ranap').empty();
        });


    });
</script>