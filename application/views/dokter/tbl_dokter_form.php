<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">INPUT DATA DOKTER</h3>
            </div>
            <div class="box-body">
                <form class="form-horizontal" action="<?php echo $action; ?>" method="post">
                    <div class="form-group has-feedback">
                        <label class="control-label col-sm-3">Kode Dokter</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="kode_dokter" id="kode_dokter" placeholder="Kode Dokter" value="<?php echo $kode_dokter; ?>" required />
                            <span class="help-block text-danger"><?= form_error('kode_dokter') ?></span>
                        </div>
                    </div>

                    <div class="form-group has-feedback">
                        <label class="control-label col-sm-3">Nomor KTP/SIM/KITAS Dokter</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="no_identitas" id="no_identitas" placeholder="Kode Dokter" value="<?php echo $no_identitas; ?>" required />
                            <span class="help-block text-danger"><?= form_error('no_identitas') ?></span>
                        </div>
                    </div>

                    <div class="form-group has-feedback">
                        <label class="control-label col-sm-3">No. Izin Praktik</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="no_izin_praktik" id="no_izin_praktik" placeholder="No Izin Praktek" value="<?php echo $no_izin_praktik; ?>" />
                            <span class="help-block text-danger"><?= form_error('no_izin_praktik') ?></span>
                        </div>
                    </div>

                    <div class="form-group has-feedback">
                        <label class="control-label col-sm-3">Nama Dokter</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="nama_dokter" id="nama_dokter" placeholder="Nama Dokter" value="<?php echo $nama_dokter; ?>" required />
                            <span class="help-block text-danger"><?= form_error('nama_dokter') ?></span>
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

                    <div class="form-group has-feedback">
                        <label class="control-label col-sm-3">Spesialisasi</label>
                        <div class="col-sm-9">
                            <?php echo cmb_dinamis('id_spesialis', 'tbl_dokter_spesialis', 'nama_spesialis', 'id', $id_spesialis) ?>
                            <span class="help-block text-danger"><?= form_error('id_spesialis') ?></span>
                        </div>
                    </div>


                    <div class="form-group has-feedback">
                        <label class="control-label col-sm-3">Alumni</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="alumni" id="alumni" placeholder="Alumni" value="<?php echo $alumni; ?>" />
                            <span class="help-block text-danger"><?= form_error('alumni') ?></span>
                        </div>
                    </div>

                    <?= hidden("id", $id) ?>

                    <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i>&nbsp;<?php echo $button ?></button>
                    <a href="<?php echo site_url('dokter') ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a>
                </form>
            </div>
        </div>
    </section>
</div>