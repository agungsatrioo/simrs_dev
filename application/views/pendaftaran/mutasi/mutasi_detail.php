<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header">
                <h3 class="box-title">MUTASI KEUANGAN PASIEN</h3>
            </div>
            <div class="box-body">
                <div class="col-lg-12" style="margin: 5px !important">
                    <a href="<?= $backUrl ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a>
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
                                <th colspan="3" style="text-align:right">Total Pengeluaran</th>
                                <td colspan="3" id="total_tagihan"></td>
                            </tr>
                            <tr>
                                <th colspan="3" style="text-align:right">Saldo akhir</th>
                                <td colspan="3" id="saldo_akhir"></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>


            </div>
        </div>
    </section>
</div>