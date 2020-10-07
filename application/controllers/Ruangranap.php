<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Ruangranap extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_ruang_rawat_inap_model');
        $this->load->library('datatables');
    }

    public function index()
    {
        $data = [];
        $data['create_link'] = base_url("ruangranap/create");
        $data['file_name'] = "LAPORAN RUANG INAP";
        $data['title'] = "LAPORAN RUANG INAP";
        $data['message'] = "";
        $this->template->load('template', 'ruangranap/tbl_ruang_rawat_inap_list', $data);
    }

    public function json()
    {
        header('Content-Type: application/json');
        echo $this->Tbl_ruang_rawat_inap_model->json();
    }

    function ajax_ruangan()
    {
        header('Content-Type: application/json');

        $term = $this->input->get("term");
        $pegawai = $this->Tbl_ruang_rawat_inap_model->get(null, null, $term)->result();

        echo json_encode($pegawai);
    }

    public function ajax_kasur()
    {
        header('Content-Type: application/json');

        $this->load->model(["Tbl_tempat_tidur_model" => "kasur"]);

        $id = $this->input->get('id', TRUE);

        echo $this->kasur->get_kasur_table($id, true);
    }

    public function ajax_kelas_select2()
    {
        header('Content-Type: application/json');

        $kode_gedung = $this->input->post('kode_gedung', TRUE);
        echo $this->Tbl_ruang_rawat_inap_model->grup_kelas_ruangan($kode_gedung);
    }

    public function lihat($id)
    {
        $data = [];

        $this->load->model(["Tbl_tempat_tidur_model" => "kasur"]);

        $data['kasur'] = $this->kasur->get_kasur_table($id);
        $this->template->load('template', 'ruangranap/ruangranap_details', $data);
    }

    public function create()
    {
        $data = array(
            'button' => 'Create',
            'action' => site_url('ruangranap/create_action'),
            'id' => set_value('id'),
            'kode_ruang' => set_value('kode_ruang'),
            'id_ranap_gedung' => set_value('id_ranap_gedung'),
            'nama_ruangan' => set_value('nama_ruangan'),
            'id_ruang_kelas' => set_value('id_ruang_kelas'),
            'tarif' => set_value('tarif'),
        );
        $this->template->load('template', 'ruangranap/tbl_ruang_rawat_inap_form', $data);
    }

    public function create_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->create();
        } else {
            $data = array(
                'kode_ruang' =>  $this->input->post('kode_ruang'),
                'id_ranap_gedung' => $this->input->post('id_ranap_gedung', TRUE),
                'nama_ruangan' => $this->input->post('nama_ruangan', TRUE),
                'id_ruang_kelas' => $this->input->post('id_ruang_kelas', TRUE),
                'tarif' => $this->input->post('tarif', TRUE),
            );

            if ($this->Tbl_ruang_rawat_inap_model->insert($data)) {
                $this->session->set_flashdata('success', "Berhasil membuat data.");
            } else {
                $this->session->set_flashdata('error', "Gagal membuat data. Silakan coba lagi setelah beberapa saat");
            }

            redirect(site_url('ruangranap'));
        }
    }

    public function update($id)
    {
        $row = $this->Tbl_ruang_rawat_inap_model->get_by_id($id);

        if ($row) {
            $data = array(
                'button' => 'Update',
                'action' => site_url('ruangranap/update_action'),
                'id' => set_value('id', $row->id . ""),
                'kode_ruang' => set_value('kode_ruang', $row->kode_ruang),
                'id_ranap_gedung' => set_value('id_ranap_gedung', $row->id_ranap_gedung),
                'nama_ruangan' => set_value('nama_ruangan', $row->nama_ruangan),
                'id_ruang_kelas' => set_value('id_ruang_kelas', $row->id_ruang_kelas),
                'tarif' => set_value('tarif', $row->tarif),
            );
            $this->template->load('template', 'ruangranap/tbl_ruang_rawat_inap_form', $data);
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('ruangranap'));
        }
    }

    public function update_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->update($this->input->post('id', TRUE));
        } else {
            $data = array(
                'kode_ruang' => $this->input->post('kode_ruang', TRUE),
                'id_ranap_gedung' => $this->input->post('id_ranap_gedung', TRUE),
                'nama_ruangan' => $this->input->post('nama_ruangan', TRUE),
                'id_ruang_kelas' => $this->input->post('id_ruang_kelas', TRUE),
                'tarif' => $this->input->post('tarif', TRUE),
            );

            if ($this->Tbl_ruang_rawat_inap_model->update($this->input->post('id', TRUE), $data)) {
                $this->session->set_flashdata('success', "Berhasil memperbarui data.");
            } else {
                $this->session->set_flashdata('error', "Gagal memperbarui data.");
            }
            redirect(site_url('ruangranap'));
        }
    }

    public function delete($id)
    {
        $row = $this->Tbl_ruang_rawat_inap_model->get_by_id($id);

        if ($row) {
            if ($this->Tbl_ruang_rawat_inap_model->delete($id)) {
                $this->session->set_flashdata('success', "Berhasil menghapus data.");
            } else {
                $this->session->set_flashdata('error', "Gagal menghapus data.");
            }

            redirect(site_url('ruangranap'));
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('ruangranap'));
        }
    }

    public function _rules()
    {
        $this->form_validation->set_rules('id_ranap_gedung', 'kode gedung rawat inap', 'trim|required');
        $this->form_validation->set_rules('nama_ruangan', 'nama ruangan', 'trim|required');
        $this->form_validation->set_rules('id_ruang_kelas', 'id_ruang_kelas', 'trim|required');
        $this->form_validation->set_rules('tarif', 'tarif', 'trim|required');

        $this->form_validation->set_error_delimiters('<span class="text-danger">', '</span>');

    }

    public function test() {
        //format: nama_ruang, nama_gedung, nama_kelas
        $ruangan = [
            ["ALEXANDER FLEMNING", 1, 1, 45000], 
            ["MARIE CURIE A", 1, 2, 37500],
            ["MARIE CURIE B", 1, 2, 37500],
            ["SIGMUND FREUD", 1, 3, 34950],

            ["JOSEPH LISTER", 2, 2, 36776], 
            ["LOUIS PASTEUR A", 2, 3, 34776],
            ["LOUIS PASTEUR B", 2, 3, 34776],
            ["FLORENCE NIGHTIGALE", 2, 4, 27540],

            ["JOHN SNOW", 3, 1, 50000], 
            ["EDWARD JENNER", 3, 2, 33231],
            ["HIPPOCRATES", 3, 3, 33112],
            ["SIR WILLIAM OSLER", 3, 5, 27550],
        ];

        $sql = "INSERT INTO `tbl_rs_ruang`(`id_ranap_gedung`, `id_ruang_kelas`, `kode_ruang`, `nama_ruangan`, `tarif`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES <br>";

        $i = 1;
        foreach($ruangan as $item) {
            $n = "RANAP_". generate_number($i, 3);
            $sql .= "({$item[1]}, {$item[2]}, '$n', '{$item[0]}', {$item[3]}, 1),<br>";
            $i++;
        }

        echo $sql;
    }
}