<div class="content-wrapper">
    <section class="content">
        <?= @$modal ?>
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-warning box-solid">

                    <div class="box-header">
                        <h3 class="box-title">DETAIL PENGADAAN BARANG</h3>
                    </div>

                    <div class="box-body">
                        <div style="padding-bottom: 10px;">

                            <?= $callout ?>

                            <table class="table table-bordered table-striped" id="mytable">
                                <thead>
                                    <tr>
                                        <th width="30px">No</th>
                                        <th>Kode Faktur</th>
                                        <th>Nama Barang</th>
                                        <th>Jumlah</th>
                                        <th>Harga</th>
                                        <th width="100px">Action</th>
                                    </tr>
                                </thead>

                            </table>
                        </div>
                    </div>
                </div>
            </div>
    </section>
</div>