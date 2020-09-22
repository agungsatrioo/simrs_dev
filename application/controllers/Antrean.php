<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Antrean extends Private_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('Antrean_model');
    }

    public function index() {
        $last_id = $this->Antrean_model->last_id();

        $data['last_id'] = $last_id;

        $this->template->load('template', 'antrean/antrean_list', $data);
    }

    public function skip() {
        if($this->Antrean_model->skip()) {
            redirect(base_url('antrean'));
        }
    }
    
    public function next() {
        if($this->Antrean_model->next()) {
            redirect(base_url('antrean'));
        }
    }
    public function insert() {
        if($this->Antrean_model->insert()) {
            redirect(base_url('antrean'));
        }
    }

    public function fullscreen_view() {
        $last_id = $this->Antrean_model->last_id();

        $data['last_id'] = $last_id;

        $this->load->view('antrean/second_view', $data);
    }
}