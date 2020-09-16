<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Template {
		var $template_data = array();
		
		function set($name, $value)
		{
			$this->template_data[$name] = $value;
		}
	
		function load($template = '', $view = '' , $view_data = array(), $return = FALSE)
		{               
			$this->CI =& get_instance();
			
			$view_data['success'] = $this->CI->session->flashdata('success');
			$view_data['message'] = $this->CI->session->flashdata('message');

			$view_data['error'] = $this->CI->session->flashdata('error');

			$view_data['callout'] = $this->CI->load->view('template/callout', $view_data, TRUE);

			$this->set('contents', $this->CI->load->view($view, $view_data, TRUE));	

			return $this->CI->load->view($template, $this->template_data, $return);
		}
}

/* End of file Template.php */
/* Location: ./system/application/libraries/Template.php */