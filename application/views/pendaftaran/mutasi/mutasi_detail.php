<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header">
                <h3 class="box-title">MUTASI KEUANGAN PASIEN</h3>
            </div>
            <div class="box-body">
                <div class="col-lg-12" style="margin: 5px !important">
                    <a href="<?php echo site_url('pendaftaran/detail/' . $encodedNoRawat) ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a>
                </div>
                <div class="col-lg-12" style="margin: 5px !important">
                    <table class="table table-bordered table-striped" id="mytable">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Tanggal mutasi</th>
                                <th>Keterangan</th>
                                <th>Mutasi awal</th>
                                <th>Jumlah mutasi</th>
                                <th>Mutasi akhir</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th colspan="3" style="text-align:right">Saldo akhir</th>
                                <th colspan="3"></th>
                            </tr>
                        </tfoot>
                    </table>
                </div>


            </div>
        </div>
    </section>
</div>