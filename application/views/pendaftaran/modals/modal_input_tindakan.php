<div class="modal fade" id="periksa_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Input Tindakan</h4>
            </div>
            <div class="modal-body">
                <?php echo form_open('pendaftaran/periksa_action') ?>
                <table class="table table-bordered">
                    <input value="<?php echo $no_rawat; ?>" type="hidden" name="no_rawat">
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
                        <td>Masukan Nama Dokter</td>
                        <td>
                            <select class="form-control" name="id_dokter" id="id_dokter" placeholder="Masukan Nama Dokter" style="width: 100% !important" required>
                        </td>
                    </tr>
                    <tr>
                        <td>Masukan Petugas</td>
                        <td>
                            <select class="form-control" name="id_petugas" id="id_petugas" placeholder="Masukan Nama Petugas" style="width: 100% !important">
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