<script type="text/javascript">
    var idPoli = "<?php echo $pendaftaran['id_poli'] ?>"
    var kode_periksa;

    $('#kode_kelas').hide();
    $('#kode_ruang').hide();

    function formatItem(item) {

        if (!item.id) {
            return item.text;
        }

        let nama_dokter = item.other.nama_dokter
        let tersedia = item.other.tersedia
        let tersedia_type = tersedia == true ? "Tersedia" : "Tidak tersedia";
        let hari_praktik = item.other.hari
        let jam_praktik = item.other.jam_mulai + "-" + item.other.jam_selesai;

        let template = "<span>" + nama_dokter + " (" + tersedia_type + ")<br><b>Hari praktik: </b>" + hari_praktik + ", " + jam_praktik + "</span>";

        return $(template);
    }

    function formatTindakan(item) {
        if (!item.id) {
            return item.text;
        }

        let nama_tindakan = item.other.nama_tindakan;
        let ket_tindakan = item.other.kategori_tindakan;
        let tarif = item.other.tarif_readable;

        let template = "<span>" + nama_tindakan + " (" + ket_tindakan + ")<br><b>Tarif: </b>" + tarif + "</span>";

        return $(template);
    }

    function formatNamaRuangan(item) {
        if (!item.id) {
            return item.text;
        }

        let nama_gedung = item.other.nama_gedung;
        let nama_ruangan = item.other.nama_ruangan;

        let template = "<span>" + nama_ruangan + "<br><b>Nama gedung: </b>" + nama_gedung + "</span>";

        return $(template);
    }

    $('#id_dokter').select2({
        placeholder: 'Pilih dokter penanggungjawab',
        allowClear: true,
        dropdownParent: $('#periksa_modal'),
        ajax: {
            url: "<?php echo base_url() ?>pendaftaran/autocomplate_dokter",
            dataType: 'json',
            data: function(term) {
                return {
                    term: term.term,
                    id_poli: idPoli
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.nama_dokter,
                            id: item.kode_dokter,
                            other: item
                        }
                    })
                };
            },
        },
        templateResult: formatItem,
    });

    $('#id_petugas').select2({
        placeholder: 'Pilih petugas penanggungjawab',
        allowClear: true,
        dropdownParent: $('#periksa_modal'),
        ajax: {
            url: "<?php echo base_url() ?>pegawai/ajax_pegawai",
            dataType: 'json',
            data: function(term) {
                return {
                    term: term.term,
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.nama_pegawai,
                            id: item.nik,
                            other: item
                        }
                    })
                };
            },
        },
    });

    $('#id_tindakan').select2({
        placeholder: 'Pilih tindakan',
        allowClear: true,
        dropdownParent: $('#periksa_modal'),
        ajax: {
            url: "<?php echo base_url() ?>data_tindakan/autocomplate",
            dataType: 'json',
            data: function(term) {
                return {
                    term: term.term,
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.nama_tindakan,
                            id: item.kode_tindakan,
                            other: item
                        }
                    })
                };
            },
        },
        templateResult: formatTindakan,
    });

    $('#kode_obat').select2({
        placeholder: 'Pilih obat',
        allowClear: true,
        dropdownParent: $('#inputObat'),
        ajax: {
            url: "<?php echo base_url() ?>dataobat/ajax",
            dataType: 'json',
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

    /**
     */

    $('#kode_periksa').select2({
        placeholder: 'Pilih nama pemeriksaan',
        allowClear: true,
        dropdownParent: $('#inputLabor'),
        ajax: {
            url: "<?php echo base_url() ?>periksalabor/ajax",
            dataType: 'json',
            data: function(term) {
                return {
                    term: term.term,
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.nama_periksa,
                            id: item.kode_periksa,
                            other: item
                        }
                    })
                };
            },
        },
    });

    $('#kode_periksa').on('select2:select', function(e) {
        var data = e.params.data;

        kode_periksa = data.id;

        $.ajax({
            url: "<?php echo base_url('pendaftaran/sub_periksa_labor_ajax') ?>",
            data: "kode_periksa=" + kode_periksa,
            success: function(html) {
                $("#sub_periksa_labor").html(html);
            }
        });
    });

    <?php if ($isUGD) { ?>
        var kode_gedung;
        var kode_kelas;
        var kode_ruangan;

        $('#kode_gedung').select2({
            placeholder: 'Pilih gedung rawat inap',
            allowClear: true,
            dropdownParent: $('#inputUGD2Ranap'),
            ajax: {
                url: "<?php echo base_url("gedung/ajax_gedung") ?>",
                dataType: 'json',
                data: function(term) {
                    return {
                        term: term.term,
                    };
                },
                processResults: function(data) {
                    return {
                        results: $.map(data, function(item) {
                            return {
                                text: item.nama_gedung,
                                id: item.kode_gedung_rawat_inap,
                                other: item
                            }
                        })
                    };
                },
            },
        });

        $('#kode_kelas').select2({
            placeholder: 'Pilih kelas rawat inap',
            allowClear: true,
            dropdownParent: $('#inputUGD2Ranap'),
            ajax: {
                url: "<?php echo base_url("ruangranap/ajax_kelas_select2") ?>",
                dataType: 'json',
                type: 'post',
                data: function(term) {
                    return {
                        term: term.term,
                        kode_gedung: kode_gedung
                    };
                },
                processResults: function(data) {
                    return {
                        results: $.map(data, function(item) {
                            return {
                                text: item.nama_kelas_ruang_ranap,
                                id: item.kode_kelas,
                                other: item
                            }
                        })
                    };
                },
            },
        });

        $('#kode_ruang').select2({
            placeholder: 'Pilih ruang rawat inap',
            allowClear: true,
            dropdownParent: $('#inputUGD2Ranap'),
            ajax: {
                url: "<?php echo base_url("ruangranap/ajax_ruangan") ?>",
                dataType: 'json',
                type: 'post',
                data: function(term) {
                    return {
                        term: term.term,
                        kode_gedung: kode_gedung,
                        kode_kelas: kode_kelas
                    };
                },
                processResults: function(data) {
                    return {
                        results: $.map(data, function(item) {
                            return {
                                text: item.nama_ruangan,
                                id: item.kode_ruang_rawat_inap,
                                other: item
                            }
                        })
                    };
                },
            },
        });

        $('#kode_gedung').on('select2:select', function(e) {
            var data = e.params.data;

            kode_gedung = data.id;
            $('#kode_kelas').show();

        });

        $('#kode_kelas').on('select2:select', function(e) {
            var data = e.params.data;

            kode_kelas = data.id;
            $('#kode_ruang').show();

        });

        $('#kode_ruang').on('select2:select', function(e) {
            var data = e.params.data;

            kode_ruangan = data.id;
            console.log(kode_ruangan);

            $.ajax({
                url: "<?php echo base_url("ruangranap/ajax_kasur") ?>",
                data: {
                    id: kode_ruangan
                },
                type: "GET",
                dataType: "html",
                success: function(data) {
                    console.log("horee")
                    $("#tempat_tidur_table").html(data)
                },
                error: function(xhr, status) {
                    alert("Sorry, there was a problem!");
                },
            });
        });
    <?php } ?>


    function sub_periksa_labor() {
        /*var nama_periksa_labor = $("#txt_periksa_labor").val();
        $.ajax({
            url: "<?php echo base_url(); ?>pendaftaran/sub_periksa_labor_ajax",
            data: "nama_periksa=" + nama_periksa_labor,
            success: function(html) {
                $("#sub_periksa_labor").html(html);
            }
        });*/
    }
</script>