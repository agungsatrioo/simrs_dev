<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Template {
		var $template_data = array();

		private function set($name, $value)
		{
			$this->template_data[$name] = $value;
		}

		private function generate_sidebar() {
			$menuLists = "";


		}

		function load($template = '', $view = '' , $view_data = array(), $return = FALSE)
		{
			$ci =& get_instance();

			$view_data['success'] = "test"; //$ci->session->flashdata('success');
			$view_data['message'] = "test";//$ci->session->flashdata('message');
			$view_data['error'] = "test";//$ci->session->flashdata('error');
			
			//Show message/success/error alert.
			/*
			$view_data['success'] = $ci->session->flashdata('success');
			$view_data['message'] = $ci->session->flashdata('message');
			$view_data['error'] = $ci->session->flashdata('error');
			*/

			$view_data['callout'] = $ci->load->view('template/callout', $view_data, TRUE);

			$this->set('contents', $ci->load->view($view, $view_data, TRUE));	

			return $ci->load->view($template, $this->template_data, $return);
		}
}

/* End of file Template.php */
/* Location: ./system/application/libraries/Template.php */