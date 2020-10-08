<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * TABEL KEUANGAN DETAIL
 */
?>

<script>
    $(document).ready(function() {
        var t = $('#tbl_riwayat_obat').DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: "<?php echo base_url("apotek_area/obat_ajax/$no_rawat") ?>",
                method: 'POST'
            },
            "order": [
                [0, 'asc']
            ],
            columns: [{
                "data": "kode_barang",
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
                "data": "jumlah"
            }, {
                "data": "subtotal",
                render: function(data, type, row, meta) {
                    return rupiah_reg(data);
                }
            }, ],
            dom: dt_dom,
            buttons: [
                {
                    extend: 'pdfHtml5',
                    text: "<i class=\"fa fa-file-pdf\"></i>&nbsp;&nbsp;Ekspor ke PDF",
                    className: "btn btn-danger",
                    title: "<?php echo "Laporan Apoteker_".date('Y-m-d') . "_" . $no_rawat ?>",
                    exportOptions: {
                        modifier: {
                            page: 'all',
                            search: 'none'
                        }
                    }
                },
                {
                    extend: 'excelHtml5',
                    text: "<i class=\"fa fa-file-excel\"></i>&nbsp;&nbsp;Ekspor ke Excel",
                    className: "btn btn-success",
                    exportOptions: {
                        modifier: {
                            page: 'all',
                            search: 'none'
                        }
                    }
                }
            ],
            "footerCallback": function(row, data, start, end, display) {
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
        })
    });
</script>