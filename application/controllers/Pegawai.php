<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Pegawai extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_pegawai_model');
        $this->load->library('datatables');
    }

    public function test()
    {
        $str = "id,id_gol_darah,id_pekerjaan,id_agama,id_status_pernikahan,id_alamat_kecamatan,id_alamat_kota,no_kartu,no_identitas,id_jenis_kelamin,nama_ibu,tempat_lahir,tgl_lahir,nama_pasien,alamat,no_telepon";

        $srr = explode(",", $str);

        foreach ($srr as $item) {
            echo "'$item'=> set_value('$item'),<br>";
            //echo "'$item'=> \$this->input->post('$item', TRUE),<br>";
            //echo "'$item'=> set_value('$item', \$row->$item),<br>";
            //echo "\$this->form_validation->set_rules('$item', '$item', 'trim|required');<br>";
        }

        echo "<br><br>";
        
        foreach ($srr as $item) {
            //echo "'$item'=> set_value('$item'),<br>";
            echo "'$item'=> \$this->input->post('$item', TRUE),<br>";
            //echo "'$item'=> set_value('$item', \$row->$item),<br>";
            //echo "\$this->form_validation->set_rules('$item', '$item', 'trim|required');<br>";
        }

        echo "<br><br>";

        
        foreach ($srr as $item) {
            //echo "'$item'=> set_value('$item'),<br>";
            //echo "'$item'=> \$this->input->post('$item', TRUE),<br>";
            echo "'$item'=> set_value('$item', \$row->$item),<br>";
            //echo "\$this->form_validation->set_rules('$item', '$item', 'trim|required');<br>";
        }

        echo "<br><br>";

        
        foreach ($srr as $item) {
            //echo "'$item'=> set_value('$item'),<br>";
            //echo "'$item'=> \$this->input->post('$item', TRUE),<br>";
            //echo "'$item'=> set_value('$item', \$row->$item),<br>";
            echo "\$this->form_validation->set_rules('$item', '$item', 'trim|required');<br>";
        }
    }

    public function index()
    {
        $data = [];
        $data['create_link'] = base_url("pegawai/create");
        $data['file_name'] = "Laporan Data Pegawai";
        $data['title'] = "DATA PEGAWAI";
        $data['message'] = "";
        $this->template->load('template', 'pegawai/tbl_pegawai_list', $data);
    }

    public function json()
    {
        header('Content-Type: application/json');
        echo $this->Tbl_pegawai_model->json();
    }

    public function create()
    {
        $data = array(
            'button' => 'Create',
            'action' => site_url('pegawai/create_action'),
            'id' => set_value('id'),
            'nik' => set_value('nik'),
            'id_jenjang' => set_value('id_jenjang'),
            'id_departemen' => set_value('id_departemen'),
            'id_jabatan' => set_value('id_jabatan'),
            'id_alamat_kecamatan' => set_value('id_alamat_kecamatan'),
            'id_alamat_kota' => set_value('id_alamat_kota'),
            'id_bidang' => set_value('id_bidang'),
            'id_jenjang_pendidikan' => set_value('id_jenjang_pendidikan'),
            'id_gol_darah' => set_value('id_gol_darah'),
            'id_status_menikah' => set_value('id_status_menikah'),
            'id_uic' => set_value('id_uic'),
            'tgl_input' => set_value('tgl_input'),
            'tgl_edit' => set_value('tgl_edit'),
            'id_agama' => set_value('id_agama'),
            'id_jenis_kelamin' => set_value('id_jenis_kelamin'),
            'npwp' => set_value('npwp'),
            'tempat_lahir' => set_value('tempat_lahir'),
            'nama_pegawai' => set_value('nama_pegawai'),
            'tgl_lahir' => set_value('tgl_lahir'),
            'alamat' => set_value('alamat'),
            'no_identitas' => set_value('no_identitas'),
            'no_telepon' => set_value('no_telepon'),
            'alumni' => set_value('alumni'),
        );

        $this->template->load('template', 'pegawai/tbl_pegawai_form', $data);
    }

    public function create_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->create();
        } else {
            $data = array(
                'nik' => $this->input->post('nik', TRUE),
                'id_jenjang' => $this->input->post('id_jenjang', TRUE),
                'id_departemen' => $this->input->post('id_departemen', TRUE),
                'id_jabatan' => $this->input->post('id_jabatan', TRUE),
                'id_alamat_kecamatan' => $this->input->post('id_alamat_kecamatan', TRUE),
                'id_alamat_kota' => $this->input->post('id_alamat_kota', TRUE),
                'id_bidang' => $this->input->post('id_bidang', TRUE),
                'id_jenjang_pendidikan' => $this->input->post('id_jenjang_pendidikan', TRUE),
                'id_gol_darah' => $this->input->post('id_gol_darah', TRUE),
                'id_status_menikah' => $this->input->post('id_status_menikah', TRUE),
                'id_uic' => $this->input->post('id_uic', TRUE),
                'tgl_input' => $this->input->post('tgl_input', TRUE),
                'tgl_edit' => $this->input->post('tgl_edit', TRUE),
                'id_agama' => $this->input->post('id_agama', TRUE),
                'id_jenis_kelamin' => $this->input->post('id_jenis_kelamin', TRUE),
                'npwp' => $this->input->post('npwp', TRUE),
                'tempat_lahir' => $this->input->post('tempat_lahir', TRUE),
                'nama_pegawai' => $this->input->post('nama_pegawai', TRUE),
                'tgl_lahir' => $this->input->post('tgl_lahir', TRUE),
                'alamat' => $this->input->post('alamat', TRUE),
                'no_identitas' => $this->input->post('no_identitas', TRUE),
                'no_telepon' => $this->input->post('no_telepon', TRUE),
                'alumni' => $this->input->post('alumni', TRUE),
            );

            if ($this->Tbl_pegawai_model->insert($data)) {
                $this->session->set_flashdata('message', 'Berhasil membuat data pegawai');
            } else {
                $this->session->set_flashdata('message', 'Gagal membuat data pegawai');
            }

            redirect(site_url('pegawai'));
        }
    }

    public function update($id)
    {
        $row = $this->Tbl_pegawai_model->get_by_id($id);

        if ($row) {
            $data = array(
                'button' => 'Update',
                'action' => site_url('pegawai/update_action'),
                'id' => set_value('id', $row->id),
                'nik' => set_value('nik', $row->nik),
                'id_jenjang' => set_value('id_jenjang', $row->id_jenjang),
                'id_departemen' => set_value('id_departemen', $row->id_departemen),
                'id_jabatan' => set_value('id_jabatan', $row->id_jabatan),
                'id_alamat_kecamatan' => set_value('id_alamat_kecamatan', $row->id_alamat_kecamatan),
                'id_alamat_kota' => set_value('id_alamat_kota', $row->id_alamat_kota),
                'id_bidang' => set_value('id_bidang', $row->id_bidang),
                'id_jenjang_pendidikan' => set_value('id_jenjang_pendidikan', $row->id_jenjang_pendidikan),
                'id_gol_darah' => set_value('id_gol_darah', $row->id_gol_darah),
                'id_status_menikah' => set_value('id_status_menikah', $row->id_status_menikah),
                'id_uic' => set_value('id_uic', $row->id_uic),
                'tgl_input' => set_value('tgl_input', $row->tgl_input),
                'tgl_edit' => set_value('tgl_edit', $row->tgl_edit),
                'id_agama' => set_value('id_agama', $row->id_agama),
                'id_jenis_kelamin' => set_value('id_jenis_kelamin', $row->id_jenis_kelamin),
                'npwp' => set_value('npwp', $row->npwp),
                'tempat_lahir' => set_value('tempat_lahir', $row->tempat_lahir),
                'nama_pegawai' => set_value('nama_pegawai', $row->nama_pegawai),
                'tgl_lahir' => set_value('tgl_lahir', $row->tgl_lahir),
                'alamat' => set_value('alamat', $row->alamat),
                'no_identitas' => set_value('no_identitas', $row->no_identitas),
                'no_telepon' => set_value('no_telepon', $row->no_telepon),
                'alumni' => set_value('alumni', $row->alumni),
            );
            $this->template->load('template', 'pegawai/tbl_pegawai_form', $data);
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('pegawai'));
        }
    }

    public function update_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->update($this->input->post('id', TRUE));
        } else {
            $data = array(
                'nik' => $this->input->post('nik', TRUE),
                'id_jenjang' => $this->input->post('id_jenjang', TRUE),
                'id_departemen' => $this->input->post('id_departemen', TRUE),
                'id_jabatan' => $this->input->post('id_jabatan', TRUE),
                'id_alamat_kecamatan' => $this->input->post('id_alamat_kecamatan', TRUE),
                'id_alamat_kota' => $this->input->post('id_alamat_kota', TRUE),
                'id_bidang' => $this->input->post('id_bidang', TRUE),
                'id_jenjang_pendidikan' => $this->input->post('id_jenjang_pendidikan', TRUE),
                'id_gol_darah' => $this->input->post('id_gol_darah', TRUE),
                'id_status_menikah' => $this->input->post('id_status_menikah', TRUE),
                'id_uic' => $this->input->post('id_uic', TRUE),
                'tgl_input' => $this->input->post('tgl_input', TRUE),
                'tgl_edit' => $this->input->post('tgl_edit', TRUE),
                'id_agama' => $this->input->post('id_agama', TRUE),
                'id_jenis_kelamin' => $this->input->post('id_jenis_kelamin', TRUE),
                'npwp' => $this->input->post('npwp', TRUE),
                'tempat_lahir' => $this->input->post('tempat_lahir', TRUE),
                'nama_pegawai' => $this->input->post('nama_pegawai', TRUE),
                'tgl_lahir' => $this->input->post('tgl_lahir', TRUE),
                'alamat' => $this->input->post('alamat', TRUE),
                'no_identitas' => $this->input->post('no_identitas', TRUE),
                'no_telepon' => $this->input->post('no_telepon', TRUE),
                'alumni' => $this->input->post('alumni', TRUE),
            );

            if ($this->Tbl_pegawai_model->update($this->input->post('id', TRUE), $data)) {
                $this->session->set_flashdata('message', 'Berhasil mengubah data pegawai');
            } else {
                $this->session->set_flashdata('message', 'Gagal mengubah data pegawai');
            }
            redirect(site_url('pegawai'));
        }
    }

    public function delete($id)
    {
        $row = $this->Tbl_pegawai_model->get_by_id($id);

        if ($row) {
            if ($this->Tbl_pegawai_model->delete($id)) {
                $this->session->set_flashdata('success', "Berhasil menghapus data.");
            } else {
                $this->session->set_flashdata('error', "Gagal menghapus data.");
            }

            redirect(site_url('pegawai'));
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('pegawai'));
        }
    }

    public function _rules()
    {
        $this->form_validation->set_rules('id_jenjang', 'id_jenjang', 'trim|required');
        $this->form_validation->set_rules('id_departemen', 'id_departemen', 'trim|required');
        $this->form_validation->set_rules('id_jabatan', 'id_jabatan', 'trim|required');
        $this->form_validation->set_rules('id_bidang', 'id_bidang', 'trim|required');
        $this->form_validation->set_rules('id_jenjang_pendidikan', 'id_jenjang_pendidikan', 'trim|required');
        $this->form_validation->set_rules('id_gol_darah', 'id_gol_darah', 'trim|required');
        $this->form_validation->set_rules('id_status_menikah', 'id_status_menikah', 'trim|required');
        $this->form_validation->set_rules('id_agama', 'id_agama', 'trim|required');
        $this->form_validation->set_rules('id_jenis_kelamin', 'id_jenis_kelamin', 'trim|required');
        $this->form_validation->set_rules('npwp', 'npwp', 'trim|required');
        $this->form_validation->set_rules('tempat_lahir', 'tempat_lahir', 'trim|required');
        $this->form_validation->set_rules('nama_pegawai', 'nama_pegawai', 'trim|required');
        $this->form_validation->set_rules('tgl_lahir', 'tgl_lahir', 'trim|required');
        $this->form_validation->set_rules('alamat', 'alamat', 'trim|required');
        $this->form_validation->set_rules('no_identitas', 'no_identitas', 'trim|required');
        $this->form_validation->set_rules('no_telepon', 'no_telepon', 'trim|required');
        $this->form_validation->set_rules('alumni', 'alumni', 'trim|required');
        $this->form_validation->set_rules('nik', 'nik', 'trim');

        $this->form_validation->set_error_delimiters('<span class="text-danger">', '</span>');
    }

    function autocomplate()
    {
        autocomplate_json('tbl_pegawai', 'nama_pegawai');
    }

    function ajax_pegawai()
    {
        $term = $this->input->get("term");

        $pegawai = $this->Tbl_pegawai_model->get_limit_data(null, null, $term);

        echo json_encode($pegawai);
    }

    public function make_apoteker($id)
    {
        $result = $this->Tbl_pegawai_model->get_by_id($id);

        $data = array(
            'button' => 'Create',
            'action' => site_url('user/create_action'),
            'id_users' => set_value('id_users'),
            'full_name' => $result->nama_pegawai,
            'email' => "{$result->nik}@apoteker.login",
            'password' => set_value('password'),
            'images' => set_value('images'),
            'id_user_level' => 5,
            'is_aktif' => set_value('is_aktif'),
        );
        $this->template->load('template', 'user/tbl_user_form_new', $data);
    }


    public function make_keuangan($id)
    {
        $result = $this->Tbl_pegawai_model->get_by_id($id);

        $data = array(
            'button' => 'Create',
            'action' => site_url('user/create_action'),
            'id_users' => set_value('id_users'),
            'full_name' => $result->nama_pegawai,
            'email' => "{$result->nik}@keuangan.login",
            'password' => set_value('password'),
            'images' => set_value('images'),
            'id_user_level' => 4,
            'is_aktif' => set_value('is_aktif'),
        );
        $this->template->load('template', 'user/tbl_user_form_new', $data);
    }
}

/* End of file Pegawai.php */
/* Location: ./application/controllers/Pegawai.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-11-28 16:16:01 */
/* http://harviacode.com */