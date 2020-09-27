<div id="inputUGD2Ranap" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form id="role-form" action="<?= base_url('pendaftaran/ugd2ranap_action') ?>" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Form rawat inap</h4>
                </div>
                <div class="modal-body">
                    <input value="<?php echo $no_rawat; ?>" type="hidden" name="no_rawat">
                    <table class="table table-bordered">

                        <tr>
                            <td>Nama gedung rawat inap</td>
                            <td>
                                <select class="form-control" name="kode_gedung" id="kode_gedung" placeholder="Masukan nama gedung" style="width: 100% !important" required>
                            </td>
                        </tr>

                        <tr>
                            <td>Kelas ruang inap</td>
                            <td>
                                <select class="form-control" name="kode_kelas" id="kode_kelas" placeholder="Masukan kelas ruangan" style="width: 100% !important" required>
                            </td>
                        </tr>

                        <tr>
                            <td>Ruang inap</td>
                            <td>
                                <select class="form-control" name="kode_ruang" id="kode_ruang" placeholder="Masukan ruangan rawat inap" style="width: 100% !important" required>
                            </td>
                        </tr>

                        <tr>
                            <td>Tanggal keluar</td>
                            <td><input type="date" class="form-control" name="tanggal_keluar" id="tanggal_keluar" placeholder="Tanggal Keluar" value="<?php echo date('Y-m-d'); ?>" min="<?php echo date('Y-m-d'); ?>" required /></td>
                        </tr>
                        <tr>
                            <td>Deposit</td>
                            <td>
                                <div class="input-group">
                                    <div class="input-group-addon">Rp</div>
                                    <input type="number" class="form-control" name="jumlah_deposit" id="jumlah_deposit" placeholder="Masukkan jumlah deposit pasien" min="0">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Pilih tempat tidur</td>
                            <td>
                                <div id="tempat_tidur_table"></div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Simpan</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Tutup</button>
                </div>
            </form>
        </div>

    </div>
</div>



<!--
                
-->