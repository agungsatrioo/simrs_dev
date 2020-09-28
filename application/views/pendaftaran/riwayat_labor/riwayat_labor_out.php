<html>

<head>
    <title>Riwayat Laboratorium</title>
    <link rel="stylesheet" href="<?php echo base_url() ?>assets/adminlte/bower_components/bootstrap/dist/css/bootstrap.min.css">

</head>

<body style="margin: 10px" onload="window.print()">
    <div class="content-wrapper">
        
        <table class="table" style="margin-bottom: 10px">
            <tr>
                <td>No Rawat</td>
                <td><?php echo $pendaftaran['no_rawat'] ?></td>
            </tr>
            <tr>
                <td>No Rekamedis</td>
                <td><?php echo $pendaftaran['no_rekamedis'] ?></td>
            </tr>
            <tr>
                <td>Nama Pasien</td>
                <td><?php echo $pendaftaran['nama_pasien'] ?></td>
            </tr>
            <?php if ($isRawatInap) { ?>
                <tr>
                    <td>Nama Gedung</td>
                    <td><?php echo $pendaftaran['nama_gedung'] ?></td>
                </tr>
                <tr>
                    <td>Nama Ruangan/Kelas</td>
                    <td><?php echo $pendaftaran['nama_ruangan'] . "/" . $pendaftaran['nama_kelas_ruang_ranap'] ?></td>
                </tr>
                <tr>
                    <td>Kode tempat tidur</td>
                    <td><?php echo $pendaftaran['kode_tempat_tidur'] ?></td>
                </tr>
            <?php } ?>
        </table>
        <table class="table table-striped table-responsive">
            <thead>
                <tr>
                    <th>NO</th>
                    <th>Nama Pemeriksaan</th>
                    <th>Satuan</th>
                    <th>Hasil</th>
                    <th>Kerangan</th>
                    <th>Biaya</th>
                </tr>
            </thead>
            <?php
            $no = 1;
            $total_periksa_labor = 0;
            foreach ($riwayat_labor as $r) {
                $biaya_readable = rupiah($r->tarif);
                echo "<tr>
                                    <td>$no</td>
                                    <td>$r->nama_periksa</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>$biaya_readable</td>
                                    </tr>";

                $sub_periksa_sql = "SELECT ts.nama_pemeriksaan,ts.satuan,ts.nilai_rujukan,td.hasil,td.keterangan 
                                                FROM tbl_sub_pemeriksaan_laboratoirum  as ts, tbl_riwayat_pemeriksaan_laboratorium_detail as td
                                                WHERE td.kode_sub_periksa=ts.kode_sub_periksa 
                                                and td.id_rawat=$r->id_riwayat";
                $sub_periksa = $this->db->query($sub_periksa_sql)->result();
                foreach ($sub_periksa as $s) {
                    echo "<tr>
                                    <td></td><td>$s->nama_pemeriksaan</td>
                                        
                                    <td>$s->satuan</td>
                                    <td>$s->hasil</td>
                                    <td>$s->keterangan</td>
                                    <td></td>
                                    </tr>";
                }

                $no++;
                $total_periksa_labor = $total_periksa_labor + $r->tarif;
            }
            ?>
            <tr>
                <td colspan="5" class="text-right">Total</td>
                <td><b><?php echo rupiah($total_periksa_labor); ?></b></td>
            </tr>
        </table>
    </div>
</body>

</html>