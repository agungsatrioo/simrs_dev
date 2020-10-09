<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');
?>

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
                            <th>Tgl. Daftar</th>
                            <th>Nama pasien</th>
                            <th>Cara Masuk</th>
                            <th>Poliklinik</th>
                            <th>Jenis Bayar</th>
                            <th>Status Rawat</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </section>
</div>