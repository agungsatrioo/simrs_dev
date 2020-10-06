<script>
    $('#id_dokter').select2({
        placeholder: 'Pilih dokter penanggungjawab',
        allowClear: true,
        ajax: {
            url: "<?php echo base_url("dokter/ajax_dokter") ?>",
            dataType: 'json',
            type: 'POST',
            data: function(term) {
                return {
                    term: term.term,
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.nama_dokter,
                            id: item.id,
                            other: item,
                        }
                    })
                };
            },
        },
    });

    var studentSelect = $('#id_dokter');

    $.ajax({
        "url": "<?php echo base_url("dokter/ajax_dokter") ?>",
        dataType: 'json',
        type: 'POST',
        data : {"id_dokter" : "<?php echo $id_dokter ?>"},
    }).then(function(data) {
        var option = new Option(data[0].nama_dokter, data[0].id, true, true);

        studentSelect.append(option).trigger('change');

        studentSelect.trigger({
            type: 'select2:select',
            params: {
                data: data
            }
        });
    });
</script>