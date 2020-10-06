<div id="inputObat" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Form Pemberian Obat</h4>
            </div>
            <?php echo form_open('pendaftaran/do_beribarang'); ?>
            <div class="modal-body">
                <input value="<?php echo $info_pasien->id; ?>" type="hidden" name="id_pendaftaran">
                <table class="table table-bordered">
                    <tr>
                        <td>Cari Obat</td>
                        <td>
                            <select class="form-control" name="id_barang" id="id_obat" placeholder="Masukan nama obat" style="width: 100% !important" required>
                        </td>
                    </tr>
                    <tr>
                        <td>Qty</td>
                        <td><input type="number" name="qty" placeholder="Qty" class="form-control"></td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-danger">Simpan</button>
            </div>
        </div>
        </form>

    </div>
</div>