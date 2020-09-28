<div class="content-wrapper">
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-warning box-solid">
                    <div class="box-header">
                        <h3 class="box-title">BIODATA PASIEN</h3>
                    </div>

                    <div class="box-body">
                        <?= $callout ?>
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
                            <?php if ($isRawatInap) { ?>
                                <tr>
                                    <td>Nama Gedung</td>
                                    <td><?php echo $pendaftaran['nama_gedung'] ?></td>
                                </tr>
                                <tr>
                                    <td>Nama Ruangan/Kelas</td>
                                    <td><?php echo $pendaftaran['nama_ruangan'] . "/" . $pendaftaran['nama_kelas_ruang_ranap'] ?></td>
                                </tr>
                                <tr>
                                    <td>Kode tempat tidur</td>
                                    <td><?php echo $pendaftaran['kode_tempat_tidur'] ?></td>
                                </tr>
                                <tr>
                                    <td>Saldo deposit saat ini</td>
                                    <td><?= number2rp($saldo) . "(<a href='" . base_url("pendaftaran/mutasi/" . enc_str($no_rawat)) . "'>Lihat mutasi</a>)" ?></td>
                                </tr>
                                <tr>
                                    <td>Kekurangan biaya</td>
                                    <td><code><b><?= $kurangnya ?></b></code></td>
                                </tr>
                            <?php } ?>
                            <tr>
                                <td colspan="2">
                                    <?php if ($isRawatInap) { ?>
                                        <a href="<?= base_url("pendaftaran/mutasi/" . enc_str($no_rawat)) ?>" class="btn btn-primary">Lihat mutasi keuangan</a>
                                    <?php } ?>
                                    <?php if ($isUGD) { ?>
                                        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#inputUGD2Ranap">Tempatkan di rawat inap</button>
                                    <?php } ?>
                                </td>
                            </tr>
                        </table>

                        <?= $modal_tindakan ?>

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
                        <?= $modal_labor ?>

                        <?= $isUGD ? $modal_ranap : "" ?>
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
                                    <td>" . rupiah($t->tarif) . "</td></tr>";
                                $no++;
                                $total_tarif = $total_tarif + $t->tarif;
                            }
                            ?>
                            <tr>
                                <td colspan="5" class="text-right">Total</td>
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
                        <table class="table table-bordered" style="margin-bottom: 10px" id="tbl_riwayat_obat">
                            <thead>
                                <tr>
                                    <th>NO</th>
                                    <th>Nama Obat Dan Alat Kesehatan</th>
                                    <th>Tanggal</th>
                                    <th>Status</th>
                                    <th>Harga</th>
                                    <th>Jumlah</th>
                                    <th>Subtotal</th>
                                </tr>
                                <thead>
                                <tfoot>
                                    <tr>
                                        <th colspan="6" style="text-align:right">Total</th>
                                        <th></th>
                                    </tr>
                                </tfoot>
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

                        <?php echo anchor('pendaftaran/cetak_riwayat_labor/' . enc_str($no_rawat), 'Cetak Laporan Pemeriksaan Laboratorium', "class='btn btn-danger' target='new'") ?>

                        <br>&nbsp;<br>

                        <table class="table table-bordered" style="margin-bottom: 10px" id="tbl_labor">
                            <thead>
                                <tr>
                                    <th>NO</th>
                                    <th>Nama Pemeriksaan</th>
                                    <th>Satuan</th>
                                    <th>Hasil</th>
                                    <th>Kerangan</th>
                                    <th>Biaya</th>
                                </tr>
                            </thead>
                            <?php
                            $no = 1;
                            $total_periksa_labor = 0;
                            foreach ($riwayat_labor as $r) {
                                $biaya_readable = rupiah($r->tarif);
                                echo "<tr>
                                    <td>$no</td>
                                    <td>$r->nama_periksa</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>$biaya_readable</td>
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
                                <td><b><?php echo rupiah($total_periksa_labor); ?></b></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>


        </div>
    </section>
</div>