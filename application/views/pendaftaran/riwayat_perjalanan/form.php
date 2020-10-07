<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">FORMULIR RIWAYAT PERJALANAN PASIEN</h3>
            </div>
            <div class="box-body form-horizontal">
                <form action="<?= $action ?>" method='post' class="form-horizontal">
                    <div class="form-group has-feedback">
                        <label class="control-label col-sm-2">Tanggal berangkat</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="tgl_input" id="tgl_input" placeholder="Masukkan tanggal di sini" required readonly />
                            <?= hidden("tgl_berangkat", $tgl_berangkat) ?>
                            <?= hidden("tgl_pulang", $tgl_pulang) ?>
                            <?= hidden("id", $id) ?>
                            <?= hidden("id_pendaftaran", $id_pendaftaran) ?>
                            <?= hidden("id_rekamedis", $id_rekamedis) ?>
                        </div>
                    </div>
                    <div class="form-group has-feedback">
                        <label class="control-label col-sm-2">Keterangan</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" name="keterangan" id="keterangan" placeholder="Masukkan keterangan lebih lanjut" aria-describedby="keterangan" required><?php echo $keterangan; ?></textarea>
                            <span id="keterangan" class="help-block text-danger"><?= form_error('keterangan') ?></span>
                        </div>
                    </div>
                    <?= hidden("id", $id) ?>

                    <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i>&nbsp;Simpan</button>
                </form>
            </div>
        </div>
    </section>
</div>