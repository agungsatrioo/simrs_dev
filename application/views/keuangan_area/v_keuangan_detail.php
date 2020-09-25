<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');
?>

<div class="content-wrapper">
    <section class="content">
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">DETAIL PASIEN</h3>
            </div>
            <div class="box-body">
                <table class="table table-bordered" style="margin-bottom: 10px">
                    <tr>
                        <td>No Rawat</td>
                        <td><?php echo @$pendaftaran['no_rawat'] ?></td>
                    </tr>
                    <tr>
                        <td>No Rekamedis</td>
                        <td><?php echo @$pendaftaran['no_rekamedis'] ?></td>
                    </tr>
                    <tr>
                        <td>Nama Pasien</td>
                        <td><?php echo @$pendaftaran['nama_pasien'] ?></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="box box-warning box-solid">
            <div class="box-header with-border">
                <h3 class="box-title">RIWAYAT PEMBERIAN OBAT</h3>
            </div>
            <div class="box-body">
                <table class="table table-striped" id="tbl_riwayat_obat">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Nama obat</th>
                            <th>Tanggal resep</th>
                            <th>Harga</th>
                            <th>Jumlah</th>
                            <th>Subtotal</th>
                            <th>Status pembayaran</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </section>
</div>