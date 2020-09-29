<script>
    $('#kode_ruang_rawat_inap').select2({
        minimumInputLength: 1,
        placeholder: 'Pilih nama ruang inap (biarkan kosong jika tidak ingin mengubah ruangan)',
        allowClear: true,
        ajax: {
            url: "<?php echo base_url() ?>tempattidur/ajax_ruangan",
            dataType: 'json',
            data: function(term) {
                return {
                    term: term
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.nama_ruangan,
                            id: item.kode_ruang_rawat_inap
                        }
                    })
                };
            }
        }
    });
</script>