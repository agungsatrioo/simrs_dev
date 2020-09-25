<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">DATA PENDAFTARAN</h3>
            </div>
            <div class="box-body">
                <div style="padding-bottom: 10px;">
                    <?php echo $enable ? anchor(site_url('pendaftaran/create'), '<i class="fa fa-plus" aria-hidden="true"></i> Tambah Data', 'class="btn btn-danger btn-sm"') : "";  ?>
                    <?php echo anchor(site_url('pendaftaran/excel'), '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Export Ms Excel', 'class="btn btn-success btn-sm"'); ?>
                    <?php echo anchor(site_url('pendaftaran/word'), '<i class="fa fa-file-word-o" aria-hidden="true"></i> Export Ms Word', 'class="btn btn-primary btn-sm"'); ?>
                </div>

                <?= $callout ?>

                <table class="table table-bordered table-striped" id="mytable">
                    <thead>
                        <tr>
                            <th>No Reg</th>
                            <th>No Rawat</th>
                            <th>No Rekmed</th>
                            <th>Nama pasien</th>
                            <th>Cara Masuk</th>
                            <th>Dokter Penanggung Jawab</th>
                            <th><?= @$head_rawat ?></th>
                            <th>Jenis Bayar</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </section>
</div>
