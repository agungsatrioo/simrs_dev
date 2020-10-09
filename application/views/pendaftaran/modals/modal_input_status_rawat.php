<div id="inputUbahStatusRanap" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Ubah Status Rawat</h4>
            </div>
            <?php echo form_open('pendaftaran/do_ubahrawat'); ?>
            <div class="modal-body">
                <input value="<?php echo $info_pasien->id; ?>" type="hidden" name="id_pendaftaran">
                <table class="table table-bordered">
                    <tr>
                        <td>Status rawat</td>
                        <td>
                        <?= cmb_dinamis("id_status_rawat", "tbl_pasien_status_rawat", "nama_status_rawat", "id", null, null, ["is_shown" => "1"]); ?>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-danger" onclick="javascript: return confirm('Apakah Anda yakin?')">Simpan</button>
            </div>
        </div>
        </form>

    </div>
</div>