<script type="text/javascript">
    $(function() {
        $("#barang").autocomplete({
            source: "<?php echo base_url() ?>dataobat/autocomplate",
            minLength: 1
        });
    });

    function formatSupplier(item) {
        if (!item.id) {
            return item.text;
        }

        let alamat = item.other.alamat;

        let template = "<span>" + item.text + "<br><b>Alamat: </b>" + alamat + "</span>";

        return $(template);
    }

    $('#kode_supplier').select2({
        placeholder: 'Pilih supplier',
        allowClear: true,
        ajax: {
            url: "<?php echo base_url("supplier/ajax_supplier") ?>",
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
                            text: item.nama_supplier,
                            id: item.kode_supplier,
                            other: item
                        }
                    })
                };
            },
        },
        templateResult: formatSupplier,
    });

    $('#kode_barang').select2({
        placeholder: 'Pilih barang',
        allowClear: true,
        ajax: {
            url: "<?php echo base_url("dataobat/ajax") ?>",
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
                            id: item.kode_barang,
                            other: item
                        }
                    })
                };
            },
        },
    });

    $('#kode_barang').on('select2:select', function(e) {
        var data = e.params.data;

        harga = data.other.harga;

       $("#harga").val(harga)
    });

    function add() {
        $.ajax({
            url: "<?php echo base_url("pengadaan/add_ajax") ?>",
            dataType: 'json',
            type: 'post',
            data: {
                    "kode_barang": $("#kode_barang").val(),
                    "qty": $("#qty").val(),
                    "harga": $("#harga").val(),
                    "faktur": $("#nofaktur").val()
                },
        });
        load();

    }

    function load() {
        var faktur = $("#nofaktur").val();
        $.ajax({
            url: "<?php echo base_url("pengadaan/list_pengadaa") ?>n",
            data: "faktur=" + faktur,
            success: function(html) {
                $("#list").html(html);
            }
        });
    }

    function hapus(id) {
        $.ajax({
            url: "<?php echo base_url() ?>pengadaan/hapus_ajax",
            data: "id_pengadaan=" + id,
            success: function(html) {
                load();
            }
        });
    }
    
</script>