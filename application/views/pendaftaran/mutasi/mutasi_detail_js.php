<script type="text/javascript">
    $(document).ready(function() {
        $('#mytable').DataTable({
            "processing": true,
            "ajax": {
                url: "<?php echo api_url("dt_mutasi") ?>",
                method: 'POST',
                data: {
                    "id_pendaftaran": "<?php echo $info_pasien->id ?>"
                }
            },
            columns: [{
                "data": "id",
            }, {
                "data": "tgl_input"
            }, {
                "data": "keterangan"
            }, {
                "data": "mutasi_awal",
                render: function(data, type, row, meta) {
                    return rupiah(data);
                }
            }, {
                "data": "jumlah",
                render: function(data, type, row, meta) {
                    return rupiah(data);
                }
            }, {
                "data": "mutasi_akhir",
                render: function(data, type, row, meta) {
                    return rupiah(data);
                }
            }],
            rowCallback: function(row, data, iDisplayIndex) {
                var info = this.fnPagingInfo();
                var page = info.iPage;
                var length = info.iLength;
                var index = page * length + (iDisplayIndex + 1);
                $('td:eq(0)', row).html(index);
            },
            dom: 'Bfrtip',
            buttons: [{
                    text: '<i class="fa fa-sign-out-alt"></i>&nbsp;&nbsp;Kembali',
                    className: "btn btn-info",
                    action: function(e, node, config) {
                        window.location = "<?= $backUrl ?>";
                    }
                },
                {
                    extend: 'pdfHtml5',
                    text: "<i class=\"fa fa-file-pdf\"></i>&nbsp;&nbsp;Ekspor ke PDF",
                    className: "btn btn-danger",
                    title: "<?php echo "Laporan Mutasi_" . date('Y-m-d') . "_" . $info_pasien->no_rawat . "__" . $info_pasien->nama_pasien ?>",
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
                        modifier: {
                            order: 'index', // 'current', 'applied','index', 'original'
                            page: 'all', // 'all', 'current'
                            search: 'none' // 'none', 'applied', 'removed'
                        },
                    }
                }
            ],
            "footerCallback": function(row, data, start, end, display) {
                var api = this.api(),
                    data;
                var pengeluaran_page = 0;
                var pengeluaran_all = 0;

                // Remove the formatting to get integer data for summation
                var intVal = function(i) {
                    return typeof i === 'string' ?
                        i.replace(/[\$,]/g, '') * 1 :
                        typeof i === 'number' ?
                        i : 0;
                };

                // Total over all pages
                total = api
                    .column(4)
                    .data()
                    .reduce(function(a, b) {
                        if (b < 0) pengeluaran_all += Math.abs(b);
                        return intVal(a) + intVal(b);
                    }, 0);

                console.log(total);

                // Total over this page
                pageTotal = api
                    .column(4, {
                        page: 'current'
                    })
                    .data()
                    .reduce(function(a, b) {
                        if (b < 0) pengeluaran_page += Math.abs(b);
                        return intVal(a) + intVal(b);
                    }, 0);

                // Update footer
                $("#saldo_akhir").html(
                    rupiah(pageTotal) + " dlm. halaman ini (" + rupiah(total) + "total)"
                );

                $("#total_tagihan").html(
                    pengeluaran(pengeluaran_page) + " dlm. halaman ini (" + pengeluaran(pengeluaran_all) + "total)"
                );


            }
        });
    });
</script>