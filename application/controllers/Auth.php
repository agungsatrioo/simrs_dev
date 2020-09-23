<?php
class Auth extends CI_Controller
{

    function index()
    {
        $this->load->view('auth/login');
    }

    function cheklogin()
    {
        $email      = $this->input->post('email');
        $password   = $this->input->post('password');
        // query chek users
        $this->db->where('email', $email);
        $this->db->where('password',  md5($password));
        $user       = $this->db->get('tbl_user');
        
        if ($user->num_rows() > 0) {
            $user_data = $user->row_array();

            unset($user_data['password']);

            switch($user_data['id_user_level']) {
                case 3: //Dokter
                    echo "<pre>";
                    $mail_dokter = explode("@", $user_data['email']);
                    $this->load->model('Tbl_dokter_model'); 

                    $dokter = $this->Tbl_dokter_model->get_by_id_array($mail_dokter[0]);

                    $user_data = array_merge($user_data, $dokter);
                break;

            }
            $this->session->set_userdata($user_data);

            redirect('');
        } else {
            $this->session->set_flashdata('status_login', 'email atau password yang anda input salah');
            redirect('auth');
        }
    }

    function dokter() {

    }

    function logout()
    {
        $this->session->sess_destroy();
        $this->session->set_flashdata('status_login', 'Anda sudah berhasil keluar dari aplikasi');
        redirect('auth');
    }
}
