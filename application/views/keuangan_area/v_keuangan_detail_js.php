<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');
?>

<script>
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
        buttons: buttons("", "FakturObat", "FAKTUR OBAT", ""),
        ajax: {
            "url": "<?php echo api_url("dt_keu_obat") ?>",
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
        buttons: buttons("", "Laporan Riwayat Alkes", "LAPORAN RIWAYAT ALAT KESEHATAN", ""),
        ajax: {
            "url": "<?php echo api_url("dt_keu_alkes") ?>",
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
            buttons: buttons("", "Laporan Riwayat Tindakan", "LAPORAN RIWAYAT TINDAKAN", ""),
            ajax: {
                "url": "<?php echo api_url("dt_keu_tindakan") ?>",
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
</script>