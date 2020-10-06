<div id="inputBarang" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Form Pemberian Obat</h4>
            </div>
            <?php echo form_open('pengadaan/detail_do_add'); ?>
            <div class="modal-body">
                <input value="<?php echo $row->id; ?>" type="hidden" name="id_barang_pengadaan">
                <table class="table table-bordered">
                    <tr>
                        <td>Cari Barang</td>
                        <td>
                            <select class="form-control" name="id_barang" id="id_barang" placeholder="Masukan nama barang" style="width: 100% !important" required>
                        </td>
                    </tr>
                    <tr>
                        <td>Qty</td>
                        <td><input type="number" name="qty" placeholder="Qty" class="form-control"></td>
                    </tr>
                    <tr>
                        <td>Keterangan</td>
                        <td><textarea name="keterangan" placeholder="Keterangan" class="form-control"></textarea></td>
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