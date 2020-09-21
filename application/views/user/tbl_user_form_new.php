<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">FORMULIR DATA PENGGUNA</h3>
            </div>
            <div class="box-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                    <div class="form-group <?= !empty(form_error('full_name')) ? "has-error" : "" ?>">
                        <label class="col-sm-2 control-label">Nama lengkap</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="full_name" id="full_name" placeholder="Full Name" value="<?php echo $full_name; ?>" required />
                            <span class="help-block"><?= form_error('kode_ruang_rawat_inap') ?></span>
                        </div>
                    </div>
                    <div class="form-group <?= !empty(form_error('email')) ? "has-error" : "" ?>">
                        <label class="col-sm-2 control-label">Alamat e-mail</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email" placeholder="Email" value="<?php echo $email; ?>" required />
                            <span class="help-block"><?= form_error('email') ?></span>
                        </div>
                    </div>
                    <?php if($this->router->fetch_method() == "create") { ?>
                    <div class="form-group <?= !empty(form_error('password')) ? "has-error" : "" ?>">
                        <label class="col-sm-2 control-label">Kata sandi</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="password" id="password" placeholder="Password" value="<?php echo $password; ?>" />
                            <span class="help-block"><?= form_error('password') ?></span>
                        </div>
                    </div>
                    <?php } ?>
                    <div class="form-group <?= !empty(form_error('id_user_level')) ? "has-error" : "" ?>">
                        <label class="col-sm-2 control-label">Jenis Pengguna</label>
                        <div class="col-sm-10">
                            <?php echo cmb_dinamis('id_user_level', 'tbl_user_level', 'nama_level', 'id_user_level', $id_user_level) ?>
                            <span class="help-block"><?= form_error('id_user_level') ?></span>
                        </div>
                    </div>
                    <div class="form-group <?= !empty(form_error('is_aktif')) ? "has-error" : "" ?>">
                        <label class="col-sm-2 control-label">Status aktif</label>
                        <div class="col-sm-10">
                            <?php echo form_dropdown('is_aktif', array('y' => 'AKTIF', 'n' => 'TIDAK AKTIF'), $is_aktif, array('class' => 'form-control')); ?>
                            <span class="help-block"><?= form_error('is_aktif') ?></span>
                        </div>
                    </div>
                    <div class="form-group <?= !empty(form_error('images')) ? "has-error" : "" ?>">
                        <label class="col-sm-2 control-label">Gambar profil</label>
                        <div class="col-sm-10">
                            <input type="file" name="images">
                            <span class="help-block"><?= form_error('images') ?></span>
                        </div>
                    </div>
                    <input type="hidden" name="id_users" value="<?php echo $id_users; ?>" />
                    <div class="form-group">
                        <button type="submit" class="btn btn-danger"><i class="fa fa-floppy-o"></i> <?php echo $button ?></button>
                        <a href="<?php echo site_url('user') ?>" class="btn btn-info"><i class="fa fa-sign-out"></i> Kembali</a>
                    </div>
                </form>
            </div>
        </div>
    </section>
</div>