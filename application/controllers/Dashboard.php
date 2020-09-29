<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Dashboard extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->library('datatables');
    }

    public function index()
    {
        $data = [];
        $data['create_link'] = base_url("");
        $this->template->load('template', 'dashboard/dashboard', $data);
    }
}
