<div class="content-wrapper">

    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">INPUT DATA KATEGORI BARANG</h3>
            </div>
            <form action="<?php echo $action; ?>" method="post">
                <table class='table table-bordered'>
                    <tr>
                        <td width='200'>Nama Kategori <?php echo form_error('nama_kategori') ?></td>
                        <td>
                            <input type="text" class="form-control" name="nama_kategori" id="nama_kategori" placeholder="Nama Kategori" value="<?php echo $nama_kategori; ?>" />
                        </td>
                    </tr>
                    <tr>
                        <td width='200'>Nama Kategori <?php echo form_error('id_kelompok') ?></td>
                        <td>
                            <?= cmb_dinamis("id_kelompok", "tbl_barang_kelompok", "nama_kelompok", "id", $id_kelompok) ?>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="hidden" name="id" value="<?php echo $id; ?>" />
                            <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i> <?php echo $button ?></button>
                            <a href="<?php echo base_url('barang/kategori') ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a></td>
                    </tr>
                </table>
            </form>
        </div>
</div>