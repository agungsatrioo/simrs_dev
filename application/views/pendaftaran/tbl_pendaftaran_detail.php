<div class="content-wrapper">
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-warning box-solid">
                    <div class="box-header">
                        <h3 class="box-title">BIODATA PASIEN</h3>
                    </div>

                    <div class="box-body">
                        <table class="table table-bordered" style="margin-bottom: 10px">
                            <tr>
                                <td>No Rawat</td>
                                <td><?php echo $pendaftaran['no_rawat'] ?></td>
                            </tr>
                            <tr>
                                <td>No Rekamedis</td>
                                <td><?php echo $pendaftaran['no_rekamedis'] ?></td>
                            </tr>
                            <tr>
                                <td>Nama Pasien</td>
                                <td><?php echo $pendaftaran['nama_pasien'] ?></td>
                            </tr>
                        </table>

                        <div class="modal fade" id="periksa_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                            <div class="modal-dialog modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="myModalLabel">Input Tindakan</h4>
                                    </div>
                                    <div class="modal-body">
                                        <?php echo form_open('pendaftaran/periksa_action') ?>
                                        <table class="table table-bordered">
                                            <input value="<?php echo $no_rawat; ?>" type="hidden" name="no_rawat">
                                            <tr>
                                                <td width="200">Dilakukan Oleh</td>
                                                <td>
                                                    <?=
                                                        cmb_dinamis('id_pj_riwayat_tindakan', 'tbl_pj_riwayat_tindakan', 'nama_pj_riwayat_tindakan', 'id_pj_riwayat_tindakan', @$id_pj_riwayat_tindakan);
                                                    ?>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Nama Tindakan</td>
                                                <td>
                                                    <select class="form-control" name="id_tindakan" id="id_tindakan" placeholder="Masukan Nama Tindakan" style="width: 100% !important" required>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Hasil Periksa</td>
                                                <td><input type="text" required name="hasil_periksa" placeholder="masukan hasil Periksa" class="form-control"></td>
                                            </tr>
                                            <tr>
                                                <td>Perkembangan</td>
                                                <td><input type="text" required name="perkembangan" placeholder="masukan perkembangan sekarang" class="form-control"></td>
                                            </tr>
                                        </table>
                                        <div class="dokter">
                                            <table class="table table-bordered">
                                                <tr>
                                                    <td width="200">Masukan Nama Dokter</td>
                                                    <td>
                                                        <select class="form-control" name="id_dokter" id="id_dokter" placeholder="Masukan Nama Dokter" style="width: 100% !important" required>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="petugas">
                                            <table class="table table-bordered">
                                                <tr>
                                                    <td width="200">Masukan Petugas</td>
                                                    <td>
                                                        <select class="form-control" name="id_petugas" id="id_petugas" placeholder="Masukan Nama Petugas" style="width: 100% !important" required>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Tutup</button>
                                        <button type="submit" class="btn btn-primary">Simpan Data</button>
                                    </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Form Input Obat -->

                        <!-- Modal -->
                        <div id="inputObat" class="modal fade" role="dialog">
                            <div class="modal-dialog modal-lg">

                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Form Pemberian Obat</h4>
                                    </div>
                                    <?php echo form_open('pendaftaran/beriobat_action'); ?>
                                    <div class="modal-body">
                                        <input value="<?php echo $no_rawat; ?>" type="hidden" name="no_rawat">
                                        <table class="table table-bordered">
                                            <tr>
                                                <td>Cari Obat</td>
                                                <td>
                                                    <select class="form-control" name="kode_obat" id="kode_obat" placeholder="Masukan nama obat" style="width: 100% !important" required>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Qty</td>
                                                <td><input type="number" name="qty" placeholder="Qty" class="form-control"></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-danger">Simpan</button>
                                    </div>
                                </div>
                                </form>

                            </div>
                        </div>

                        <!-- Form Input Labor -->

                        <!-- Modal -->
                        <div id="inputLabor" class="modal fade" role="dialog">
                            <div class="modal-dialog modal-lg">

                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Form Input Hasil Pemeriksaan Laboratorium</h4>
                                    </div>
                                    <?php echo form_open('pendaftaran/periksa_labor_action'); ?>
                                    <input value="<?php echo $no_rawat; ?>" type="hidden" name="no_rawat">
                                    <div class="modal-body">
                                        <input value="<?php echo $no_rawat; ?>" type="hidden" name="no_rawat">
                                        <table class="table table-bordered">
                                            <tr>
                                                <td>Pemeriksaan</td>
                                                <td><input type="text" name="nama_periksa" id="txt_periksa_labor" onkeyup="periksa_labor()" placeholder="Masukan Nama Pemeriksaan" class="form-control"></td>
                                            </tr>

                                        </table>
                                        <div id="sub_periksa_labor">

                                        </div>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-danger">Simpan</button>
                                    </div>
                                </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xs-12">
                <div class="box box-warning box-solid">
                    <div class="box-header">
                        <h3 class="box-title">RIWAYAT TINDAKAN</h3>

                    </div>

                    <div class="box-body">
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#periksa_modal">
                            Input Tindakan
                        </button>
                        <br>&nbsp;<br>

                        <table class="table table-bordered" style="margin-bottom: 10px">
                            <tr>
                                <th>NO</th>
                                <th>Tindakan</th>
                                <th>Hasil Periksa</th>
                                <th>Perkembangan</th>
                                <th>Tanggal</th>
                                <th>tarif</th>
                            </tr>
                            <?php
                            $no = 1;
                            $total_tarif = 0;
                            foreach ($tindakan as $t) {
                                echo "<tr>
                                    <td>$no</td>
                                    <td>$t->nama_tindakan</td>
                                    <td>$t->hasil_periksa</td>
                                    <td>$t->perkembangan</td>
                                    <td>$t->tanggal</td>
                                    <td>".rupiah($t->tarif)."</td></tr>";
                                $no++;
                                $total_tarif = $total_tarif + $t->tarif;
                            }
                            ?>
                            <tr>
                                <td colspan="5" align="right">Total</td>
                                <td><b><?php echo rupiah($total_tarif); ?></b></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>



            <div class="col-xs-12">
                <div class="box box-warning box-solid">
                    <div class="box-header">
                        <h3 class="box-title">RIWAYAT PEMBERIAN OBAT</h3>

                    </div>

                    <div class="box-body">
                        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#inputObat">Input Obat</button>
                        <br>&nbsp;<br>

                        <table class="table table-bordered" style="margin-bottom: 10px">
                            <tr>
                                <th>NO</th>
                                <th>Nama Obat Dan Alat Kesehatan</th>
                                <th>Tanggal</th>
                                <th>Jumlah</th>
                                <th>Status</th>
                                <th>Harga</th>
                                <th>Subtotal</th>
                            </tr>
                            <?php
                            $no = 1;
                            $total_biaya_obat = 0;
                            
                            foreach ($riwayat_obat as $r) {
                                echo "<tr>
                                    <td>$no</td>
                                    <td>$r->nama_barang</td>
                                    <td>$r->tanggal</td>
                                    <td>$r->jumlah</td>
                                    <td>$r->status_acc</td>
                                    <td>" . rupiah($r->harga) . "</td>
                                    <td>" . rupiah($r->harga * $r->jumlah) . "</td>
                                        </tr>";
                                $no++;
                                $total_biaya_obat = ($total_biaya_obat + ($r->harga * $r->jumlah));
                            }
                            ?>
                            <tr>
                                <td colspan="6" class='text-right'>Total</td>
                                <td><b><?php echo rupiah($total_biaya_obat); ?></b></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-xs-12">
                <div class="box box-warning box-solid">
                    <div class="box-header">
                        <h3 class="box-title">RIWAYAT PEMERIKSAAN LABORATORIUM</h3>

                    </div>

                    <div class="box-body">
                        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#inputLabor">Pemeriksaan Laboratorium</button>
                        <?php echo anchor('pendaftaran/cetak_riwayat_labor/' . $no_rawat, 'Cetak Laporan Pemeriksaan Laboratorium', "class='btn btn-danger' target='new'") ?>
                        <br>&nbsp;<br>
                        <table class="table table-bordered" style="margin-bottom: 10px">
                            <tr>
                                <th>NO</th>
                                <th>Nama Pemeriksaan</th>
                                <th>Satuan</th>
                                <th>Hasil</th>
                                <th>Kerangan</th>
                                <th>Biaya</th>
                            </tr>
                            <?php
                            $no = 1;
                            $total_periksa_labor = 0;
                            foreach ($riwayat_labor as $r) {
                                echo "<tr>
                                    <td>$no</td>
                                    <td>$r->nama_periksa</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>$r->tarif</td>
                                    </tr>";

                                $sub_periksa_sql = "SELECT ts.nama_pemeriksaan,ts.satuan,ts.nilai_rujukan,td.hasil,td.keterangan 
                                                FROM tbl_sub_pemeriksaan_laboratoirum  as ts, tbl_riwayat_pemeriksaan_laboratorium_detail as td
                                                WHERE td.kode_sub_periksa=ts.kode_sub_periksa 
                                                and td.id_rawat=$r->id_riwayat";
                                $sub_periksa = $this->db->query($sub_periksa_sql)->result();
                                foreach ($sub_periksa as $s) {
                                    echo "<tr>
                                    <td></td><td>$s->nama_pemeriksaan</td>
                                        
                                    <td>$s->satuan</td>
                                    <td>$s->hasil</td>
                                    <td>$s->keterangan</td>
                                    <td></td>
                                    </tr>";
                                }

                                $no++;
                                $total_periksa_labor = $total_periksa_labor + $r->tarif;
                            }
                            ?>
                            <tr>
                                <td colspan="5" class="text-right">Total</td>
                                <td><b><?php echo $total_periksa_labor; ?></b></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>


        </div>
    </section>
