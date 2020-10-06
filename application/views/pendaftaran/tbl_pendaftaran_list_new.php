<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">DATA PENDAFTARAN</h3>
            </div>
            <div class="box-body">
                <?= $callout ?>

                <table class="table table-bordered table-striped" id="mytable">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>No Rawat</th>
                            <th>No Rekam Medis</th>
                            <th>Tgl. Daftar</th>
                            <th>Nama pasien</th>
                            <th>Cara Masuk</th>
                            <th>Dokter Penanggung Jawab</th>
                            <th><?= @$head_rawat ?></th>
                            <th>Jenis Bayar</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </section>
</div>