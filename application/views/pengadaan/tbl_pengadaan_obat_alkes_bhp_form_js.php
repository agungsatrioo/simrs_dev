<script type="text/javascript">
    function formatSupplier(item) {
        if (!item.id) {
            return item.text;
        }

        let alamat = item.other.alamat;

        let template = "<span>" + item.text + "<br><b>Alamat: </b>" + alamat + "</span>";

        return $(template);
    }

    var studentSelect = $('#id_supplier');

    $.ajax({
        url: "<?php echo base_url("supplier/ajax_supplier") ?>",
        dataType: 'json',
        type: 'POST',
        data: {
            "id_supplier": "<?php echo $id_supplier ?>"
        },
    }).then(function(data) {
        var option = new Option(data[0].nama_supplier, data[0].id, true, true);

        studentSelect.append(option).trigger('change');

        studentSelect.trigger({
            type: 'select2:select',
            params: {
                data: data
            }
        });
    });

    $('#id_supplier').select2({
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
                            id: item.id,
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
                "id_barang": $("#id_barang").val(),
                "qty": $("#qty").val(),
                "harga": $("#harga").val(),
                "id_barang_pengadaan": $("#id").val()
            },
            success: function(response) {
                load();
            },
            error: function(error) {
                console.log("error!");
            }
        });



    }

    function load() {
        var id = $("#id").val();
        $.ajax({
            url: "<?php echo base_url("pengadaan/list_pengadaan/") ?>" + id,
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