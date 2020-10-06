<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Abc extends Private_Controller
{
    public function index()
    {
        $dd = "id,id_gol_darah,id_pekerjaan,id_agama,id_status_pernikahan,id_alamat_kecamatan,id_alamat_kota,no_kartu,no_identitas,id_jenis_kelamin,nama_ibu,tempat_lahir,tgl_lahir,nama_pasien,alamat,no_telepon,asal_rujukan,no_rawat";

        $str = "$dd,id_rekamedis,id_cara_masuk,id_status_rawat,id_pj_dokter,id_poli,id_jenis_bayar,tgl_daftar,nama_pj,id_hub_dg_pj,alamat_pj,no_identitas_pj";

        $bh = "`id_rekamedis`, `id_cara_masuk`, `id_status_rawat`, `id_pj_dokter`, `id_poli`, `id_jenis_bayar`, `no_rawat`, `tgl_daftar`, `asal_rujukan`, `nama_pj`, `id_hub_dg_pj`, `alamat_pj`, `no_identitas_pj`";

        $bc = "`id_gol_darah`, `id_pekerjaan`, `id_agama`, `id_status_pernikahan`, `id_alamat_kecamatan`, `id_alamat_kota`, `no_kartu`, `no_identitas`, `id_jenis_kelamin`, `nama_ibu`, `tempat_lahir`, `tgl_lahir`, `nama_pasien`, `alamat`, `no_telepon`";

        header('Content-Type: text/plain');

        $srr = explode(",", $str);
        $sre = explode(", ", $bc);

        echo implode(", ", $srr);

        echo "\n\n";


        foreach ($sre as $item) {
            echo "NEW.$item, ";
        }

        echo "\n\n";

        foreach ($srr as $item) {
            echo "'$item'=> set_value('$item'),\n";
            //echo "'$item'=> \$this->input->post('$item', TRUE),<br>";
            //echo "'$item'=> set_value('$item', \$row->$item),<br>";
            //echo "\$this->form_validation->set_rules('$item', '$item', 'trim|required');<br>";
        }

        echo "\n\n";

        foreach ($srr as $item) {
            //echo "'$item'=> set_value('$item'),<br>";
            echo "'$item'=> \$this->input->post('$item', TRUE),\n";
            //echo "'$item'=> set_value('$item', \$row->$item),<br>";
            //echo "\$this->form_validation->set_rules('$item', '$item', 'trim|required');<br>";
        }

        echo "\n\n";


        foreach ($srr as $item) {
            //echo "'$item'=> set_value('$item'),<br>";
            //echo "'$item'=> \$this->input->post('$item', TRUE),<br>";
            echo "'$item'=> set_value('$item', \$row->$item),\n";
            //echo "\$this->form_validation->set_rules('$item', '$item', 'trim|required');<br>";
        }

        echo "\n\n";


        foreach ($srr as $item) {
            //echo "'$item'=> set_value('$item'),<br>";
            //echo "'$item'=> \$this->input->post('$item', TRUE),<br>";
            //echo "'$item'=> set_value('$item', \$row->$item),<br>";
            echo "\$this->form_validation->set_rules('$item', '$item', 'trim');\n";
        }

        echo "\n\n";

        foreach ($srr as $item) {
            //echo "'$item'=> set_value('$item'),<br>";
            //echo "'$item'=> \$this->input->post('$item', TRUE),<br>";
            //echo "'$item'=> set_value('$item', \$row->$item),<br>";
            echo "
            <div class=\"form-group has-feedback\">
                <label class=\"control-label col-sm-3\">Isi ya kolom ini</label>
                <div class=\"col-sm-9\">
                    <input type=\"text\" class=\"form-control\" name=\"$item\" id=\"$item\" placeholder=\"_\" value=\"<?php echo \${$item}; ?>\" aria-describedby=\"$item\" required />
                    <span  id=\"$item\" class=\"help-block text-danger\"><?= form_error('$item') ?></span>
                </div>
            </div>
            ";
        }
    }
}
