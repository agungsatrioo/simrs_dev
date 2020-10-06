<?php
function widgetMainMenu()
{
	$ci = get_instance();
	//$query = $ci->db->query("SELECT * FROM tbl_menu WHERE is_main_menu = '0' AND is_aktif = 'y' AND id != 19 AND id != 30 AND id != 35 AND id != 22 AND id != 40 AND id !=41 AND id !=42 AND id != 43 AND id != 44" );

	$query = $ci->db->query("SELECT *, (select count(*) from tbl_menu t where t.is_main_menu = tbl_menu.id) as child_count FROM tbl_menu WHERE is_main_menu = '0' AND is_aktif = 'y' AND tabel IS NOT NULL having child_count < 1");

	return $query;
}
function widgetMainMenuCountNumber($id)
{
	$ci = get_instance();
	$query = $ci->db->query("SELECT * FROM ".$id)->num_rows();
	return $query;
}
function widgetSubMenu()
{
	$ci = get_instance();
	$query = $ci->db->query("SELECT *, (select count(*) from tbl_menu t where t.is_main_menu = tbl_menu.id) as child_count FROM tbl_menu where is_aktif = 'y' having child_count > 0");
	return $query;
}
function widgetSubMenuChild($id)
{
	$ci = get_instance();
	$query = $ci->db->query("SELECT * FROM tbl_menu WHERE is_main_menu = '".$id."'");
	return $query;
}
?>