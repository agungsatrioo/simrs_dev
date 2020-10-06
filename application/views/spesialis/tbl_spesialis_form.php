<div class="content-wrapper">

    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">INPUT DATA SPESIALIS</h3>
            </div>
            <form action="<?php echo $action; ?>" method="post">

                <table class='table table-bordered'>

                    <tr>
                        <td width='200'>Spesialis <?php echo form_error('spesialis') ?></td>
                        <td><input type="text" class="form-control" name="nama_spesialis" id="nama_spesialis" placeholder="Spesialis" value="<?php echo $nama_spesialis; ?>" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="hidden" name="id" value="<?php echo $id; ?>" />
                            <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i> <?php echo $button ?></button>
                            <a href="<?php echo site_url('spesialis') ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a></td>
                    </tr>
                </table>
            </form>
        </div>
</div>