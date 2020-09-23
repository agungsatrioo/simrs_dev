<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

require_once('MY_Controller.php');

class Admin_Controller extends MY_Controller {

    function __construct()
    {
        parent::__construct();
        
        if(empty($this->session->id_users)) redirect('auth');
    }
}