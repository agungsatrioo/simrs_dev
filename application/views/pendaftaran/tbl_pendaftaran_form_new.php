<div class="content-wrapper">
    <section class="content">
        <form action="<?= $action ?>" method="POST" class="form-horizontal">
            <div class="row">
                <div class="col-lg-6">
                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">DATA PENDAFTARAN</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group <?= !empty(form_error('no_registrasi')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">No. Registrasi</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="no_registrasi" id="no_registrasi" readonly="" placeholder="No Registrasi" value="<?php echo noRegOtomatis(); ?>" />
                                    <span class="help-block"><?= form_error('no_registrasi') ?></span>
                                </div>
                            </div>
                            <div class="form-group <?= !empty(form_error('no_registrasi')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">No. Rawat</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="no_rawat" placeholder="No Rawat" readonly="" value="<?php echo date('Y/m/d/') . noRegOtomatis(); ?>" />
                                    <span class="help-block"><?= form_error('no_rawat') ?></span>
                                </div>
                            </div>
                            <div class="form-group <?= !empty(form_error('no_registrasi')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">Cara masuk</label>
                                <div class="col-sm-10">
                                    <?php echo form_dropdown('cara_masuk', array('RAWAT JALAN' => 'RAWAT JALAN', 'UGD' => 'UGD'), $cara_masuk, array('class' => 'form-control')); ?>
                                    <span class="help-block"><?= form_error('cara_masuk') ?></span>
                                </div>
                            </div>

                            <div class="form-group <?= !empty(form_error('tanggal_daftar')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">Tanggal daftar</label>
                                <div class="col-sm-10">
                                    <input type="date" class="form-control" name="tanggal_daftar" id="tanggal_daftar" placeholder="Tanggal Daftar" value="<?php echo date('Y-m-d'); ?>" required />
                                    <span class="help-block"><?= form_error('tanggal_daftar') ?></span>
                                </div>
                            </div>

                            <div class="form-group <?= !empty(form_error('id_poli')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">Poliklinik tujuan</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="id_poli" id="id_poli" placeholder="Masukan nama pasien" required></select>
                                    <span class="help-block"><?= form_error('id_poli') ?></span>
                                </div>
                            </div>

                            <div class="form-group <?= !empty(form_error('kode_dokter_penanggung_jawab')) ? "has-error" : "" ?>" id="dokter1">
                                <label class="col-sm-2 control-label">Dokter p'anggung jwb.</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="kode_dokter_penanggung_jawab" id="kode_dokter_penanggung_jawab" placeholder="Masukan Nama Dokter" required></select>
                                    <span class="help-block"><?= form_error('kode_dokter_penanggung_jawab') ?></span>
                                </div>
                            </div>
                            <div class="form-group <?= !empty(form_error('id_jenis_bayar')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">Jenis bayar</label>
                                <div class="col-sm-10">
                                    <?php echo cmb_dinamis('id_jenis_bayar', 'tbl_jenis_bayar', 'jenis_bayar', 'id_jenis_bayar', $id_jenis_bayar) ?>
                                    <span class="help-block"><?= form_error('id_jenis_bayar') ?></span>
                                </div>
                            </div>
                            <div class="form-group <?= !empty(form_error('asal_rujukan')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">Asal rujukan</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="asal_rujukan" id="asal_rujukan" placeholder="Asal Rujukan" value="<?php echo $asal_rujukan; ?>" />
                                    <span class="help-block"><?= form_error('asal_rujukan') ?></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">DATA PASIEN</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group <?= !empty(form_error('nama_pasien')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">Nama pasien</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="nama_pasien" id="nama_pasien" placeholder="Masukan nama pasien" required></select>
                                    <span class="help-block"><?= form_error('nama_pasien') ?></span>
                                </div>
                            </div>
                            <div class="form-group <?= !empty(form_error('no_rekamedis')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">Nomor rekam medis</label>
                                <div class="col-sm-10">
                                    <input type="text" name="no_rekamedis" id="no_rekamedis" class="form-control" placeholder="No. rekam medis" readonly>
                                    <span class="help-block"><?= form_error('no_rekamedis') ?></span>
                                </div>
                            </div>
                            <div class="form-group <?= !empty(form_error('tanggal_lahir')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">Tanggal lahir</label>
                                <div class="col-sm-10">
                                    <input type="text" name="tanggal_lahir" id="tanggal_lahir" placeholder="tanggal lahir" class="form-control" readonly>
                                    <span class="help-block"><?= form_error('tanggal_lahir') ?></span>
                                </div>
                            </div>
                            <div class="form-group <?= !empty(form_error('')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label"> </label>
                                <div class="col-sm-10">

                                    <span class="help-block"><?= form_error('') ?></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">DATA PENANGGUNG JAWAB</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group <?= !empty(form_error('nama_penanggung_jawab')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">Nama p'anggung jwb.</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="nama_penanggung_jawab" id="nama_penanggung_jawab" placeholder="Nama Penanggung Jawab" value="<?php echo $nama_penanggung_jawab; ?>" required />
                                    <span class="help-block"><?= form_error('nama_penanggung_jawab') ?></span>
                                </div>
                            </div>
                            
                            <div class="form-group <?= !empty(form_error('hubungan_dengan_penanggung_jawab')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">Hub. dg. pasien</label>
                                <div class="col-sm-10">
                                    <?php echo form_dropdown('hubungan_dengan_penanggung_jawab', array('saudara kandung' => 'Saudara kandung', 'orang tua' => 'Orangtua', 'kerabat' => "Kerabat"), $hubungan_dengan_penanggung_jawab, array('class' => 'form-control')) ?>
                                    <span class="help-block"><?= form_error('hubungan_dengan_penanggung_jawab') ?></span>
                                </div>
                            </div>
                            
                            <div class="form-group <?= !empty(form_error('alamat_penanggung_jawab')) ? "has-error" : "" ?>">
                                <label class="col-sm-2 control-label">Alamat</label>
                                <div class="col-sm-10">
                                    <textarea class="form-control" rows="3" name="alamat_penanggung_jawab" id="alamat_penanggung_jawab" placeholder="Alamat Penanggung Jawab" required><?php echo $alamat_penanggung_jawab; ?></textarea>
                                    <span class="help-block"><?= form_error('alamat_penanggung_jawab') ?></span>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="box box-warning box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">AKSI</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group">
                                <div class="col-sm-9">
                                    <button type="submit" class="btn btn-danger form-control"><i class="fa fa-save"></i> <?php echo $button ?></button>
                                </div>
                                <div class="col-sm-3">
                                    <a href="<?php echo base_url('pendaftaran') ?>" class="btn btn-info"><i class="fa fa-sign-out-alt"></i> Kembali</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </section>
