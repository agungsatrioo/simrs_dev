<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tbl_pendaftaran_model extends CI_Model
{

    public $table = 'tbl_pendaftaran';
    public $id = 'no_rawat';
    public $pk = 'tbl_pendaftaran.id';
    public $order = 'DESC';

    function __construct()
    {
        parent::__construct();
    }


    function json($cara_masuk = "RAWAT JALAN", $kode_dokter = "")
    {
        $this->datatables->select('tbl_pendaftaran.no_registrasi, tbl_pendaftaran.no_rawat, tbl_pendaftaran.no_rekamedis, tbl_pasien.nama_pasien, cara_masuk, nama_dokter, nama_poliklinik, jenis_bayar, nama_ruangan');
        $this->datatables->from($this->table);
        $this->datatables->where("cara_masuk", $cara_masuk);

        $this->datatables->join('tbl_poliklinik', 'tbl_poliklinik.id_poliklinik=tbl_pendaftaran.id_poli');
        $this->datatables->join('tbl_pasien', 'tbl_pasien.no_rekamedis=tbl_pendaftaran.no_rekamedis');
        $this->datatables->join('tbl_jenis_bayar', 'tbl_jenis_bayar.id_jenis_bayar=tbl_pendaftaran.id_jenis_bayar');
        $this->datatables->join('tbl_dokter', 'tbl_dokter.kode_dokter=tbl_pendaftaran.kode_dokter_penanggung_jawab');

        $this->datatables->join('tbl_rawat_inap', 'tbl_rawat_inap.no_rawat = tbl_pendaftaran.no_rawat', 'left');
        $this->datatables->join('tbl_tempat_tidur', 'tbl_tempat_tidur.kode_tempat_tidur = tbl_rawat_inap.kode_tempat_tidur', 'left');
        $this->datatables->join('tbl_ruang_rawat_inap', 'tbl_ruang_rawat_inap.kode_ruang_rawat_inap = tbl_tempat_tidur.kode_ruang_rawat_inap', 'left');

        $actions = "
        <div class=\"btn-group\" role=\"group\">
            <a href=\"" . base_url('pendaftaran/detail/$1') . "\" class=\"btn btn-success\"><i class=\"fa fa-eye\"></i>&nbsp;Lihat</a>
        </div>
        ";

        $this->datatables->add_column('td_isi', '$1', 'str_placeholder(nama_ruangan, nama_poliklinik)');
        $this->datatables->add_column('action', $actions, 'enc_str(no_rawat)');

        $result = $this->datatables->generate();

        return $result;
    }

    function dt()
    {
        $actions = "
        <div class=\"btn-group\" role=\"group\">
            <a href=\"" . base_url('pendaftaran/detail/$1') . "\" class=\"btn btn-success\"><i class=\"fa fa-eye\"></i>&nbsp;Lihat</a>
        </div>
        ";

        $result = $this->datatables->select("{$this->pk}, no_rawat, no_rekamedis, nama_pasien, tgl_daftar, tbl_pendaftaran.tgl_input, nama_poliklinik as isi, nama_poliklinik as nama_ruangan, nama_dokter, nama_cara_masuk, jenis_bayar")
            ->from($this->table)
            ->join("tbl_pasien_rekamedis", "tbl_pasien_rekamedis.id = tbl_pendaftaran.id_rekamedis")
            ->join("tbl_pasien", "tbl_pasien.id = tbl_pasien_rekamedis.id_pasien")
            ->join("tbl_poliklinik", "tbl_poliklinik.id = tbl_pendaftaran.id_poli")
            ->join("tbl_dokter", "tbl_dokter.id = tbl_pendaftaran.id_pj_dokter")
            ->join("tbl_pasien_cara_masuk", "tbl_pasien_cara_masuk.id = tbl_pendaftaran.id_cara_masuk")
            ->join("tbl_jenis_bayar", "tbl_jenis_bayar.id = tbl_pendaftaran.id_jenis_bayar")
            ->add_column('td_isi', '$1', 'str_placeholder(nama_ruangan, nama_poliklinik)')
            ->add_column('action', $actions, 'id');

        return $result->generate();
    }

    function dt_riwayat_barang($id_pendaftaran = null) {
        return $this->datatables->select("tbl_pendaftaran_riwayat_obat.id, kode_barang, nama_barang, harga, tanggal, qty, (harga * qty) as subtotal, id_status_acc, deskripsi_status_acc")
                               ->from("tbl_pendaftaran_riwayat_obat")
                               ->join("tbl_barang", "tbl_barang.id = tbl_pendaftaran_riwayat_obat.id_barang")
                               ->join("tbl_barang_kategori", "tbl_barang_kategori.id = tbl_barang.id_kat_barang")
                               ->join("tbl_status_acc", "tbl_status_acc.id = tbl_pendaftaran_riwayat_obat.id_status_acc")
                               ->add_column('status', '$1', 'draw_acc(id_status_acc, deskripsi_status_acc)');

    }

    function dt_riwayat_obat($id_pendaftaran = null) {
        $rs = $this->dt_riwayat_barang($id_pendaftaran)->where("id_kelompok", 1);
                               
        if(!empty($id_pendaftaran)) $rs = $rs->where("id_pendaftaran", $id_pendaftaran);

        return $rs->generate();
    }
    
    function dt_riwayat_alkes($id_pendaftaran = null) {
        $rs = $this->dt_riwayat_barang($id_pendaftaran)->where("id_kelompok", 2);
                               
        if(!empty($id_pendaftaran)) $rs = $rs->where("id_pendaftaran", $id_pendaftaran);

        return $rs->generate();
    }

    function get($id = null, $idrekamedis = null)
    {
        $result = $this->db->select("*, {$this->pk}")
            ->join("tbl_pasien_rekamedis", "tbl_pasien_rekamedis.id = {$this->table}.id_rekamedis")
            ->join("tbl_pasien_cara_masuk", "tbl_pasien_cara_masuk.id = {$this->table}.id_cara_masuk")
            ->join("tbl_poliklinik", "tbl_poliklinik.id = {$this->table}.id_poli")
            ->join("tbl_dokter", "tbl_dokter.id = {$this->table}.id_pj_dokter")
            ->join("tbl_pasien", "tbl_pasien.id = tbl_pasien_rekamedis.id_pasien")
            ->join("tbl_pasien_ranap", "{$this->pk} = tbl_pasien_ranap.id_pendaftaran", "left")
            ->join("tbl_rs_tempat_tidur", "tbl_rs_tempat_tidur.id = tbl_pasien_ranap.id_tempat_tidur", "left")
            ->join("tbl_rs_ruang", "tbl_rs_ruang.id = tbl_rs_tempat_tidur.id_ranap_ruang", "left")
            ->join("tbl_rs_ruang_kelas", "tbl_rs_ruang_kelas.id = tbl_rs_ruang.id_ruang_kelas", "left")
            ->join("tbl_rs_gedung", "tbl_rs_gedung.id = tbl_rs_ruang.id_ranap_gedung", "left")
            ;


        if (!empty($id)) $result = $result->where($this->pk, $id);
        if (!empty($idrekamedis)) $result = $result->where("{$this->table}.id_rekamedis", $idrekamedis);

        return $result->get($this->table);
    }

    // get all
    function get_all()
    {
        return $this->get()->result();
    }

    // get data by id
    function get_by_id($id)
    {
        return $this->get($id)->row();
    }

    /**
     * 
     */


    function insert_pendaftaran()
    {
        $id_rekamedis = $this->input->post('id_rekamedis', TRUE);
        $id_cara_masuk = $this->input->post('id_cara_masuk', TRUE);

        $rw = $this->db->get_where("tbl_pasien_cara_masuk", ["id" => $id_cara_masuk])->row();

        $id_status_rawat = $this->db->get_where("tbl_pasien_status_rawat", ["kode_status_rawat" => $rw->kode_cara_masuk])->row()->id;

        $dest_table = "bh_pendaftaran_pasien_lama";

        //print_r($this->input->post());

        $data = [
            'asal_rujukan' => $this->input->post('asal_rujukan', TRUE),
            'id_cara_masuk' => $id_cara_masuk,
            'id_status_rawat' => $id_status_rawat,
            'id_pj_dokter' => $this->input->post('id_pj_dokter', TRUE),
            'id_poli' => $this->input->post('id_poli', TRUE),
            'id_jenis_bayar' => $this->input->post('id_jenis_bayar', TRUE),
            'tgl_daftar' => $this->input->post('tgl_daftar', TRUE),
            'nama_pj' => $this->input->post('nama_pj', TRUE),
            'id_hub_dg_pj' => $this->input->post('id_hub_dg_pj', TRUE),
            'alamat_pj' => $this->input->post('alamat_pj', TRUE),
            'no_identitas_pj' => $this->input->post('no_identitas_pj', TRUE),
        ];

        if ($id_rekamedis == 0) {
            $data = array_merge($data, [
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
            ]);

            $dest_table = "bh_pendaftaran_pasien_baru";
        } else {
            $data = array_merge($data, ['id_rekamedis' => $id_rekamedis]);
        }

        return $this->db->insert($dest_table, stamp_insert($data));
    }


    /**
     * 
     */

    // insert data
    function insert($data)
    {
        return $this->db->insert($this->table, $data);
    }

    // update data
    function update($id, $data)
    {
        $this->db->where($this->id, $id);
        return $this->db->update($this->table, $data);
    }

    // delete data
    function delete($id)
    {
        $this->db->where($this->id, $id);
        return $this->db->delete($this->table);
    }

    /**
     * Start of custom functions
     */


    function change2Ranap($decoded_noRawat)
    {
        $data = ["cara_masuk" => "RAWAT INAP"];

        return $this->update($decoded_noRawat, $data);
    }

    function insert2Ranap($data)
    {
        $this->deposit->saldo_awal($data['no_rawat'], $data['jumlah_deposit']);
        $this->deposit->ruang_inap($data['no_rawat'], $data['kode_tempat_tidur'], $data['tanggal_masuk'], $data['tanggal_keluar']);

        unset($data['jumlah_deposit']);

        return $this->db->insert("tbl_rawat_inap", $data);
    }

    function getRiwayatObatJson($decoded_noRawat)
    {
        return $this->datatables
            ->select("")
            ->from('tbl_riwayat_pemberian_obat')
            ->join("tbl_obat_alkes_bhp", "tbl_obat_alkes_bhp.kode_barang = tbl_riwayat_pemberian_obat.kode_barang")
            ->join("tbl_status_acc", "tbl_status_acc.id_status_acc = tbl_riwayat_pemberian_obat.id_status_acc")
            ->where("no_rawat", $decoded_noRawat)
            ->generate();
    }

    function getRiwayatObat($decoded_noRawat)
    {
        return $this->db->select("*")
            ->join("tbl_obat_alkes_bhp", "tbl_obat_alkes_bhp.kode_barang = tbl_riwayat_pemberian_obat.kode_barang")
            ->join("tbl_status_acc", "tbl_status_acc.id_status_acc = tbl_riwayat_pemberian_obat.id_status_acc")
            ->where("no_rawat", $decoded_noRawat)
            ->get('tbl_riwayat_pemberian_obat');
    }

    function getDataPasien($decoded_noRawat)
    {
        return $this->db->select("*, tbl_pendaftaran.no_rawat")
            ->join("tbl_pasien", "tbl_pasien.no_rekamedis = tbl_pendaftaran.no_rekamedis")
            ->join("tbl_rawat_inap", "tbl_rawat_inap.no_rawat = tbl_pendaftaran.no_rawat", "left")
            ->join("tbl_tempat_tidur", "tbl_tempat_tidur.kode_tempat_tidur = tbl_rawat_inap.kode_tempat_tidur", "left")
            ->join("tbl_ruang_rawat_inap", "tbl_ruang_rawat_inap.kode_ruang_rawat_inap = tbl_tempat_tidur.kode_ruang_rawat_inap", "left")
            ->join("tbl_gedung_rawat_inap", "tbl_gedung_rawat_inap.kode_gedung_rawat_inap = tbl_ruang_rawat_inap.kode_gedung_rawat_inap", "left")
            ->join("tbl_kelas_ruang_ranap", "tbl_kelas_ruang_ranap.id_kelas_ruang_ranap = tbl_ruang_rawat_inap.kode_kelas", "left")
            ->where("tbl_pendaftaran.no_rawat", $decoded_noRawat)
            ->get('tbl_pendaftaran');
    }

    function tambahRiwayatBarang()
    {

        $kode_barang = $this->input->post('kode_obat');
        $jumlah_pembelian = $this->input->post('qty');

        $this->load->model(['Tbl_obat_alkes_bhp_model' => 'barang']);

        $barang = $this->barang->get_by_id($kode_barang);

        $keterangan = "PEMBELIAN \"{$barang->nama_barang}\" (KODE BARANG: \"{$barang->kode_barang}\") SEJUMLAH $jumlah_pembelian {$barang->nama_satuan}";

        $data = [
            "no_rawat"      => $this->input->post('no_rawat'),
            "kode_barang"   => $kode_barang,
            "jumlah"        => $jumlah_pembelian,
            "id_uic"        => $this->session->id_users,
            "keterangan"    => $keterangan
        ];

        return $this->db->insert('bh_riwayat_pemberian_obat', $data);
    }

    function tambahRiwayatTindakan()
    {
        $kd_tindakan       = $this->input->post('id_tindakan');
        $hasil_periksa  = $this->input->post('hasil_periksa');
        $perkembangan   = $this->input->post('perkembangan');
        $no_rawat       = $this->input->post('no_rawat');

        $id_dokter = $this->input->post('id_dokter');
        $id_petugas = $this->input->post('id_petugas');

        $this->load->model(['Tbl_tindakan_model' => 'tindakan']);

        $tindakan = $this->tindakan->get_by_id($kd_tindakan);

        $keterangan = "PEMBERIAN TINDAKAN \"{$tindakan->nama_tindakan}\"";

        $data = array(
            'no_rawat'      =>  $no_rawat,
            'hasil_periksa' =>  $hasil_periksa,
            'perkembangan'  =>  $perkembangan,
            'kode_tindakan' =>  $kd_tindakan,
            'id_dokter'     => $id_dokter,
            'id_pegawai'    => $id_petugas,
            'keterangan'    => $keterangan,
            "id_uic"        => $this->session->id_users,
        );

        return $this->db->insert('bh_riwayat_tindakan', $data);
    }

    function rekamedis()
    {
        $result = $this->ajax->select("tbl_pasien_rekamedis.id, no_rekamedis, no_kartu, nama_pasien")
            ->from("tbl_pasien_rekamedis")
            ->join("tbl_pasien", "tbl_pasien.id = tbl_pasien_rekamedis.id_pasien")
            ->searchable_column(["no_rekamedis", "no_kartu", "nama_pasien"])
            ->generate(null, null, false);

        array_unshift($result, [
            "id" => "0",
            "no_rekamedis" => null,
            "no_kartu" => null,
            "nama_pasien" => "Tambahkan pasien baru",
        ]);

        return json_encode($result);
    }

    /**
     * 
     */

    function do_beriobat() {
        $id_pendaftaran = $this->input->post("id_pendaftaran");
        $id_barang = $this->input->post("id_barang");
        $qty = $this->input->post("qty");

        $data = [
            "id_pendaftaran" => $id_pendaftaran,
            "id_barang" => $id_barang,
            "qty" => $qty,
        ];

        return $this->db->insert("tbl_pendaftaran_riwayat_obat", stamp_insert($data));
    }
}

/* End of file Tbl_pendaftaran_model.php */
/* Location: ./application/models/Tbl_pendaftaran_model.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-12-04 08:39:11 */
/* http://harviacode.com */