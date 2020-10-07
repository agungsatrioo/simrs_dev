<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">FORMULIR CATATAN HARIAN MEDIS PASIEN</h3>
            </div>
            <div class="box-body form-horizontal">
                <form action="<?= $action ?>" method='post' class="form-horizontal">
                    <div class="form-group has-feedback">
                        <label class="control-label col-sm-2">Isi</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" name="isi" id="isi" placeholder="Masukkan isi lebih lanjut" aria-describedby="isi" required><?php echo $isi; ?></textarea>
                            <span id="isi" class="help-block text-danger"><?= form_error('isi') ?></span>
                            <?= hidden("id", @$id) ?>
                            <?= hidden("id_pendaftaran", $id_pendaftaran) ?>
                        </div>
                    </div>
                    <?= hidden("id", $id) ?>

                    <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i>&nbsp;Simpan</button>
                </form>
            </div>
        </div>
    </section>
</div>