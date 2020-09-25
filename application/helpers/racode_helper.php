<?php

function cmb_dinamis($name, $table, $field, $pk, $selected = null, $readonly = false)
{
    $ci = get_instance();
    $cmb = "<select name='$name' class='form-control'>";
    $data = $ci->db->get($table)->result();

    foreach ($data as $d) {
        if ($readonly == true) {
            if ($selected != $d->$pk) continue;
        }

        $cmb .= "<option value='" . $d->$pk . "'";
        $cmb .= $selected == $d->$pk ? " selected='selected'" : '';
        $cmb .= ">" .  strtoupper($d->$field) . "</option>";
    }

    $cmb .= "</select>";
    return $cmb;
}

function select2_dinamis($name, $table, $field, $placeholder)
{
    $ci = get_instance();
    $select2 = '<select name="' . $name . '" class="form-control select2 select2-hidden-accessible" multiple="" 
               data-placeholder="' . $placeholder . '" style="width: 100%;" tabindex="-1" aria-hidden="true">';
    $data = $ci->db->get($table)->result();
    foreach ($data as $row) {
        $select2 .= ' <option>' . $row->$field . '</option>';
    }
    $select2 .= '</select>';
    return $select2;
}

function datalist_dinamis($name, $table, $field, $value = null)
{
    $ci = get_instance();
    $string = '<input value="' . $value . '" name="' . $name . '" list="' . $name . '" class="form-control">
    <datalist id="' . $name . '">';
    $data = $ci->db->get($table)->result();
    foreach ($data as $row) {
        $string .= '<option value="' . $row->$field . '">';
    }
    $string .= '</datalist>';
    return $string;
}

function rename_string_is_aktif($string)
{
    return $string == 'y' ? 'Aktif' : 'Tidak Aktif';
}

function is_login()
{
    $ci = get_instance();
    if (empty($ci->session->userdata('id_users'))) {
        redirect('auth');
    }
}

function alert($class, $title, $description)
{
    return '<div class="alert ' . $class . ' alert-dismissible">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                <h4><i class="icon fa fa-ban"></i> ' . $title . '</h4>
                ' . $description . '
              </div>';
}

function noRekemedisOtomatis()
{
    $ci = get_instance();
    // mencari kode barang dengan nilai paling besar
    $query = "SELECT max(no_rekamedis) as maxKode FROM tbl_pasien";
    $data = $ci->db->query($query)->row_array();
    $kode = $data['maxKode'];
    $noUrut = (int) substr($kode, 0, 6);
    $noUrut++;
    $kodeBaru = sprintf("%06s", $noUrut);
    return $kodeBaru;
}

function noRegOtomatis()
{
    $ci = get_instance();
    $today = date('Y-m-d');
    // mencari kode barang dengan nilai paling besar
    $query = "SELECT max(no_registrasi) as maxKode FROM tbl_pendaftaran where tanggal_daftar='$today'";
    $data = $ci->db->query($query)->row_array();
    $kode = $data['maxKode'];
    $noUrut = (int) substr($kode, 0, 6);
    $noUrut++;
    $kodeBaru = sprintf("%04s", $noUrut);
    return $kodeBaru;
}

function autocomplate_json($table, $field)
{
    $ci = get_instance();
    $ci->db->like($field, $_GET['term']);
    $ci->db->select($field);
    $collections = $ci->db->get($table)->result();

    $return_arr = [];

    foreach ($collections as $collection) {
        $return_arr[] = $collection->$field;
    }
    echo json_encode($return_arr);
}

function draw_acc($status, $desc)
{
    $icon = "";
    $color = "";
    //span class="fa fa-hourglass text-success"></span> Menunggu
    switch ($status) {
        case 1:
            $icon = "fa-hourglass";
            $color = "text-primary";
            break;
        case 2:
            $icon = "fa-check";
            $color = "text-success";
            break;
        case 3:
            $icon = "fa-times";
            $color = "text-danger";
            break;
    }

    return "<b class='$color'><i class='fa $icon'></i>&nbsp;$desc</b>";
}

function kali($a, $b)
{
    return $a * $b;
}

function jumlah_total($a, $b)
{
    return rupiah(kali($a, $b));
}

function checkInArray($str, $arr, $pass = false)
{
    if ($pass) return true;

    foreach ($arr as $url) {
        //if (strstr($string, $url)) { // mine version
        if (strpos("$str", $url) !== FALSE) { // Yoshi version
            return true;
        }
    }
}

function make_apoteker($jabatan, $nik) {
    if(strtoupper($jabatan) == "APOTEKER")
    return anchor(site_url('pegawai/make_apoteker/'.$nik), '<i class="fa fa-user" aria-hidden="true"></i> Buat akun apoteker', array('class' => 'btn btn-primary btn-sm', 'style' => 'margin: 5px !important')). "&nbsp;";
}

function make_keuangan($jabatan, $nik) {
    if(strtoupper($jabatan) == "KEUANGAN")
    return anchor(site_url('pegawai/make_keuangan/'.$nik), '<i class="fa fa-user" aria-hidden="true"></i> Buat akun keuangan', array('class' => 'btn btn-primary btn-sm mr-1', 'style' => 'margin: 5px !important')). "&nbsp;";
}

function generate_number($int, $leading_zeros) {
    return str_pad($int, $leading_zeros, 0, STR_PAD_LEFT);
}


function kode_gen($string, $id = null, $leadingStrLength = 2, $numberLeadingZeroLength = 5, $separator = ""){
    $results = ''; // empty string
    $vowels = array('a', 'e', 'i', 'o', 'u', 'y'); // vowels
    preg_match_all('/[A-Z][a-z]*/', ucfirst($string), $m); // Match every word that begins with a capital letter, added ucfirst() in case there is no uppercase letter
    foreach($m[0] as $substring){
        $substring = str_replace($vowels, '', strtolower($substring)); // String to lower case and remove all vowels
        $results .= preg_replace('/([a-z]{'.$leadingStrLength.'})(.*)/', '$1', $substring); // Extract the first N letters.
    }
    $results .= $separator. str_pad($id, $numberLeadingZeroLength, 0, STR_PAD_LEFT); // Add the ID
    return $results;
}

function str_placeholder($a, $b) {
    return !empty($a) ? $a : $b;
}