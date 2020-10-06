<?php
defined('BASEPATH') or exit('No direct script access allowed');
?>

<div class="content-wrapper">
    <section class="content-header">
        <h1>
            Formulir Pendaftaran Pasien
        </h1>
    </section>
    <section class="content">
        <form class="form-horizontal" action="<?php echo $action; ?>" method="post">
            <div class="row">
                <div class="col-lg-6">
                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">DATA PENDAFTARAN PASIEN</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Tanggal pendaftaran</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control datepicker" placeholder="Masukkan tanggal pendaftaran" value="<?php echo $tgl_daftar; ?>" required readonly />
                                    <input type="hidden" name="tgl_daftar" id="tgl_daftar" value="<?php echo $tgl_daftar; ?>">
                                    <span id="tgl_daftar" class="help-block text-danger"><?= form_error('tgl_daftar') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Cara masuk</label>
                                <div class="col-sm-9">
                                    <?php echo cmb_dinamis('id_cara_masuk', 'tbl_pasien_cara_masuk', 'nama_cara_masuk', 'id', $id_cara_masuk) ?>
                                    <span class="help-block text-danger"><?= form_error('id_cara_masuk') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Pilih poliklinik</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="id_poli" id="id_poli" style="width: 100% !important" required></select>
                                    <span class="help-block text-danger"><?= form_error('id_poli') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback col-dokter">
                                <label class="control-label col-sm-3">Pilih dokter</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="id_pj_dokter" id="id_pj_dokter" style="width: 100% !important" required></select>
                                    <span class="help-block text-danger"><?= form_error('id_pj_dokter') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Jenis bayar</label>
                                <div class="col-sm-9">
                                    <?php echo cmb_dinamis('id_jenis_bayar', 'tbl_jenis_bayar', 'jenis_bayar', 'id', $id_cara_masuk) ?>
                                    <span class="help-block text-danger"><?= form_error('id_jenis_bayar') ?></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">DATA PASIEN & PENANGGUNGJAWAB</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Nama pasien</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="id_rekamedis" id="id_rekamedis" style="width: 100% !important"></select>
                                    <span id="id_rekamedis" class="help-block text-danger"><?= form_error('id_rekamedis') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback" id="no_kartu_div">
                                <label class="control-label col-sm-3">Nomor kartu anggota</label>
                                <div class="col-sm-9">
                                    <input type="text" id="no_kartu_ro" class="form-control" readonly />
                                </div>
                            </div>

                            <div class="form-group has-feedback" id="no_rm_div">
                                <label class="control-label col-sm-3">Nomor rekam medis</label>
                                <div class="col-sm-9">
                                    <input type="text" id="no_rm_ro" class="form-control" readonly />
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Nama Penanggungjawab</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="nama_pj" id="nama_pj" placeholder="Masukkan nama penanggungjawab" value="<?php echo $nama_pj; ?>" aria-describedby="nama_pj" required />
                                    <span id="nama_pj" class="help-block text-danger"><?= form_error('nama_pj') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Hubungan dengan pasien</label>
                                <div class="col-sm-9">
                                    <?php echo cmb_dinamis('id_hub_dg_pj', 'tbl_pasien_hub_pj', 'nama_hub_pj', 'id', $id_hub_dg_pj) ?>
                                    <span class="help-block text-danger"><?= form_error('id_hub_dg_pj') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Alamat Penanggungjawab</label>
                                <div class="col-sm-9">
                                    <textarea class="form-control" name="alamat_pj" id="alamat_pj" placeholder="Masukkan alamat penanggungjawab" value="<?php echo $alamat_pj; ?>" aria-describedby="alamat_pj" required></textarea>
                                    <span id="alamat_pj" class="help-block text-danger"><?= form_error('alamat_pj') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Nomor KTP/SIM/KITAS Penanggungjawab</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="no_identitas_pj" id="no_identitas_pj" placeholder="Masukkan Nomor KTP/SIM/KITAS Penanggungjawab" value="<?php echo $no_identitas_pj; ?>" aria-describedby="no_identitas_pj" required />
                                    <span id="no_identitas_pj" class="help-block text-danger"><?= form_error('no_identitas_pj') ?></span>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-lg-6 pasien-input">
                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">DATA PRIBADI PASIEN</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Nomor kartu anggota</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="no_kartu" id="no_kartu" placeholder="Nomor kartu" value="<?php echo $no_kartu; ?>" aria-describedby="no_kartu" />
                                    <span id="no_kartu" class="help-block text-danger"><?= form_error('no_kartu') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Nama pasien</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="nama_pasien" id="nama_pasien" placeholder="Nama pasien" value="<?php echo $nama_pasien; ?>" aria-describedby="nama_pasien" />
                                    <span id="nama_pasien" class="help-block text-danger"><?= form_error('nama_pasien') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Agama</label>
                                <div class="col-sm-9">
                                    <?php echo cmb_dinamis('id_agama', 'tbl_agama', 'agama', 'id', $id_agama) ?>
                                    <span class="help-block text-danger"><?= form_error('id_agama') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Status Pernikahan</label>
                                <div class="col-sm-9">
                                    <?php echo cmb_dinamis('id_status_pernikahan', 'tbl_status_menikah', 'nama_status_menikah', 'id', $id_status_pernikahan) ?>
                                    <span class="help-block text-danger"><?= form_error('id_status_pernikahan') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Tempat Lahir</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="tempat_lahir" id="tempat_lahir" placeholder="Tempat lahir" value="<?php echo $tempat_lahir; ?>" aria-describedby="tempat_lahir" />
                                    <span id="tempat_lahir" class="help-block text-danger"><?= form_error('tempat_lahir') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Tanggal lahir</label>
                                <div class="col-sm-9">
                                    <input type="date" class="form-control" name="tgl_lahir" id="tgl_lahir" placeholder="Tanggal lahir" value="<?php echo $tgl_lahir; ?>" aria-describedby="tgl_lahir" />
                                    <span id="tgl_lahir" class="help-block text-danger"><?= form_error('tgl_lahir') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Jenis Kelamin</label>
                                <div class="col-sm-9">
                                    <?= cmb_dinamis("id_jenis_kelamin", "tbl_jenis_kelamin", "nama_jk", "id", $id_jenis_kelamin) ?>
                                    <span id="id_jenis_kelamin" class="help-block text-danger"><?= form_error('id_jenis_kelamin') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Pekerjaan</label>
                                <div class="col-sm-9">
                                    <?php echo cmb_dinamis('id_pekerjaan', 'tbl_pekerjaan', 'nama_pekerjaan', 'id', $id_agama) ?>
                                    <span class="help-block text-danger"><?= form_error('id_pekerjaan') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Alamat</label>
                                <div class="col-sm-9">
                                    <textarea class="form-control" name="alamat" id="alamat" placeholder="Alamat" value="<?php echo $alamat; ?>" aria-describedby="alamat"></textarea>
                                    <span id="alamat" class="help-block text-danger"><?= form_error('alamat') ?></span>
                                </div>
                            </div>

                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">No. telepon</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="no_telepon" id="no_telepon" placeholder="Nomor telepon" value="<?php echo $no_telepon; ?>" aria-describedby="no_telepon" />
                                    <span id="no_telepon" class="help-block text-danger"><?= form_error('no_telepon') ?></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 pasien-input">
                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">DATA KELUARGA PASIEN</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Nama Ibu</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="nama_ibu" id="nama_ibu" placeholder="Nama Ibu" value="<?php echo $nama_ibu; ?>" aria-describedby="nama_ibu" />
                                    <span id="nama_ibu" class="help-block text-danger"><?= form_error('nama_ibu') ?></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 pasien-input">
                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">DATA MEDIS PASIEN</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Golongan Darah</label>
                                <div class="col-sm-9">
                                    <?= cmb_dinamis('id_gol_darah', 'tbl_gol_darah', 'nama_gol_darah', 'id', $id_gol_darah) ?>
                                    <span class="help-block text-danger"><?= form_error('id_gol_darah') ?></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 pasien-input">
                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">DATA IDENTITAS PASIEN</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Nomor KTP/SIM/KITAS Pasien</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="no_identitas" id="no_identitas" placeholder="Kode Pegawai" value="<?php echo $no_identitas; ?>" />
                                    <span class="help-block text-danger"><?= form_error('no_identitas') ?></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">AKSI</h3>
                        </div>
                        <div class="box-body">
                            <?= hidden("id", $id) ?>

                            <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i>&nbsp;<?php echo $button ?></button>
                            <a href="<?php echo site_url('Pegawai') ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </section>
</div>