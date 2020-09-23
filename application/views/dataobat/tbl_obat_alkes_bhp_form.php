<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header">
                <h3 class="box-title">FORMULIR OBAT</h3>
            </div>

            <div class="box-body">
                <form class="form-horizontal" action="<?= @$action ?>" method="post">
                    <div class="form-group">
                        <label class="control-label col-sm-2">Kode Obat/Barang</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="kode_barang" value="<?= @$kode_barang ?>">
                            <span class="sr-only">(success)</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2">Nama Obat/Barang</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="nama_barang" value="<?= @$nama_barang ?>">
                            <span class="sr-only">(success)</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2">Kategori barang</label>
                        <div class="col-sm-10">
                            <?= cmb_dinamis('id_kategori_barang', 'tbl_kategori_barang', 'nama_kategori', 'id_kategori_barang', @$id_kategori_barang) ?>
                            <span class="sr-only">(success)</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2">Satuan</label>
                        <div class="col-sm-10">
                            <?= cmb_dinamis('id_satuan_barang', 'tbl_satuan_barang', 'nama_satuan', 'id_satuan', @$id_satuan_barang) ?>
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
                            <?= cmb_dinamis('id_kategori_harga_brg', 'tbl_kategori_harga_brg', 'nama_kategori_harga_brg', 'id_kategori_harga_brg', @$id_kategori_harga_brg) ?>
                            <span id="inputSuccess3Status" class="sr-only">(success)</span>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Masukkan</button>
                </form>
            </div>
        </div>
    </section>
</div>