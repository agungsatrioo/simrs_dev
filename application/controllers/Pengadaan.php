<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Pengadaan extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_pengadaan_obat_alkes_bhp_model');
    }

    public function index()
    {
        $data = [];
        $data['create_link'] = base_url("pengadaan/create");
        $data['file_name'] = "LAPORAN PENGADAAN BARANG";
        $data['title'] = "LAPORAN PENGADAAN BARANG";
        $data['message'] = "";

        $this->template->load('template', 'pengadaan/tbl_pengadaan_obat_alkes_bhp_list', $data);
    }

    public function json()
    {
        header('Content-Type: application/json');
        echo $this->Tbl_pengadaan_obat_alkes_bhp_model->json();
    }

    public function create()
    {
        $data = array(
            'button' => 'Simpan Transaksi',
            'action' => site_url('pengadaan/create_action'),
            'id' => set_value('id'),
            'no_faktur' => set_value('no_faktur'),
            'tanggal' => set_value('tanggal', date("Y-m-d")),
            'id_supplier' => set_value('id_supplier'),
        );
        $this->template->load('template', 'pengadaan/tbl_pengadaan_obat_alkes_bhp_form', $data);
    }

    function getKodeSupplier($namaSupplier)
    {
        $this->db->where('nama_supplier', $namaSupplier);
        $data = $this->db->get('tbl_supplier')->row_array();
        return $data['id_supplier'];
    }

    public function create_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->create();
        } else {
            $data = array(
                'no_faktur' => $this->input->post('no_faktur', TRUE),
                'tanggal' => $this->input->post('tanggal', TRUE),
                'id_supplier' => $this->input->post('id_supplier', TRUE),
            );

            $insert_id = $this->Tbl_pengadaan_obat_alkes_bhp_model->insert($data);

            if ($insert_id) {
                $this->session->set_flashdata('success', "Berhasil membuat pengadaan barang. Selanjutnya harap tambahkan satu atau lebih barang.");
                redirect(site_url("pengadaan/detail/$insert_id"));
            } else {
                $this->session->set_flashdata('error', "Gagal membuat data. Silakan coba lagi setelah beberapa saat");
                redirect(site_url('pengadaan'));
            }

            
        }
    }

    public function update($id)
    {
        $row = $this->Tbl_pengadaan_obat_alkes_bhp_model->get_by_id($id);

        if ($row) {
            $data = array(
                'button' => 'Update',
                'action' => site_url('pengadaan/update_action'),
                'id' => set_value('no_faktur', $row->id),
                'no_faktur' => set_value('no_faktur', $row->no_faktur),
                'tanggal' => set_value('tanggal', $row->tanggal),
                'id_supplier' => set_value('id_supplier', $row->id_supplier),
            );
            $this->template->load('template', 'pengadaan/tbl_pengadaan_obat_alkes_bhp_form', $data);
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('pengadaan'));
        }
    }

    public function update_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->update($this->input->post('id', TRUE));
        } else {
            $data = array(
                'tanggal' => $this->input->post('tanggal', TRUE),
                'no_faktur' => $this->input->post('no_faktur', TRUE),
                'id_supplier' => $this->input->post('id_supplier', TRUE),
            );

            if ($this->Tbl_pengadaan_obat_alkes_bhp_model->update($this->input->post('id', TRUE), $data)) {
                $this->session->set_flashdata('success', "Berhasil memperbarui data.");
            } else {
                $this->session->set_flashdata('error', "Gagal memperbarui data.");
            }
            redirect(site_url('pengadaan'));
        }
    }

    public function delete($id)
    {
        $row = $this->Tbl_pengadaan_obat_alkes_bhp_model->get_by_id($id);

        if ($row) {
            if ($this->Tbl_pengadaan_obat_alkes_bhp_model->delete($id)) {
                $this->session->set_flashdata('success', "Berhasil menghapus data.");
            } else {
                $this->session->set_flashdata('error', "Gagal menghapus data.");
            }

            redirect(site_url('pengadaan'));
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('pengadaan'));
        }
    }

    public function _rules()
    {
        $this->form_validation->set_rules('tanggal', 'tanggal', 'trim|required');
        $this->form_validation->set_rules('id_supplier', 'kode supplier', 'trim|required');

        $this->form_validation->set_rules('no_faktur', 'no_faktur', 'trim');
        $this->form_validation->set_error_delimiters('<span class="text-danger">', '</span>');
    }

    function add_ajax()
    {
        $id_barang = $this->input->post('id_barang');
        $qty    =  $this->input->post('qty');
        $harga  = $this->input->post('harga');
        $id_barang_pengadaan = $this->input->post('id_barang_pengadaan');

        if (empty($id_barang) || empty($qty) || empty($harga)  || empty($id_barang_pengadaan)) {
            return "Masih ada yang kosong!";
        }

        $data = array('id_barang' => $id_barang, 'qty' => $qty, 'id_barang_pengadaan' => $id_barang_pengadaan, 'harga' => $harga);

        $this->db->insert('tbl_barang_pengadaan_detail', stamp_insert($data));
    }

    function list_pengadaan($id)
    {
        echo "<table class='table table-bordered'>
                <tr><th>NO</th><th>NAMA BARANG</th><th>QTY</th><th>HARGA</th></tr>";

        $sql = "SELECT tb2.id,tb2.nama_barang,tb1.harga,tb1.qty,tb1.id
                FROM tbl_barang_pengadaan_detail as tb1, tbl_barang as tb2
                WHERE tb1.id_barang=tb2.id and tb1.id='$id'";

        $list = $this->db->query($sql)->result();
        $no = 1;
        foreach ($list as $row) {
            echo "<tr>
                <td width='10'>$no</td>
                <td>$row->nama_barang</td>
                <td width='20'>$row->qty</td>
                <td width='100'>$row->harga</td>
                <td width='100' onClick='hapus($row->id)'><button class='btn btn-danger btn-sm'>Hapus</button></td>
                </tr>";
            $no++;
        }
        echo " </table>";
    }

    function hapus_ajax()
    {
        $id = $_GET['id'];
        $this->db->where('id', $id);
        $this->db->delete('tbl_barang_pengadaan_detail');
    }

    function detail_ajax($id)
    {
        echo $this->Tbl_pengadaan_obat_alkes_bhp_model->detail_datatables($id);
    }

    function detail($id)
    {
        $data = [];

        $row = $this->Tbl_pengadaan_obat_alkes_bhp_model->get_by_id($id);

        $data['row'] = $row;
        $data['dt_url'] = base_url("pengadaan/detail_ajax/$id");
        $data['modal'] = $this->load->view('pengadaan_detail/pengadaan_detail_modal', $data, true);

        $this->template->load('template', 'pengadaan_detail/pengadaan_detail_list', $data);
    }

    function detail_do_add()
    {
        $id_pengadaan = $this->input->post("id_barang_pengadaan", true);

        $data = [
            "id_barang_pengadaan" => $id_pengadaan,
            "id_barang" => $this->input->post("id_barang", true),
            "qty" => $this->input->post("qty", true),
            "keterangan" => $this->input->post("keterangan", true),
        ];

        if ($this->Tbl_pengadaan_obat_alkes_bhp_model->detail_insert($data)) {
            $this->session->set_flashdata('success', "Berhasil menambah data.");
        } else {
            $this->session->set_flashdata('error', "Gagal menambah data.");
        }

        redirect(base_url("pengadaan/detail/$id_pengadaan"));
    }

    function detail_do_delete($id)
    {
        $row = $this->Tbl_pengadaan_obat_alkes_bhp_model->get_detail_item($id);

        $id_pengadaan = $row->id_barang_pengadaan;

        if ($this->Tbl_pengadaan_obat_alkes_bhp_model->detail_delete($id)) {
            $this->session->set_flashdata('success', "Berhasil menambah data.");
        } else {
            $this->session->set_flashdata('error', "Gagal menambah data.");
        }

        redirect(base_url("pengadaan/detail/$id_pengadaan"));
    }
}

/* End of file Pengadaan.php */
/* Location: ./application/controllers/Pengadaan.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-12-10 02:07:42 */
/* http://harviacode.com */