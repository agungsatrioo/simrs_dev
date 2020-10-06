<div class="content-wrapper">

    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">INPUT DATA TEMPAT TIDUR</h3>
            </div>
            <form action="<?php echo $action; ?>" method="post">
                <div class="form-group">
                    <label class="col-sm-2 control-label">Kode tempat tidur</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="Kode Tempat Tidur" name="kode_tempat_tidur" value="<?php echo $kode_tempat_tidur; ?>" />
                        <span class="help-block"></span>
                    </div>
                </div>

                <div class="form-group <?= !empty(form_error('id_ranap_ruang')) ? "has-error" : "" ?>">
                    <label class="col-sm-2 control-label">Nama ruang rawat inap</label>
                    <div class="col-sm-10">
                        <?= cmb_dinamis("id_ranap_ruang", "tbl_rs_ruang", "nama_ruangan", "id", $id_ranap_ruang) ?>
                        <span class="help-block"><?= form_error('id_ranap_ruang') ?></span>
                    </div>
                </div>

                <table class='table table-bordered'>
                    <tr>
                        <td><input type='hidden' name='id' value ='<?= $id ?>'></td>
                        <td>
                            <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i> <?php echo $button ?></button>
                            <a href="<?php echo site_url('tempattidur') ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a></td>
                    </tr>
                </table>
            </form>
        </div>
</div>