</div>
<script src="<?php echo base_url('assets/js/jquery-1.11.2.min.js') ?>"></script>
<script src="<?php echo base_url('assets/datatables/jquery.dataTables.js') ?>"></script>
<script src="<?php echo base_url('assets/datatables/dataTables.bootstrap.js') ?>"></script>
<script src="<?php echo base_url('assets/select2/js/select2.min.js') ?>"></script>

<script type="text/javascript">
    var idPoli = "";

    $('#nama_pasien').select2({
        placeholder: 'Pilih nama pasien',
        allowClear: true,
        ajax: {
            url: "<?php echo base_url() ?>pendaftaran/ajax_pasien",
            dataType: 'json',
            data: function(term) {
                return {
                    term: term
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.nama_pasien,
                            slug: item.tanggal_lahir,
                            id: item.no_rekamedis
                        }
                    })
                };
            }
        }
    });

    $('#id_poli').select2({
        placeholder: 'Pilih poliklinik',
        allowClear: true,
        ajax: {
            url: "<?php echo base_url() ?>poliklinik/ajax",
            dataType: 'json',
            type: 'post',
            data: function(term) {
                return {
                    term: term
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.nama_poliklinik,
                            id: item.id_poliklinik
                        }
                    })
                };
            }
        }
    });

    function formatItem(item) {

        if (!item.id) {
            return item.text;
        }

        let nama_dokter = item.other.nama_dokter
        let tersedia = item.other.tersedia
        let tersedia_type = tersedia == true ? "Tersedia" :"Tidak tersedia";
        let hari_praktik = item.other.hari
        let jam_praktik = item.other.jam_mulai + "-" + item.other.jam_selesai;

        let template = "<span>"+nama_dokter+" ("+tersedia_type+")<br><b>Hari praktik: </b>"+hari_praktik+", "+jam_praktik+"</span>";

        return $(template);
    }

    $('#kode_dokter_penanggung_jawab').select2({
        placeholder: 'Pilih dokter penanggungjawab',
        allowClear: true,
        ajax: {
            url: "<?php echo base_url() ?>pendaftaran/autocomplate_dokter",
            dataType: 'json',
            data: function(term) {
                return {
                    term: term.term,
                    id_poli: idPoli
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.nama_dokter,
                            id: item.kode_dokter,
                            //disabled: !item.tersedia,
                            other: item
                        }
                    })
                };
            },
        },
        templateResult: formatItem,
        templateSelection: formatItem
    });

    $('#dokter1').hide();

    $('#id_poli').on('select2:select', function(e) {
        var data = e.params.data;

        idPoli = data.id;
        $('#dokter1').show();
    });

    $('#id_poli').on('select2:clear', function(e) {
        $('#dokter1').hide();
    });

    $('#nama_pasien').on('select2:select', function(e) {
        var data = e.params.data;

        $('#no_rekamedis').val(data.id);
        $('#tanggal_lahir').val(data.slug);
    });
</script>