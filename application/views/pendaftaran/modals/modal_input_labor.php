<div id="inputLabor" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Form Input Hasil Pemeriksaan Laboratorium</h4>
            </div>
            <?php echo form_open('pendaftaran/periksa_labor_action'); ?>
            <input value="<?php echo $no_rawat; ?>" type="hidden" name="no_rawat">
            <div class="modal-body">
                <input value="<?php echo $no_rawat; ?>" type="hidden" name="no_rawat">
                <table class="table table-bordered">
                    <tr>
                        <td>Pemeriksaan</td>
                        <td> <select class="form-control" name="kode_periksa" id="kode_periksa" placeholder="Masukan Nama Pemeriksaan" style="width: 100% !important" required></td>
                    </tr>

                </table>
                <div id="sub_periksa_labor">

                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-danger">Simpan</button>
            </div>
        </div>
        </form>

    </div>
</div>