</div>

<script src="<?php echo base_url('assets/js/jquery-1.11.2.min.js') ?>"></script>
<script src="<?php echo base_url('assets/datatables/jquery.dataTables.js') ?>"></script>
<script src="<?php echo base_url('assets/datatables/dataTables.bootstrap.js') ?>"></script>
<script src="<?php echo base_url('assets/select2/js/select2.min.js') ?>"></script>


<script type="text/javascript">
    var idPoli = "<?php echo $pendaftaran['id_poli'] ?>"

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

    function pemberi_tindakan() {
        var tindakan_oleh = $('#tindakan_oleh').val();
        $.ajax({
            url: "<?php echo base_url(); ?>index.php/pendaftaran/pemberi_tindakan_ajax",
            data: "tindakan_oleh=" + tindakan_oleh,
            success: function(html) {
                $(".tindakan_by").html(html);
            }
        });
    }

    function periksa_labor() {
        //autocomplete tindakan
        $("#txt_periksa_labor").autocomplete({
            source: "<?php echo base_url() ?>/index.php/periksalabor/autocomplate",
            minLength: 1
        });
        sub_periksa_labor();
    }

    function sub_periksa_labor() {
        var nama_periksa_labor = $("#txt_periksa_labor").val();
        $.ajax({
            url: "<?php echo base_url(); ?>index.php/pendaftaran/sub_periksa_labor_ajax",
            data: "nama_periksa=" + nama_periksa_labor,
            success: function(html) {
                $("#sub_periksa_labor").html(html);
            }
        });
    }
</script>

<script type="text/javascript">
    $(function() {
        //autocomplete tindakan
        $("#txt_cari_tindakan").autocomplete({
            source: "<?php echo base_url() ?>data_tindakan/autocomplate",
            minLength: 1
        });
    });
</script>