<div class="modal fade" id="inputTindakan" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Input Tindakan</h4>
            </div>
            <div class="modal-body">
                <?php echo form_open('pendaftaran/do_tindakan') ?>
                <table class="table table-bordered">
                    <?= hidden("id_pendaftaran", $info_pasien->id) ?>
                    <?= hidden("id_dokter", $info_pasien->id_pj_dokter) ?>
                    
                    <tr>
                        <td>Nama Tindakan</td>
                        <td>
                            <select class="form-control" name="id_tindakan" id="id_tindakan" placeholder="Masukan Nama Tindakan" style="width: 100% !important" required>
                        </td>
                    </tr>
                    <tr>
                        <td>Hasil Periksa</td>
                        <td><input type="text" required name="hasil_periksa" placeholder="masukan hasil Periksa" class="form-control"></td>
                    </tr>
                    <tr>
                        <td>Perkembangan</td>
                        <td><input type="text" required name="perkembangan" placeholder="masukan perkembangan sekarang" class="form-control"></td>
                    </tr>
                    <tr>
                        <td>Masukkan Petugas (Opsional)</td>
                        <td>
                            <select class="form-control" name="id_pegawai" id="id_pegawai" placeholder="Masukan Nama Petugas" style="width: 100% !important">
                        </td>
                    </tr>
                </table>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Tutup</button>
                <button type="submit" class="btn btn-primary">Simpan Data</button>
            </div>
            </form>
        </div>
    </div>
</div>