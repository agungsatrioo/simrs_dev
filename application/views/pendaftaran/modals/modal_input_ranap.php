<div id="input2Ranap" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form id="role-form" action="<?= base_url('pendaftaran/to_ranap') ?>" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Form rawat inap</h4>
                </div>
                <div class="modal-body">
                    <?= hidden("id_pendaftaran", $info_pasien->id) ?>
                    <table class="table table-bordered">

                        <tr>
                            <td>Nama gedung rawat inap</td>
                            <td>
                                <select class="form-control" name="id_gedung" id="id_gedung" style="width: 100% !important" required>
                            </td>
                        </tr>

                        <tr>
                            <td>Kelas ruang inap</td>
                            <td>
                                <select class="form-control" name="id_kelas" id="id_kelas" style="width: 100% !important" required>
                            </td>
                        </tr>

                        <tr>
                            <td>Ruang inap</td>
                            <td>
                                <select class="form-control" name="id_ruang_ranap" id="id_ruang_ranap" placeholder="Masukan ruangan rawat inap" style="width: 100% !important" required>
                            </td>
                        </tr>

                        <tr>
                            <td>Tanggal keluar</td>
                            <td><input type="date" class="form-control" name="tgl_keluar" id="tgl_keluar" placeholder="Tanggal Keluar" value="<?php echo date('Y-m-d'); ?>" min="<?php echo date('Y-m-d'); ?>" required /></td>
                        </tr>
                        <tr>
                            <td>Deposit</td>
                            <td>
                                <div class="input-group">
                                    <div class="input-group-addon">Rp</div>
                                    <input type="number" class="form-control" name="deposit_awal" id="deposit_awal" placeholder="Masukkan jumlah deposit pasien" min="0">
                                </div>
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