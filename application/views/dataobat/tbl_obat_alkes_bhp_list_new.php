<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">

            <div class="box-header">
                <h3 class="box-title">KELOLA DATA OBAT ALKES BHP</h3>
            </div>

            <div class="box-body">
                <div class="col-lg-12">
                    <?php echo anchor(site_url('dataobat/create'), '<i class="fa fa-plus" aria-hidden="true"></i> Tambah Data', 'class="btn btn-danger btn-sm"'); ?>
                    <?php echo anchor(site_url('dataobat/excel'), '<i class="fa fa-file-excel" aria-hidden="true"></i> Export Ms Excel', 'class="btn btn-success btn-sm"'); ?>
                    <?php echo anchor(site_url('dataobat/word'), '<i class="fa fa-file-word" aria-hidden="true"></i> Export Ms Word', 'class="btn btn-primary btn-sm"'); ?>
                </div>
                <div class="col-lg-12">
                    <table class="table table-striped table-responsive" id="barangTable">
                        <thead>
                            <tr>
                                <!--<th>No</th>-->
                                <th>Kode Obat</th>
                                <th>Nama Obat</th>
                                <th>Kategori Barang</th>
                                <th>Satuan</th>
                                <th>Harga</th>
                                <th>Jenis Harga</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </section>
</div>