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
                        <td width='200'>tanggal <?php echo form_error('tanggal') ?></td>
                        <td><input type="date" class="form-control" name="tanggal" id="tanggal" placeholder="tanggal" value="<?php echo date("Y-m-d", strtotime($tanggal)); ?>" /></td>
                    </tr>
                    <tr>
                        <td width='200'>Supplier <?php echo form_error('id_supplier') ?></td>
                        <td>
                            <select class="form-control" name="id_supplier" id="id_supplier" style="width: 100% !important" required>
                        </td>
                    </tr>
                    <tr>
                        <td><?= hidden("id", $id) ?></td>
                        <td>
                            <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i> <?php echo $button ?></button>
                            <a href="<?php echo base_url('pengadaan') ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a></td>
                    </tr>
                </table>
            </form>
        
        </div>
</div>