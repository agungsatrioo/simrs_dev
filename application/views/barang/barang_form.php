<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header">
                <h3 class="box-title">FORMULIR OBAT</h3>
            </div>

            <div class="box-body">
                <form class="form-horizontal" action="<?= @$action ?>" method="post">
                    <div class="form-group">
                        <label class="control-label col-sm-2">Kode Barang</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="kode_barang" value="<?= @$kode_barang ?>">
                            <span class="sr-only">(success)</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2">Nama Barang</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="nama_barang" value="<?= @$nama_barang ?>">
                            <span class="sr-only">(success)</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2">Kategori barang</label>
                        <div class="col-sm-10">
                            <?= cmb_dinamis('id_kat_barang', 'tbl_barang_kategori', 'nama_kategori', 'id', @$id_kat_barang) ?>
                            <span class="sr-only">(success)</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2">Satuan</label>
                        <div class="col-sm-10">
                            <?= cmb_dinamis('id_satuan_barang', 'tbl_barang_satuan', 'nama_satuan', 'id', @$id_satuan_barang) ?>
                            <span class="sr-only">(success)</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2">Harga</label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <div class="input-group-addon">Rp</div>
                                <input type="number" class="form-control" name="harga" id="harga" placeholder="Harga" min="0" value="<?= @$harga ?>">
                            </div> <span class="sr-only">(success)</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2">Golongan</label>
                        <div class="col-sm-10">
                            <?= cmb_dinamis('id_kat_harga', 'tbl_barang_kat_harga', 'nama_kategori_harga_brg', 'id', @$id_kat_harga) ?>
                            <span id="inputSuccess3Status" class="sr-only">(success)</span>
                        </div>
                    </div>
                    <?= hidden("id", $id) ?>
                    <?= hidden("back_link", $back_link) ?>
                    <button type="submit" class="btn btn-primary">Masukkan</button>
                </form>
            </div>
        </div>
    </section>
</div>