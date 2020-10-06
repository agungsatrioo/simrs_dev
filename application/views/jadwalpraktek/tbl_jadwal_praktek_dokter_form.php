<div class="content-wrapper">

    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">INPUT DATA JADWAL PRAKTEK DOKTER</h3>
            </div>
            <form action="<?php echo $action; ?>" method="post">
                <table class='table table-bordered'>
                    <tr>
                        <td width='200'>Nama Dokter <?php echo form_error('id_dokter') ?></td>
                        <td>
                            <select class="form-control" name="id_dokter" id="id_dokter" placeholder="Masukan Nama Dokter" style="width: 100% !important" required>
                        </td>
                    </tr>
                    <tr>
                        <td width='200'>Hari <?php echo form_error('hari') ?></td>
                        <td>
                            <?php
                            $hariArray = array('SENIN' => 'SENIN', 'SELASA' => 'SELASA', 'RABU' => 'RABU', 'KAMIS' => 'KAMIS', 'JUMAT' => 'JUMAT', 'SABTU' => 'SABTU', 'MINGGU' => 'MINGGU');
                            echo form_dropdown('hari', $hariArray, $hari, array('class' => 'form-control')) ?>
                        </td>
                    </tr>
                    <tr>
                        <td width='200'>Jam Mulai <?php echo form_error('jam_mulai') ?></td>
                        <td>
                            <input type='text' class="form-control" id='jam_mulai' name="jam_mulai" value="<?= $jam_mulai ?>" />

                        </td>
                    </tr>
                    <tr>
                        <td width='200'>Jam Selesai <?php echo form_error('jam_selesai') ?></td>
                        <td><input type='text' class="form-control" id='jam_selesai' name="jam_selesai" value="<?= $jam_selesai ?>" /></td>
                    </tr>
                    <tr>
                        <td width='200'>Poliklinik <?php echo form_error('id_poliklinik') ?></td>
                        <td>
                            <?php echo cmb_dinamis('id_poliklinik', 'tbl_poliklinik', 'nama_poliklinik', 'id', $id_poliklinik) ?>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="hidden" name="id" value="<?php echo $id; ?>" />
                            <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i> <?php echo $button ?></button>
                            <a href="<?php echo site_url('jadwalpraktek') ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a></td>
                    </tr>
                </table>
            </form>
        </div>
</div>

<script src="<?php echo base_url('assets/js/jquery-1.11.2.min.js') ?>"></script>
<script src="<?php echo base_url('assets/datatables/jquery.dataTables.js') ?>"></script>
<script src="<?php echo base_url('assets/datatables/dataTables.bootstrap.js') ?>"></script>
<script src="<?php echo base_url('assets/moment/moment.js') ?>"></script>
<script src="<?php echo base_url('assets/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js') ?>"></script>

<script type="text/javascript">
    $('#jam_mulai').datetimepicker({
        format: 'HH:mm',
    });
    $('#jam_selesai').datetimepicker({
        format: 'HH:mm',
    });

    $("#jam_mulai").on("dp.change", function(e) {
        $('#jam_selesai').data("DateTimePicker").minDate(e.date);
    });
    $("#jam_selesai").on("dp.change", function(e) {
        $('#jam_mulai').data("DateTimePicker").maxDate(e.date);
    });

    $(function() {
        //autocomplete
        $("#id_dokter").autocomplete({
            source: "<?php echo base_url() ?>index.php/jadwalpraktek/autocomplate_dokter",
            minLength: 1
        });


    });
</script>