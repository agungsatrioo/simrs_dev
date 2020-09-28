<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * TABEL KEUANGAN DETAIL
 */
?>

<script>
    $(document).ready(function() {
        $('#tbl_riwayat_obat').DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: "<?php echo base_url("keuangan_area/obat_ajax/$no_rawat") ?>",
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
                },
                {
                    "data": "action",
                    "orderable": false,
                    "className": "text-center"
                }
            ],
        })
    });
</script>