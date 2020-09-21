<div class="content-wrapper">
    <section class="content">
        <div class="col-lg-6">
            <div class="box box-warning box-solid">
                <div class="box-header">
                    <h3 class="box-title">KELOLA ANTREAN POLIKLINIK</h3>
                </div>
                <div class="box-body">
                    <div class="col-lg-12">
                        <div class="btn-group" role="group" aria-label="...">
                            <a href="<?= base_url('antrean/skip') ?>" type="button" class="btn btn-default">Lewati antrean</a>
                            <a href="<?= base_url('antrean/next') ?>" type="button" class="btn btn-success">Layani antrean</a>
                        </div>
                        <div class="btn-group" role="group" aria-label="...">
                            <a href="<?= base_url('antrean/fullscreen_view') ?>" class="btn btn-primary" target="_blank">Buka tampilan sekunder</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="box box-warning box-solid">
                <div class="box-header">
                    <h3 class="box-title">ANTREAN SELANJUTNYA</h3>
                </div>
                <div class="box-body">
                    <?php if (!empty($last_id)) { ?>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-lg-3"><b>Tanggal antrean</b></div>
                                    <div class="col-lg-9"><?= @$last_id->tanggal_antrean ?></div>
                                </div>
                            </div>
                            <div class="panel-body text-center">
                                <h1><?= @$last_id->kode_antrean ?>-<?= @$last_id->no_antrean ?></h1>
                            </div>
                            <div class="panel-footer">
                                <div class="row">
                                    <div class="col-lg-3"><b>No. rawat</b></div>
                                    <div class="col-lg-9"><?= @$last_id->no_rawat ?></div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-3"><b>Nama</b></div>
                                    <div class="col-lg-9"><?= @$last_id->nama_pasien ?></div>
                                </div>
                            </div>
                        </div>
                    <?php } else { ?>
                        <div class="callout callout-danger">
                            <h4>Tidak ada antrean tersedia.</h4>
                        </div>
                    <?php } ?>
                </div>
            </div>
        </div>
    </section>
</div>