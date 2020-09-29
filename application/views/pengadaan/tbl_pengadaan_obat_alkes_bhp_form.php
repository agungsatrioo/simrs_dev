<div class="content-wrapper">

    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">FORM PENGADAAN OBAT ALKES BHP</h3>
            </div>
            <form action="<?php echo $action; ?>" method="post">

                <table class='table table-bordered'>
                    <tr>
                        <td>No Faktur</td>
                        <td><input id="nofaktur" onKeyup="load()" placeholder="Masukan No Faktur" class="form-control" type="text" name="no_faktur" value="<?php echo $no_faktur; ?>" /> </td>
                    </tr>
                    <tr>
                        <td width='200'>Tanggal <?php echo form_error('tanggal') ?></td>
                        <td><input type="date" class="form-control" name="tanggal" id="tanggal" placeholder="Tanggal" value="<?php echo $tanggal; ?>" /></td>
                    </tr>
                    <tr>
                        <td width='200'>Supplier <?php echo form_error('kode_supplier') ?></td>
                        <td>
                            <select class="form-control" name="kode_supplier" id="kode_supplier" style="width: 100% !important" required>
                        </td>
                    </tr>
                    <tr>
                        <td>Cari Barang</td>
                        <td>
                            <div class="row">
                                <div class="col-lg-8">
                                    <select class="form-control" name="kode_barang" id="kode_barang" required></select>
                                </div>
                                <div class="col-lg-2">
                                    <input type="text" id="harga" placeholder="harga" class="form-control">
                                </div>
                                <div class="col-lg-2">
                                    <input type="text" id="qty" placeholder="Qty" class="form-control">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <button type="button" class="btn btn-danger" onclick="add()">Add Barang</button>
                            <button type="submit" class="btn btn-danger"><i class="fa fa-floppy-o"></i> <?php echo $button ?></button>
                            <a href="<?php echo site_url('pengadaan') ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a></td>
                    </tr>
                </table>
            </form>
            <div class="box box-warning box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">DAFTAR ITEM YANG DIBELI </h3>
                </div>
                <div id="list">

                </div>


            </div>
        </div>
</div>