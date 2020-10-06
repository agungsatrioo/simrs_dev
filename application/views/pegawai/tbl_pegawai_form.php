<?php
defined('BASEPATH') or exit('No direct script access allowed');
?>

<div class="content-wrapper">
    <section class="content-header">
        <h1>
            Formulir Data Pegawai
        </h1>
    </section>
    <section class="content">
        <form class="form-horizontal" action="<?php echo $action; ?>" method="post">
            <div class="row">
                <div class="col-lg-6">
                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">DATA PRIBADI PEGAWAI</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">NIK Pegawai</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="nik" id="nik" placeholder="Kode Pegawai" value="<?php echo $nik; ?>" required />
                                    <span class="help-block text-danger"><?= form_error('nik') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Nomor KTP/SIM/KITAS Pegawai</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="no_identitas" id="no_identitas" placeholder="Kode Pegawai" value="<?php echo $no_identitas; ?>" required />
                                    <span class="help-block text-danger"><?= form_error('no_identitas') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">NPWP Pegawai</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="npwp" id="npwp" placeholder="No Izin Praktek" value="<?php echo $npwp; ?>" />
                                    <span class="help-block text-danger"><?= form_error('npwp') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Nama Pegawai</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="nama_pegawai" id="nama_pegawai" placeholder="Nama Pegawai" value="<?php echo $nama_pegawai; ?>" required />
                                    <span class="help-block text-danger"><?= form_error('nama_pegawai') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Jenis Kelamin</label>
                                <div class="col-sm-9">
                                    <?= cmb_dinamis("id_jenis_kelamin", "tbl_jenis_kelamin", "nama_jk", "id", $id_jenis_kelamin) ?>
                                    <span class="help-block text-danger"><?= form_error('id_jenis_kelamin') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Tempat Lahir</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="tempat_lahir" id="tempat_lahir" placeholder="Tempat Lahir" value="<?php echo $tempat_lahir; ?>" />
                                    <span class="help-block text-danger"><?= form_error('tempat_lahir') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Tanggal Lahir</label>
                                <div class="col-sm-9">
                                    <input type="date" class="form-control" name="tgl_lahir" id="tgl_lahir" placeholder="Tanggal Lahir" value="<?php echo $tgl_lahir; ?>" />
                                    <span class="help-block text-danger"><?= form_error('tgl_lahir') ?></span>
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
                                <label class="control-label col-sm-3">Golongan Darah</label>
                                <div class="col-sm-9">
                                    <?= cmb_dinamis('id_gol_darah', 'tbl_gol_darah', 'nama_gol_darah', 'id', $id_gol_darah) ?>
                                    <span class="help-block text-danger"><?= form_error('id_gol_darah') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Status Pernikahan</label>
                                <div class="col-sm-9">
                                    <?php echo cmb_dinamis('id_status_menikah', 'tbl_status_menikah', 'nama_status_menikah', 'id', $id_status_menikah) ?>
                                    <span class="help-block text-danger"><?= form_error('id_status_menikah') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Alamat Saat Ini</label>
                                <div class="col-sm-9">
                                    <textarea class="form-control" rows="3" name="alamat" id="alamat" placeholder="Alamat Tinggal"><?php echo $alamat; ?></textarea> <span class="help-block text-danger"><?= form_error('alamat') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Nomor Telepon</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="no_telepon" id="no_telepon" placeholder="No Hp" value="<?php echo $no_telepon; ?>" required />
                                    <span class="help-block text-danger"><?= form_error('no_telepon') ?></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">DATA PENDIDIKAN PEGAWAI</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Pendidikan terakhir</label>
                                <div class="col-sm-9">
                                    <?php echo cmb_dinamis('id_jenjang_pendidikan', 'tbl_jenjang_pendidikan', 'jenjang_pendidikan', 'id', $id_jenjang_pendidikan) ?>
                                    <span class="help-block text-danger"><?= form_error('id_jenjang_pendidikan') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Alumni</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="alumni" id="alumni" placeholder="Alumni" value="<?php echo $alumni; ?>" />
                                    <span class="help-block text-danger"><?= form_error('alumni') ?></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">DATA KARIR PEGAWAI</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Departemen</label>
                                <div class="col-sm-9">
                                    <?php echo cmb_dinamis('id_departemen', 'tbl_pegawai_departemen', 'nama_departemen', 'id', $id_departemen) ?>
                                    <span class="help-block text-danger"><?= form_error('id_departemen') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Jenjang</label>
                                <div class="col-sm-9">
                                    <?php echo cmb_dinamis('id_jenjang', 'tbl_jenjang', 'nama_jenjang', 'id', $id_jenjang) ?>
                                    <span class="help-block text-danger"><?= form_error('id_jenjang') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Bidang</label>
                                <div class="col-sm-9">
                                    <?php echo cmb_dinamis('id_bidang', 'tbl_pegawai_bidang', 'nama_bidang', 'id', $id_bidang) ?>
                                    <span class="help-block text-danger"><?= form_error('id_bidang') ?></span>
                                </div>
                            </div>
                            <div class="form-group has-feedback">
                                <label class="control-label col-sm-3">Jabatan Saat ini</label>
                                <div class="col-sm-9">
                                    <?php echo cmb_dinamis('id_jabatan', 'tbl_pegawai_jabatan', 'nama_jabatan', 'id', $id_jabatan) ?>
                                    <span class="help-block text-danger"><?= form_error('id_jabatan') ?></span>
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