<div class="content-wrapper">

    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">INPUT DATA KELOMPOK BARANG</h3>
            </div>
            <form action="<?php echo $action; ?>" method="post">
                <table class='table table-bordered'>
                    <tr>
                        <td width='200'>Nama Kelompok <?php echo form_error('nama_kelompok') ?></td>
                        <td><input type="text" class="form-control" name="nama_kelompok" id="nama_kelompok" placeholder="Nama Kelompok" value="<?php echo $nama_kelompok; ?>" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="hidden" name="id" value="<?php echo $id; ?>" />
                            <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i> <?php echo $button ?></button>
                            <a href="<?php echo base_url('barang/kelompok') ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a></td>
                    </tr>
                </table>
            </form>
        </div>
</div>