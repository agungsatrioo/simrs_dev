<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">RIWAYAT PERJALANAN PASIEN</h3>
            </div>
            <div class="box-body form-horizontal">
                <?= $callout ?>
                <div class="row pad row-striped">
                    <div class="col-lg-3"><b>Nomor kartu pasien</b></div>
                    <div class="col-lg-9"><?= $info_pasien->no_kartu ?></div>
                </div>
                <div class="row pad row-striped">
                    <div class="col-lg-3"><b>Nomor rekam medis</b></div>
                    <div class="col-lg-9"><?= $info_pasien->no_rekamedis ?></div>
                </div>
                <div class="row pad row-striped">
                    <div class="col-lg-3"><b>Nama pasien</b></div>
                    <div class="col-lg-9"><?= $info_pasien->nama_pasien ?></div>
                </div>
                <hr>
                <table class="table table-bordered" style="margin-bottom: 10px" id="mytable">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Tanggal Berangkat</th>
                            <th>Tanggal Pulang</th>
                            <th>Keterangan</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>

                </table>
            </div>
        </div>
    </section>
</div>