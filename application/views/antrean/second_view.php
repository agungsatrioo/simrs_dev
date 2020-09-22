<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>SIM <?php echo getInfoRS('nama_rumah_sakit') ?></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="<?php echo base_url() ?>assets/jquery-ui/themes/base/minified/jquery-ui.min.css" type="text/css" />
    <link rel="stylesheet" href="<?php echo base_url() ?>assets/adminlte/bower_components/bootstrap/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="<?php echo base_url() ?>assets/adminlte/bower_components/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<?php echo base_url() ?>assets/adminlte/bower_components/Ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="<?php echo base_url() ?>assets/adminlte/dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
             folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="<?php echo base_url() ?>assets/adminlte/dist/css/skins/_all-skins.min.css">
</head>

<body>
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
</body>

</html>