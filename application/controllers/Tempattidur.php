<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tempattidur extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_tempat_tidur_model');
        $this->load->library('datatables');
    }

    public function index()
    {
        $this->template->load('template', 'tempattidur/tbl_tempat_tidur_list');
    }

    public function json()
    {
        header('Content-Type: application/json');
        echo $this->Tbl_tempat_tidur_model->json();
    }

    public function create()
    {
        $data = array(
            'button' => 'Create',
            'action' => site_url('tempattidur/create_action'),
            'kode_tempat_tidur' => set_value('kode_tempat_tidur'),
            'kode_ruang_rawat_inap' => set_value('kode_ruang_rawat_inap'),
            'status' => set_value('status'),
        );
        $this->template->load('template', 'tempattidur/tbl_tempat_tidur_form', $data);
    }

    function getKodeRuangRawatInap($namaRuangan)
    {
        $ruangan = $this->db->get_where('tbl_ruang_rawat_inap', array('nama_ruangan' => $namaRuangan))->row_array();
        return $ruangan['kode_ruang_rawat_inap'];
    }

    public function create_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->create();
        } else {
            $data = array(
                'kode_tempat_tidur' => $this->input->post('kode_tempat_tidur', TRUE),
                'kode_ruang_rawat_inap' => $this->input->post('kode_ruang_rawat_inap', TRUE),
                'status' => $this->input->post('status', TRUE),
            );

            if ($this->Tbl_tempat_tidur_model->insert($data)) {
                $this->session->set_flashdata('success', "Berhasil membuat data.");
            } else {
                $this->session->set_flashdata('error', "Gagal membuat data. Silakan coba lagi setelah beberapa saat");
            }
            redirect(site_url('tempattidur'));
        }
    }

    public function update($id)
    {
        $row = $this->Tbl_tempat_tidur_model->get_by_id($id);

        if ($row) {
            $data = array(
                'button' => 'Update',
                'action' => site_url('tempattidur/update_action'),
                'kode_tempat_tidur' => set_value('kode_tempat_tidur', $row->kode_tempat_tidur),
                'kode_ruang_rawat_inap' => set_value('kode_ruang_rawat_inap', $row->kode_ruang_rawat_inap),
                'status' => set_value('status', $row->status),
            );
            $this->template->load('template', 'tempattidur/tbl_tempat_tidur_form', $data);
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('tempattidur'));
        }
    }

    public function update_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->update($this->input->post('kode_tempat_tidur', TRUE));
        } else {
            $data = array(
                'kode_ruang_rawat_inap' => $this->input->post('kode_ruang_rawat_inap', TRUE),
                'status' => $this->input->post('status', TRUE),
            );

            if ($this->Tbl_tempat_tidur_model->update($this->input->post('kode_tempat_tidur', TRUE), $data)) {
                $this->session->set_flashdata('success', "Berhasil memperbarui data.");
            } else {
                $this->session->set_flashdata('error', "Gagal memperbarui data.");
            }
            redirect(site_url('tempattidur'));
        }
    }

    public function delete($id)
    {
        $row = $this->Tbl_tempat_tidur_model->get_by_id($id);

        if ($row) {
            if($this->Tbl_tempat_tidur_model->delete($id)) {
            	$this->session->set_flashdata('success', "Berhasil menghapus data.");
            } else {
            	$this->session->set_flashdata('error', "Gagal menghapus data.");
            }

            redirect(site_url('tempattidur'));

        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('tempattidur'));
        }
    }

    public function _rules()
    {
        $this->form_validation->set_rules('kode_ruang_rawat_inap', 'kode ruang rawat inap', 'trim|required');
        $this->form_validation->set_rules('status', 'status', 'trim|required');

        $this->form_validation->set_rules('kode_tempat_tidur', 'kode_tempat_tidur', 'trim');
        $this->form_validation->set_error_delimiters('<span class="text-danger">', '</span>');
    }

    public function excel()
    {
        $this->load->helper('exportexcel');
        $namaFile = "tbl_tempat_tidur.xls";
        $judul = "tbl_tempat_tidur";
        $tablehead = 0;
        $tablebody = 1;
        $nourut = 1;
        //penulisan header
        header("Pragma: public");
        header("Expires: 0");
        header("Cache-Control: must-revalidate, post-check=0,pre-check=0");
        header("Content-Type: application/force-download");
        header("Content-Type: application/octet-stream");
        header("Content-Type: application/download");
        header("Content-Disposition: attachment;filename=" . $namaFile . "");
        header("Content-Transfer-Encoding: binary ");

        xlsBOF();

        $kolomhead = 0;
        xlsWriteLabel($tablehead, $kolomhead++, "No");
        xlsWriteLabel($tablehead, $kolomhead++, "Kode Ruang Rawat Inap");
        xlsWriteLabel($tablehead, $kolomhead++, "Status");

        foreach ($this->Tbl_tempat_tidur_model->get_all() as $data) {
            $kolombody = 0;

            //ubah xlsWriteLabel menjadi xlsWriteNumber untuk kolom numeric
            xlsWriteNumber($tablebody, $kolombody++, $nourut);
            xlsWriteLabel($tablebody, $kolombody++, $data->kode_ruang_rawat_inap);
            xlsWriteLabel($tablebody, $kolombody++, $data->status);

            $tablebody++;
            $nourut++;
        }

        xlsEOF();
        exit();
    }

    public function word()
    {
        header("Content-type: application/vnd.ms-word");
        header("Content-Disposition: attachment;Filename=tbl_tempat_tidur.doc");

        $data = array(
            'tbl_tempat_tidur_data' => $this->Tbl_tempat_tidur_model->get_all(),
            'start' => 0
        );

        $this->load->view('tempattidur/tbl_tempat_tidur_doc', $data);
    }

    /**
     * Start of AJAX functions
     */

    function ajax_gedung()
    {
        $term = $this->input->get("term");

        $this->db->like(["nama_gedung" => $term["term"]]);
        $this->db->limit(10);

        $result = $this->db->get('tbl_gedung_rawat_inap')->result();

        echo json_encode($result);
    }

    function ajax_ruangan()
    {
        $term = $this->input->get("term");

        $this->db->like(["nama_ruangan" => $term["term"]]);
        $this->db->limit(10);

        $result = $this->db->get('tbl_ruang_rawat_inap')->result();

        echo json_encode($result);
    }

    /**
     * 
     */

    function sqltest()
    {
        $gedung = [
            'GEDUNG A' => [
                'KEMUNING', 'ULB', 'KENANGA'
            ],
            'GEDUNG B' => [
                'KANA', 'FRESIA', 'HEMODIALISA', 'ALAMANDA'
            ],
            'GEDUNG C' => [
                'ADENIUM', 'AZALEA', 'AMARILIS', 'ANGSANA'
            ]
        ];


        echo "<pre>";

        echo "INSERT INTO `tbl_gedung_rawat_inap`(`kode_gedung_rawat_inap`, `nama_gedung`) values<br>";
        $i = 0;
        foreach ($gedung as $gd => $r) {
            $i++;
            $kode_gedung = "GD" . generate_number($i, 5);
            echo "('$kode_gedung', '$gd'),<br>";
        }

        //echo "<br> INSERT INTO `tbl_ruang_rawat_inap`(`kode_ruang_rawat_inap`, `kode_gedung_rawat_inap`, `nama_ruangan`, `kelas`, `tarif`) VALUES <br>";

        echo "<br>";

        echo "INSERT INTO `tbl_tempat_tidur`(`kode_tempat_tidur`, `kode_ruang_rawat_inap`, `status`) VALUES<br>";

        $i = 0;
        foreach ($gedung as $gd => $r) {
            $j = 0;
            foreach ($r as $ruang) {
                $j++;
                $kode_ruang = strtoupper(kode_gen($ruang, $j, 3, 5));
                $kd_r = strtoupper(kode_gen($ruang));
                for ($a = 1; $a <= 40; $a++) {
                    $bed = strtoupper(kode_gen("KASUR-$kd_r", $a, 3, 4));
                    echo "('$bed', '$kode_ruang', 'kosong'),<br>";
                }
            }
        }
    }
}

/* End of file Tempattidur.php */
/* Location: ./application/controllers/Tempattidur.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-12-02 16:27:58 */
/* http://harviacode.com */