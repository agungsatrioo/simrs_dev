<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Private_Controller extends MY_Controller
{

    function __construct()
    {
        parent::__construct();

        if (empty($this->session->id_users)) redirect('auth');

        $this->restrictAccess();
    }

    protected function restrictAccess()
    {
        $exclusion = ["ajax", "autocomplete", "autocomplate", "json", "pdf", "excel", "word"];
        $user_level = $this->session->id_user_level;

        switch ($user_level) {
            case 1:
            case 2:
                break;
            default:
                $this->load->model(["Useraccess_model" => "access"]);

                $url_list = $this->access->get_url_list($user_level);
                $urls = array_merge($url_list, $exclusion);
                $current_class = $this->router->fetch_class();

                //if(!checkInArray(current_url(), $urls) && $current_class != "dashboard") redirect(base_url());
        }
    }
}
