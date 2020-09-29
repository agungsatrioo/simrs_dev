<div class="content-wrapper">

    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">BUAT LAPORAN PENDAFTARAN</h3>
            </div>
            <div class="box-body">
                <form action="<?= base_url("generate/pendaftaran") ?>" method="post">
                    <div class="row">
                        <div class="col-lg-10">
                            <input type="text" name="daterange" id="daterange" class="form-control" readonly />
                        </div>
                        <div class="col-lg-2">
                            <button type="submit" class="btn btn-primary">Buat Laporan</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
</div>