<script type="text/javascript">
    $(document).ready(function() {

        $('#mytable').DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: "<?php echo $json_url ?>",
                method: 'POST',
                data: {
                    "no_rawat": "<?php echo $encodedNoRawat ?>"
                }
            },
            columns: [{
                "data": "id_mutasi",
            }, {
                "data": "tanggal_mutasi"
            }, {
                "data": "keterangan"
            }, {
                "data": "mutasi_awal",
                render: function(data, type, row, meta) {
                    return rupiah(data);
                }
            }, {
                "data": "jumlah_mutasi",
                render: function(data, type, row, meta) {
                    return rupiah(data);
                }
            }, {
                "data": "mutasi_akhir",
                render: function(data, type, row, meta) {
                    return rupiah(data);
                }
            }],
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
                        if(b < 0) pengeluaran_all += Math.abs(b);
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
                        if(b < 0) pengeluaran_page += Math.abs(b);
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