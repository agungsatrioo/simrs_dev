<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">INPUT DATA RUANG RAWAT INAP</h3>
            </div>
            <form action="<?php echo $action; ?>" method="post">
                <table class='table table-bordered'>
                    <tr>
                        <td>Kode Ruangan</td>
                        <td><input placeholder="Kode Ruangan" class="form-control" type="text" name="kode_ruang" value="<?php echo $kode_ruang; ?>" required/> </td>
                    </tr>
                    <tr>
                        <td width='200'>Nama Ruangan <?php echo form_error('nama_ruangan') ?></td>
                        <td><input type="text" class="form-control" name="nama_ruangan" id="nama_ruangan" placeholder="Nama Ruangan" value="<?php echo $nama_ruangan; ?>" required/></td>
                    </tr>
                    <tr>
                        <td width='200'>Gedung Rawat Inap <?php echo form_error('id_ranap_gedung') ?></td>
                        <td>
                            <?php echo cmb_dinamis('id_ranap_gedung', 'tbl_rs_gedung', 'nama_gedung', 'id', $id_ranap_gedung) ?>
                        </td>
                    </tr>
                    <tr>
                        <td width='200'>Kelas <?php echo form_error('id_ruang_kelas') ?></td>
                        <td>
                            <?= cmb_dinamis('id_ruang_kelas', 'tbl_rs_ruang_kelas', 'nama_kelas_ruang_ranap', 'id', $id_ruang_kelas) ?>
                        </td>
                    </tr>
                    <tr>
                        <td width='200'>Tarif <?php echo form_error('tarif') ?></td>
                        <td><input type="text" class="form-control" name="tarif" id="tarif" placeholder="Tarif" value="<?php echo $tarif; ?>" required/></td>
                    </tr>
                    <tr>
                        <td><input type="hidden" name="id" value="<?php echo $id; ?>" /></td>
                        <td>
                            <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i> <?php echo $button ?></button>
                            <a href="<?php echo site_url('ruangranap') ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a></td>
                    </tr>
                </table>
            </form>
        </div>
</div>