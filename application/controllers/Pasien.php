<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Pasien extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model(['Tbl_pasien_model' => 'pasien']);
    }

    public function ajax_pasien_select2()
    {
        header('Content-Type: application/json');
    }

    public function json_table()
    {
        header('Content-Type: application/json');
        echo $this->pasien->json();
    }

    public function index()
    {
        $data = [];
        $data['create_link'] = base_url("pasien/create");
        $data['file_name'] = "Laporan Data Pasien";
        $data['title'] = "DATA PASIEN";
        $data['message'] = "";

        $this->template->load('template', 'pasien/tbl_pasien_list_new', $data);
    }

    public function laporan_biaya()
    {
    }

    public function create()
    {
        $data = array(
            'button' => 'Create',
            'action' => site_url('pasien/create_action'),
            'id' => set_value('id'),
            'id_gol_darah' => set_value('id_gol_darah'),
            'id_pekerjaan' => set_value('id_pekerjaan'),
            'id_agama' => set_value('id_agama'),
            'id_status_pernikahan' => set_value('id_status_pernikahan'),
            'id_alamat_kecamatan' => set_value('id_alamat_kecamatan'),
            'id_alamat_kota' => set_value('id_alamat_kota'),
            'no_kartu' => set_value('no_kartu'),
            'no_identitas' => set_value('no_identitas'),
            'id_jenis_kelamin' => set_value('id_jenis_kelamin'),
            'nama_ibu' => set_value('nama_ibu'),
            'tempat_lahir' => set_value('tempat_lahir'),
            'tgl_lahir' => set_value('tgl_lahir'),
            'nama_pasien' => set_value('nama_pasien'),
            'alamat' => set_value('alamat'),
            'no_telepon' => set_value('no_telepon'),
        );
        $this->template->load('template', 'pasien/tbl_pasien_form', $data);
    }

    public function create_action()
    {

        $this->_rules();

        if ($this->form_validation->run() == FALSE) {

            $this->create();
        } else {
            $data = array(
                'id_gol_darah' => $this->input->post('id_gol_darah', TRUE),
                'id_pekerjaan' => $this->input->post('id_pekerjaan', TRUE),
                'id_agama' => $this->input->post('id_agama', TRUE),
                'id_status_pernikahan' => $this->input->post('id_status_pernikahan', TRUE),
                'id_alamat_kecamatan' => $this->input->post('id_alamat_kecamatan', TRUE),
                'id_alamat_kota' => $this->input->post('id_alamat_kota', TRUE),
                'no_kartu' => $this->input->post('no_kartu', TRUE),
                'no_identitas' => $this->input->post('no_identitas', TRUE),
                'id_jenis_kelamin' => $this->input->post('id_jenis_kelamin', TRUE),
                'nama_ibu' => $this->input->post('nama_ibu', TRUE),
                'tempat_lahir' => $this->input->post('tempat_lahir', TRUE),
                'tgl_lahir' => $this->input->post('tgl_lahir', TRUE),
                'nama_pasien' => $this->input->post('nama_pasien', TRUE),
                'alamat' => $this->input->post('alamat', TRUE),
                'no_telepon' => $this->input->post('no_telepon', TRUE),
            );

            if ($this->pasien->insert($data)) {
                $this->session->set_flashdata('success', "Berhasil membuat data.");
            } else {
                $this->session->set_flashdata('error', "Gagal membuat data. Silakan coba lagi setelah beberapa saat");
            }
            redirect(site_url('pasien'));
        }
    }

    public function update($id)
    {
        $row = $this->pasien->get_by_id($id);

        if ($row) {
            $data = array(
                'button' => 'Update',
                'action' => site_url('pasien/update_action'),
                'id' => set_value('id', $row->id),
                'id_gol_darah' => set_value('id_gol_darah', $row->id_gol_darah),
                'id_pekerjaan' => set_value('id_pekerjaan', $row->id_pekerjaan),
                'id_agama' => set_value('id_agama', $row->id_agama),
                'id_status_pernikahan' => set_value('id_status_pernikahan', $row->id_status_pernikahan),
                'id_alamat_kecamatan' => set_value('id_alamat_kecamatan', $row->id_alamat_kecamatan),
                'id_alamat_kota' => set_value('id_alamat_kota', $row->id_alamat_kota),
                'no_kartu' => set_value('no_kartu', $row->no_kartu),
                'no_identitas' => set_value('no_identitas', $row->no_identitas),
                'id_jenis_kelamin' => set_value('id_jenis_kelamin', $row->id_jenis_kelamin),
                'nama_ibu' => set_value('nama_ibu', $row->nama_ibu),
                'tempat_lahir' => set_value('tempat_lahir', $row->tempat_lahir),
                'tgl_lahir' => set_value('tgl_lahir', $row->tgl_lahir),
                'nama_pasien' => set_value('nama_pasien', $row->nama_pasien),
                'alamat' => set_value('alamat', $row->alamat),
                'no_telepon' => set_value('no_telepon', $row->no_telepon),
            );
            $this->template->load('template', 'pasien/tbl_pasien_form', $data);
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('pasien'));
        }
    }

    public function update_action()
    {

        $this->_rules();


        if ($this->form_validation->run() == FALSE) {
            $this->update($this->input->post('id', TRUE));
        } else {
            $data = array(
                'id_gol_darah' => $this->input->post('id_gol_darah', TRUE),
                'id_pekerjaan' => $this->input->post('id_pekerjaan', TRUE),
                'id_agama' => $this->input->post('id_agama', TRUE),
                'id_status_pernikahan' => $this->input->post('id_status_pernikahan', TRUE),
                'id_alamat_kecamatan' => $this->input->post('id_alamat_kecamatan', TRUE),
                'id_alamat_kota' => $this->input->post('id_alamat_kota', TRUE),
                'no_kartu' => $this->input->post('no_kartu', TRUE),
                'no_identitas' => $this->input->post('no_identitas', TRUE),
                'id_jenis_kelamin' => $this->input->post('id_jenis_kelamin', TRUE),
                'nama_ibu' => $this->input->post('nama_ibu', TRUE),
                'tempat_lahir' => $this->input->post('tempat_lahir', TRUE),
                'tgl_lahir' => $this->input->post('tgl_lahir', TRUE),
                'nama_pasien' => $this->input->post('nama_pasien', TRUE),
                'alamat' => $this->input->post('alamat', TRUE),
                'no_telepon' => $this->input->post('no_telepon', TRUE),
            );

            if ($this->pasien->update($this->input->post('id', TRUE), $data)) {
                $this->session->set_flashdata('success', "Berhasil memperbarui data.");
            } else {
                $this->session->set_flashdata('error', "Gagal memperbarui data.");
            }

            redirect(site_url('pasien'));
        }
    }

    public function delete($id)
    {
        $row = $this->pasien->get_by_id($id);

        if ($row) {
            if ($this->pasien->delete($id)) {
                $this->session->set_flashdata('success', "Berhasil menghapus data.");
            } else {
                $this->session->set_flashdata('error', "Gagal menghapus data.");
            }

            redirect(site_url('pasien'));
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('pasien'));
        }
    }

    public function _rules()
    {
        $this->form_validation->set_rules('id_gol_darah', 'id_gol_darah', 'trim|required');
        $this->form_validation->set_rules('id_pekerjaan', 'id_pekerjaan', 'trim|required');
        $this->form_validation->set_rules('id_agama', 'id_agama', 'trim|required');
        $this->form_validation->set_rules('id_status_pernikahan', 'id_status_pernikahan', 'trim|required');
        $this->form_validation->set_rules('id_alamat_kecamatan', 'id_alamat_kecamatan', 'trim');
        $this->form_validation->set_rules('id_alamat_kota', 'id_alamat_kota', 'trim');
        $this->form_validation->set_rules('no_kartu', 'no_kartu', 'trim|required');
        $this->form_validation->set_rules('no_identitas', 'no_identitas', 'trim|required');
        $this->form_validation->set_rules('id_jenis_kelamin', 'id_jenis_kelamin', 'trim|required');
        $this->form_validation->set_rules('nama_ibu', 'nama_ibu', 'trim|required');
        $this->form_validation->set_rules('tempat_lahir', 'tempat_lahir', 'trim|required');
        $this->form_validation->set_rules('tgl_lahir', 'tgl_lahir', 'trim|required');
        $this->form_validation->set_rules('nama_pasien', 'nama_pasien', 'trim|required');
        $this->form_validation->set_rules('alamat', 'alamat', 'trim|required');
        $this->form_validation->set_rules('no_telepon', 'no_telepon', 'trim|required');

        $this->form_validation->set_rules('id', 'id', 'trim');
        $this->form_validation->set_error_delimiters('<span class="text-danger">', '</span>');
    }
}

/* End of file Pasien.php */
/* Location: ./application/controllers/Pasien.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-12-03 15:02:10 */
/* http://harviacode.com */