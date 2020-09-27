<div class="content-wrapper">
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-warning box-solid">

                    <div class="box-header">
                        <h3 class="box-title">KELOLA DATA PEMERIKSAAN LABORATORIUM</h3>
                    </div>

                    <div class="box-body">
                        <div style="padding-bottom: 10px;"'>
                            <?php echo anchor(site_url('periksalabor/create'), '<i class="fa fa-plus" aria-hidden="true"></i> Tambah Data', 'class="btn btn-danger btn-sm"'); ?>
                            <?php echo anchor(site_url('periksalabor/excel'), '<i class="fa fa-file-excel" aria-hidden="true"></i> Export Ms Excel', 'class="btn btn-success btn-sm"'); ?>
                            <?php echo anchor(site_url('periksalabor/word'), '<i class="fa fa-file-word" aria-hidden="true"></i> Export Ms Word', 'class="btn btn-primary btn-sm"'); ?></div>
                        
                            <?= $callout ?>
                        <table class="table table-bordered table-striped" id="mytable">
                            <thead>
                                <tr>
                                    <th width="30px">No</th>
                                    <th width="100px">Kode Periksa</th>
                                    <th>Nama Periksa</th>
                                    <th>Tarif</th>
                                    <th width="200px">Action</th>
                                </tr>
                            </thead>

                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>