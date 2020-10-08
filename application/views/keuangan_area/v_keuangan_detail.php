<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');
?>

<div class="content-wrapper">
    <section class="content">
        <?= $callout ?>
        <div class="row">
            <div class="col-lg-6">
                <div class="box box-warning box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">DATA PASIEN</h3>
                    </div>
                    <div class="box-body">
                        <div class="row pad row-striped">
                            <div class="col-lg-4"><b>Nomor kartu pasien</b></div>
                            <div class="col-lg-8"><?= $info_pasien->no_kartu ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-4"><b>Nomor rekam medis</b></div>
                            <div class="col-lg-8"><?= $info_pasien->no_rekamedis ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-4"><b>Nama pasien</b></div>
                            <div class="col-lg-8"><?= $info_pasien->nama_pasien ?></div>
                        </div>
                        <hr>
                        <div class="row pad row-striped">
                            <div class="col-lg-4"><b>Tanggal Daftar</b></div>
                            <div class="col-lg-8"><?= $info_pasien->tgl_daftar ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-4"><b>Cara masuk</b></div>
                            <div class="col-lg-8"><?= $info_pasien->nama_cara_masuk ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-4"><b>Poliklinik Tujuan</b></div>
                            <div class="col-lg-8"><?= $info_pasien->nama_poliklinik ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-4"><b>Nama dokter penanggungjawab</b></div>
                            <div class="col-lg-8"><?= $info_pasien->nama_dokter ?></div>
                        </div>

                        <?php if (!empty($info_pasien->id_ruang_ranap)) { ?>
                            <hr>
                            <div class="row pad row-striped">
                                <div class="col-lg-4"><b>Nama ruangan rawat inap</b></div>
                                <div class="col-lg-8"><?= $info_pasien->nama_ruangan ?></div>
                            </div>
                            <div class="row pad row-striped">
                                <div class="col-lg-4"><b>Tanggal keluar</b></div>
                                <div class="col-lg-8"><?= $info_pasien->tanggal_keluar ?></div>
                            </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="box box-warning box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">TINDAKAN</h3>
                    </div>
                    <div class="box-body form-horizontal">
                        <div class="row pad">
                            <div class="col-lg-4">
                                <a href="<?= sprintf($mutasi_url, $info_pasien->id) ?>" class="btn btn-primary form-control">Lihat mutasi</a>
                            </div>

                        </div>
                        <div class="row pad">

                        </div>
                    </div>
                </div>
                <div class="box box-warning box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">DATA PENANGGUNGJAWAB PASIEN</h3>
                    </div>
                    <div class="box-body form-horizontal">
                        <div class="row pad row-striped">
                            <div class="col-lg-4"><b>Nama penanggungjawab</b></div>
                            <div class="col-lg-8"><?= $info_pasien->nama_pj ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-4"><b>Alamat penanggungjawab</b></div>
                            <div class="col-lg-8"><?= $info_pasien->alamat_pj ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-4"><b>Nomor identitas penanggungjawab</b></div>
                            <div class="col-lg-8"><?= $info_pasien->no_identitas_pj ?></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">RIWAYAT PEMBERIAN TINDAKAN</h3>
            </div>
            <div class="box-body form-horizontal">
                <table class="table table-bordered" style="margin-bottom: 10px" id="tbl_riwayat_tindakan">
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>Tanggal</th>
                            <th>Nama Tindakan</th>
                            <th>Hasil Periksa</th>
                            <th>Perkembangan</th>
                            <th>Status</th>
                            <th>Tarif</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th colspan="6" style="text-align:right">Total</th>
                            <th colspan="2" style="text-align:left"></th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">RIWAYAT PEMBERIAN OBAT</h3>
            </div>
            <div class="box-body form-horizontal">
                <table class="table table-bordered" style="margin-bottom: 10px" id="tbl_riwayat_obat">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Nama Obat</th>
                            <th>Tanggal</th>
                            <th>Status</th>
                            <th>Harga</th>
                            <th>Jumlah</th>
                            <th>Subtotal</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th colspan="6" style="text-align:right">Total</th>
                            <th colspan="2" style="text-align:left"></th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">RIWAYAT PEMBERIAN ALAT KESEHATAN</h3>
            </div>
            <div class="box-body form-horizontal">
                <table class="table table-bordered" style="margin-bottom: 10px" id="tbl_riwayat_alkes">
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>Nama Alat Kesehatan</th>
                            <th>Tanggal</th>
                            <th>Status</th>
                            <th>Harga</th>
                            <th>Jumlah</th>
                            <th>Subtotal</th>
                            <th>Aksi</th>
                        </tr>
                        <thead>
                        <tfoot>
                            <tr>
                                <th colspan="6" style="text-align:right">Total</th>
                                <th colspan="2" style="text-align:left"></th>
                            </tr>
                        </tfoot>
                </table>
            </div>
        </div>

    </section>
</div>