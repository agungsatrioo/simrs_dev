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
                            <div class="col-lg-3"><b>Nomor kartu pasien</b></div>
                            <div class="col-lg-9"><?= $info_pasien->no_kartu ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-3"><b>Nomor rekam medis</b></div>
                            <div class="col-lg-9"><?= $info_pasien->no_rekamedis ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-3"><b>Nama pasien</b></div>
                            <div class="col-lg-9"><?= $info_pasien->nama_pasien ?></div>
                        </div>
                        <hr>
                        <div class="row pad row-striped">
                            <div class="col-lg-3"><b>Tanggal Daftar</b></div>
                            <div class="col-lg-9"><?= $info_pasien->tgl_daftar ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-3"><b>Cara masuk</b></div>
                            <div class="col-lg-9"><?= $info_pasien->nama_cara_masuk ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-3"><b>Poliklinik Tujuan</b></div>
                            <div class="col-lg-9"><?= $info_pasien->nama_poliklinik ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-3"><b>Nama dokter penanggungjawab</b></div>
                            <div class="col-lg-9"><?= $info_pasien->nama_dokter ?></div>
                        </div>
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
                                <a href="<?= base_url("pendaftaran/mutasi/{$info_pasien->id}") ?>" class="btn btn-primary form-control">Lihat mutasi</a>
                            </div>
                            <div class="col-lg-4">
                                <a href="#" class="btn btn-default form-control">Riwayat p'jalanan</a>
                            </div>
                            <div class="col-lg-4">
                                <a href="#" class="btn btn-default form-control">Catatan medis</a>
                            </div>
                        </div>
                        <div class="row pad">
                            <div class="col-lg-6">
                                <a href="#" class="btn btn-danger form-control">Pindahkan ke rawat inap</a>
                            </div>
                            <div class="col-lg-6">
                                <a href="#" class="btn btn-danger form-control">Ubah status rawat</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box box-warning box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">DATA PENANGGUNGJAWAB PASIEN</h3>
                    </div>
                    <div class="box-body form-horizontal">
                        <div class="row pad row-striped">
                            <div class="col-lg-3"><b>Nama penanggungjawab</b></div>
                            <div class="col-lg-9"><?= $info_pasien->nama_pj ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-3"><b>Alamat penanggungjawab</b></div>
                            <div class="col-lg-9"><?= $info_pasien->alamat_pj ?></div>
                        </div>
                        <div class="row pad row-striped">
                            <div class="col-lg-3"><b>Nomor identitas penanggungjawab</b></div>
                            <div class="col-lg-9"><?= $info_pasien->no_identitas_pj ?></div>
                        </div>
                    </div>
                </div>
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
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th colspan="6" style="text-align:right">Total</th>
                            <th></th>
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
        <?= $modal_obat ?>
        <?= $modal_alkes ?>
    </section>
</div>