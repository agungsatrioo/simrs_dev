<div class="content-wrapper">
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-warning box-solid">

                    <div class="box-header">
                        <h3 class="box-title">LAPORAN PENDAFTARAN</h3>
                    </div>

                    <div class="box-body">
                        <div class='row'>
                            <div class='col-md-9'>
                                <div style="padding-bottom: 10px;"'>
        <?php echo $enable ? anchor(site_url('pendaftaran/create'), '<i class="fa fa-wpforms" aria-hidden="true"></i> Tambah Data', 'class="btn btn-danger btn-sm"') : "";  ?>
		<?php echo anchor(site_url('pendaftaran/excel'), '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Export Ms Excel', 'class="btn btn-success btn-sm"'); ?>
		<?php echo anchor(site_url('pendaftaran/word'), '<i class="fa fa-file-word-o" aria-hidden="true"></i> Export Ms Word', 'class="btn btn-primary btn-sm"'); ?></div>
            </div>
            <div class=' col-md-3'>
                                    <form action="<?php echo site_url('pendaftaran/index'); ?>" class="form-inline" method="get">
                                        <div class="input-group">
                                            <input type="text" class="form-control" name="q" value="<?php echo $q; ?>">
                                            <span class="input-group-btn">
                                                <?php
                                                if ($q <> '') {
                                                ?>
                                                    <a href="<?php echo site_url('pendaftaran'); ?>" class="btn btn-default">Reset</a>
                                                <?php
                                                }
                                                ?>
                                                <button class="btn btn-primary" type="submit">Search</button>
                                            </span>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <?= $callout ?>

                            <table class="table table-bordered" style="margin-bottom: 10px">
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

                                <?php foreach ($pendaftaran_data as $pendaftaran) { ?>
                                    <tr>
                                        <td><?php echo $pendaftaran->no_registrasi ?></td>
                                        <td><?php echo $pendaftaran->no_rawat_readable ?></td>
                                        <td><?php echo $pendaftaran->no_rekamedis ?></td>
                                        <td><?php echo $pendaftaran->nama_pasien ?></td>
                                        <td><?php echo $pendaftaran->cara_masuk ?></td>
                                        <td><?php echo $pendaftaran->nama_dokter ?></td>
                                        <td><?= ($is_ralan) ? $pendaftaran->nama_poliklinik : $pendaftaran->nama_ruangan ?></td>
                                        <td><?php echo $pendaftaran->jenis_bayar ?></td>
                                        <td style="text-align:center" width="160px">
                                            <?php
                                            echo anchor(site_url('pendaftaran/detail/' . $pendaftaran->no_rawat), '<i class="fa fa-eye" aria-hidden="true"></i>', 'class="btn btn-primary btn-sm"');
                                            echo '  ';
                                            echo $enable ? anchor(site_url('pendaftaran/delete/' . $pendaftaran->no_rawat), '<i class="fa fa-trash-o" aria-hidden="true"></i>', 'class="btn btn-danger btn-sm" Delete', 'onclick="javascript: return confirm(\'Apakah Anda yakin?\')"') : "";
                                            ?>
                                        </td>
                                    </tr>
                                <?php
                                }
                                ?>
                            </table>
                            <div class="row">
                                <div class="col-md-6">

                                </div>
                                <div class="col-md-6 text-right">
                                    <?php echo $pagination ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </section>
</div>