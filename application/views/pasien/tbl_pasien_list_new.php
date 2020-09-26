<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">DATA PASIEN</h3>
            </div>
            <div class="box-body">
                <div style="padding-bottom: 10px;">
                    <?php echo anchor(site_url('pasien/create'), '<i class="fa fa-plus" aria-hidden="true"></i>&nbsp;Tambah data', 'class="btn btn-danger btn-sm"'); ?>
                    <?php echo anchor(site_url('pasien/excel'), '<i class="fa fa-file-excel" aria-hidden="true"></i> Export Ms Excel', 'class="btn btn-success btn-sm"'); ?>
                    <?php echo anchor(site_url('pasien/word'), '<i class="fa fa-file-word" aria-hidden="true"></i> Export Ms Word', 'class="btn btn-primary btn-sm"'); ?>
                </div>

                <?= $callout ?>

                <table class="table table-bordered table-striped" id="mytable">
                    <thead>
                        <tr>
                            <th>No RM</th>
                            <th>Nama Pasien</th>
                            <th>Gender</th>
                            <th>Gol Darah</th>
                            <th>Tempat Lahir</th>
                            <th>Tanggal Lahir</th>
                            <th>Nama Ibu</th>
                            <th>Status Menikah</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </section>
</div>