<script>
    var id_poli;

    $("#no_kartu_div").hide();
    $(".col-dokter").hide();
    $("#id_pj_dokter").hide();
    $(".pasien-input").hide();

    $('.datepicker').datepicker({
        language: "id",
        format: {
            toDisplay: function(date, format, language) {
                let d = new Date(date);
                let str = moment(d).format('Do MMMM YYYY');
                let str2 = moment(d).format('YYYY-MM-DD');

                $("#tgl_daftar").val(str2);

                return str;
            },
            toValue: function(date, format, language) {
                let d = new Date(date);
                let str = moment(d).format('YYYY-MM-DD');

                return str;
            }
        },
        autoclose: true,
        todayBtn: true
    });

    $('.datepicker').datepicker('setDate', new Date());


    function formatPasien(item) {
        if (!item.id || !item.other.no_kartu) {
            return item.text;
        }

        let nama_pasien = item.other.nama_pasien;
        let no_kartu = item.other.no_kartu;

        let template = "<span>" + nama_pasien + "<br><b>Nomor kartu: </b>" + no_kartu + "</span>";

        return $(template);
    }

    function formatDokter(item) {

        if (!item.id) {
            return item.text;
        }

        let nama_dokter = item.other.nama_dokter
        let tersedia = item.other.tersedia
        let tersedia_type = tersedia == true ? "Tersedia" : "Tidak tersedia";
        let tersedia_color = tersedia == true ? "text-success" : "text-danger";
        let hari_praktik = item.other.hari
        let jam_praktik = item.other.jam_mulai + "-" + item.other.jam_selesai;
        let nama_poliklinik = item.other.nama_poliklinik

        let template = "<span>" + nama_dokter + "<br><b class=\"" + tersedia_color + "\">" + tersedia_type + "</b><br><b>Hari praktik: </b>" + hari_praktik + ", " + jam_praktik + "</span><br><b>Poliklinik: </b>" + nama_poliklinik + "</span>";

        return $(template);
    }


    $('#id_rekamedis').select2({
        placeholder: 'Cari nomor kartu atau nama pasien',
        ajax: {
            url: "<?php echo api_url("rekamedis") ?>",
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
                            text: item.nama_pasien,
                            id: item.id,
                            other: item
                        }
                    })
                };
            },
        },
        templateResult: formatPasien,
    });

    $('#id_poli').select2({
        placeholder: 'Pilih poliklinik',
        ajax: {
            url: "<?php echo api_url("poliklinik") ?>",
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
                            text: item.nama_poliklinik,
                            id: item.id,
                            other: item,
                        }
                    })
                };
            },
        },
    });

    $('#id_pj_dokter').select2({
        placeholder: 'Pilih dokter penanggungjawab',
        allowClear: true,
        ajax: {
            url: "<?php echo api_url("jadwal_dokter") ?>",
            dataType: 'json',
            type: 'POST',
            data: function(term) {
                return {
                    term: term.term,
                    id_poli: id_poli
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.nama_dokter,
                            id: item.id_dokter,
                            other: item,
                        }
                    })
                };
            },
        },
        templateResult: formatDokter,

    });

    $('#id_rekamedis').on('select2:select', function(e) {
        var data = e.params.data;

        let id = data.id;
        let no_kartu = data.other.no_kartu;
        let no_rekamedis = data.other.no_rekamedis;

        if (id === "0") {
            $("#no_kartu_div").hide();
            $("#no_rm_div").hide();
            $(".pasien-input").show();
            $("#no_kartu_ro").val("");
            $("#no_rm_ro").val("");
        } else {
            $("#no_kartu_div").show();
            $("#no_rm_div").show();
            $(".pasien-input").hide();
            $("#no_kartu_ro").val(no_kartu);
            $("#no_rm_ro").val(no_rekamedis);
        }
    });

    $('#id_poli').on('select2:select', function(e) {
        var data = e.params.data;

        id_poli = data.id;

        $(".col-dokter").show();
        $("#id_pj_dokter").empty();
    });
</script>