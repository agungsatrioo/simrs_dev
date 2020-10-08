<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">FORMULIR PERUBAHAN KUANTITAS OBAT/ALAT KESEHATAN</h3>
            </div>
            <div class="box-body form-horizontal">
                <form action="<?= @$action ?>" method='post' class="form-horizontal">
                    <div class="form-group has-feedback">
                        <label class="control-label col-sm-3">Nama obat</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="nama_barang" id="nama_barang"  value="<?php echo $nama_barang; ?>" aria-describedby="nama_barang" min="1" required readonly />
                            <span id="nama_barang" class="help-block text-danger"><?= form_error('nama_barang') ?></span>
                        </div>
                    </div>

                    <div class="form-group has-feedback">
                        <label class="control-label col-sm-3">Jumlah saat ini</label>
                        <div class="col-sm-9">
                            <input type="number" class="form-control" name="qty" id="qty" placeholder="Masukkan jumlah saat ini" value="<?php echo $qty; ?>" aria-describedby="qty" min="1" required />
                            <span id="qty" class="help-block text-danger"><?= form_error('qty') ?></span>
                        </div>
                    </div>

                    <?= hidden("id", $id) ?>
                    <?= hidden("id_pendaftaran", $id_pendaftaran) ?>
                    <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i>&nbsp;Simpan</button>
                </form>
            </div>
        </div>
    </section>
</div>