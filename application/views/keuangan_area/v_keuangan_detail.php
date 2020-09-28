<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');
?>

<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">DETAIL PASIEN</h3>
            </div>
            <div class="box-body">
                <?= $callout ?>

                <table class="table table-bordered" style="margin-bottom: 10px">
                    <tr>
                        <td>No Rawat</td>
                        <td><?php echo @$pendaftaran['no_rawat'] ?></td>
                    </tr>
                    <tr>
                        <td>No Rekamedis</td>
                        <td><?php echo @$pendaftaran['no_rekamedis'] ?></td>
                    </tr>
                    <tr>
                        <td>Nama Pasien</td>
                        <td><?php echo @$pendaftaran['nama_pasien'] ?></td>
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
                            <td><?= number2rp($saldo) ?></td>
                        </tr>
                        <tr>
                            <td>Kekurangan biaya</td>
                            <td><code><b><?= $kurangnya ?></b></code></td>
                        </tr>
                    <?php } ?>
                    <tr>
                        <td colspan="2">
                            <?php if ($isRawatInap) { ?>

                                <a href="<?= base_url("keuangan_area/mutasi/" . $no_rawat) ?>" class="btn btn-primary">Lihat mutasi keuangan</a>
                            <?php } ?>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">RIWAYAT PEMBERIAN OBAT</h3>
            </div>
            <div class="box-body">
                <table class="table table-striped" id="tbl_riwayat_obat">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Nama obat</th>
                            <th>Tanggal resep</th>
                            <th>Harga</th>
                            <th>Jumlah</th>
                            <th>Subtotal</th>
                            <th>Status pembayaran</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </section>
</div>