<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Template {
		var $template_data = array();

		private function set($name, $value)
		{
			$this->template_data[$name] = $value;
		}

		private function generate_sidebar() {
			$ci =& get_instance();
			$menu_lists = "";

			$main_menu = $ci->db->get_where("tbl_menu", ["is_main_menu" => 0, "is_aktif" => 'y'])->result();

			foreach ($main_menu as $menu) {
				$submenu = $ci->db->get_where("tbl_menu", ["is_main_menu" => $menu->id_menu, "is_aktif" => 'y']);
			
				if($submenu->num_rows() > 0) {
					$submenu_list = "";
					$tree_expand = false;
					$menu_open_str = "";
					$display_style_str = "display: none";
					$pull_span_str = "<span class='pull-right-container'><i class='fa fa-angle-left pull-right'></i></span>";
	
					foreach ($submenu->result() as $sub){
						$is_submenu_current = current_url() == base_url($sub->url);
	
						$sub_active = $is_submenu_current ? "class='active'" : "";
	
						if($is_submenu_current && !$tree_expand) {
							$tree_expand = true;
							$menu_open_str = "menu-open";
							$display_style_str = "display:block";
							$pull_span_str = "";
						}
	
						 $submenu_list .= "<li $sub_active>".anchor($sub->url,"<i class='$sub->icon'></i> ".strtoupper($sub->title))."</li>"; 
					}

					$menu_lists .= "<li class='treeview $menu_open_str'>
					<a href='#'>
						<i class='$menu->icon'></i> <span>".strtoupper($menu->title)."</span>
						$pull_span_str
					</a>
					<ul class='treeview-menu' style='$display_style_str;'>
					$submenu_list
					</ul>
					</li>
					";
				} else {
					$menu_active = current_url() == base_url($menu->url) ? "class='active'" : "";

					$menu_lists .= "<li $menu_active>";
					$menu_lists .= anchor($menu->url,"<i class='".$menu->icon."'></i> ".strtoupper($menu->title));
					$menu_lists .= "</li>";
				}
			}

			return $menu_lists;
		}

		function load($template = '', $view = '' , $view_data = array(), $return = FALSE)
		{
			$ci =& get_instance();

			//Show message/success/error alert.
			$view_data['success'] = $ci->session->flashdata('success');
			$view_data['message'] = $ci->session->flashdata('message');
			$view_data['error'] = $ci->session->flashdata('error');

			$view_data['callout'] = $ci->load->view('template/callout', $view_data, TRUE);
			$view_data['sidebar_menu'] = $this->generate_sidebar();

			$this->set('contents', $ci->load->view($view, $view_data, TRUE));	

			return $ci->load->view($template, $this->template_data, $return);
		}

		function make_form($forms) {
			$result = new stdClass();
			$result_html = "";
			$result_html_array = [];

			foreach($forms as $key=>$item) {
				$individualInput = "";
				$defaultValue = set_value($key);
				$formError = form_error($key);
				$hasError = !empty($formError) ? "has-error" : "";

				switch($item['type']) {
					case 'dropdown':
					break;
					case 'date':
						$individualInput = "<input type=\"date\" class=\"form-control\" name=\"{$key}\" id=\"{$key}\" placeholder=\"{$item['placeholder']}\" value=\"{$defaultValue}\">";
					break;
					default:
						$individualInput = "<input type=\"text\" class=\"form-control\" name=\"{$key}\" id=\"{$key}\" placeholder=\"{$item['placeholder']}\" value=\"{$defaultValue}\">";
				}

				$individualFormGroup = "<div class=\"form-group {$hasError}\">
					<label for=\"{$key}\" class=\"col-sm-2 control-label\">{$item['caption']}</label>
					<div class=\"col-sm-10\">
						{$individualInput}
						<span class=\"help-block\">{$formError}</span>
					</div>
				</div>";

				$result_html_array[] = $individualFormGroup;
				$result_html .= $individualFormGroup;
			}

			$result->form_html = $result_html;
			$result->form_html_array = $result_html_array;

			return $result;
		}
}

/* End of file Template.php */
/* Location: ./system/application/libraries/Template.php */