<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Generate extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model(["Tbl_pendaftaran_model"=> "pendaftaran"]);
        $this->load->library('datatables');
    }

    function index() {
        $data = [];

        $data['script'] = $this->load_js("generate/generate_js", $data);
        $this->template->load('template', 'generate/generate_index', $data);
    }

    function pendaftaran() {
        $daterange = $this->input->post('daterange');
        $date = explode("_", $daterange);

        print_r($daterange);
    }
}