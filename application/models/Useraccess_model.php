<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Useraccess_model extends CI_Model
{
    private $table = "tbl_akses_menu";

    function __construct()
    {
        parent::__construct();
    }

    private function _checkAccess($user_level, $id_menu)
    {
        $menu_access = $this->db->get_where($this->table, array('id_menu' => $id_menu, 'id_user_level' => $user_level))->result();

        return !empty($menu_access); //harus true jika user level mempunyai akses ke menu
    }

    public function getUserAccessibleMenu($id_user_level)
    {
        $data = [];

        $menu_access = $this->db->get_where($this->table, array('id_user_level' => $id_user_level))->result();

        foreach ($menu_access as $menuItem) {
            $data[] = $menuItem->id_menu;
        }

        return $data;
    }

    private function listSubmenus($id_menu)
    {
        $menus = [];

        if ($id_menu == 0) return $menus;

        $submenus = $this->db->get_where('tbl_menu', array('is_main_menu' => $id_menu))->result();

        foreach ($submenus as $submenu) {
            $menus[] = $submenu->id_menu;
        }

        return $menus;
    }

    private function getParentMenu($id_menu)
    {
        $parent = $this->db->get_where('tbl_menu', array('id_menu' => $id_menu))->row();

        if ($parent->is_main_menu != 0) return $parent->is_main_menu;
    }

    public function generate_chkbox_level($id_menu)
    {
        /**
         * Generate menu yang menentukan sebuah menu dapat diakses oleh siapa saja selain (super)admin.
         * 
         *  Menu dapat diakses oleh:
         *  [ ] Dokter       [ ] Keuangan
         *  [x] Apoteker
         */

        $levels = $this->db->where('id_user_level !=', '1')
            ->where('id_user_level !=', '2')
            ->get("tbl_user_level")
            ->result();

        $chkBoxes = [];
        $chkBoxesHTML = "<ul>";

        foreach ($levels as $item) {
            $chkBoxes[] = [$this->_checkAccess($item->id_user_level, $id_menu), $item->id_user_level, $item->nama_level];
        }

        foreach ($chkBoxes as $item) {
            $checked = $item[0] ? "checked" : "";

            $chkBoxesHTML .= "<li>
                <label class=\"checkbox-inline\">
                    <input type=\"checkbox\" id=\"ulevel[]\" name=\"ulevel[]\" value=\"{$item[1]}\" $checked> {$item[2]}
                </label>
            </li>";
        }

        $chkBoxesHTML .= "</ul>";

        return $chkBoxesHTML;
    }

    public function delete_if_no_child_left($id_parent_menu, $id_user_level)
    {
        /**
         *  Cari submenu, lalu query hak akses. Jika tidak ada child menu yg mempunyai hak akses, maka hapus parent menu.
         */
        $submenus = $this->listSubmenus($id_parent_menu);
        $data = [];

        foreach ($submenus as $menuitem) {
            $akses = $this->_checkAccess($id_user_level, $menuitem);

            if ($akses) $data[] = $menuitem;
        }

        if (empty($data)) return $this->delete($id_parent_menu, $id_user_level);
        return true;
    }

    public function add_if_orphan($id_parent_menu, $id_user_level)
    {
        /**
         *  Cari submenu, lalu query hak akses. Jika tidak ada child menu yg mempunyai hak akses, maka hapus parent menu.
         */
        $submenus = $this->listSubmenus($id_parent_menu);
        $data = [];

        foreach ($submenus as $menuitem) {
            $akses = $this->_checkAccess($id_user_level, $menuitem);

            if ($akses) $data[] = $menuitem;
        }

        if (empty($data)) return $this->insert($id_parent_menu, $id_user_level);
        return true;
    }

    public function ubah_akses($id_menu, $data_akses)
    {
        /**
         * Mengubah akses ke menu.
         * 
         * $id_menu berupa menu yang akan diubah hak aksesnya.
         * $data_akses berupa array perubahan siapa saja yg bisa mengakses menu. Contoh [4] menjadi [3,4]
         */

        $menu_access = $this->db->get_where($this->table, array('id_menu' => $id_menu))->result();
        $submenus = $this->listSubmenus($id_menu);

        $menu_access_orig = [];

        foreach ($menu_access as $item) {
            $menu_access_orig[] = $item->id_user_level; //mendapatkan siapa aja yang tadinya dapat mengakses menu.
        }

        if ($data_akses == null) $data_akses = [];

        $deleted  = array_diff($menu_access_orig, $data_akses);
        $inserted  = array_diff($data_akses, $menu_access_orig);

        foreach ($deleted as $userRevoked) {
            $this->delete($id_menu, $userRevoked);

            foreach ($submenus as $submenu) {
                $this->delete($submenu, $userRevoked);
            }

            $parent = $this->getParentMenu($id_menu);

            $this->delete_if_no_child_left($parent, $userRevoked);
        }

        foreach ($inserted as $userGranted) {
            $this->insert($id_menu, $userGranted);

            foreach ($submenus as $submenu) {
                $this->insert($submenu, $userGranted);
            }

            $parent = $this->getParentMenu($id_menu);

            if ($parent != null) $this->add_if_orphan($parent, $userGranted);
        }

        return true;
    }

    public function insert($id_menu, $id_user_level)
    {
        return $this->db->insert($this->table, ["id_menu" => $id_menu, "id_user_level" => $id_user_level]);
    }

    function delete($id_menu, $id_user_level)
    {
        if ($id_menu == 0) return true;

        $this->db->where(array('id_menu' => $id_menu, 'id_user_level' => $id_user_level));
        return $this->db->delete($this->table);
    }

    function get_url_list($id_user_level) {
        $result = $this->db->select("{$this->table}.id_menu, id_user_level, url")
                            ->where("id_user_level", $id_user_level)
                            ->join("tbl_menu", "tbl_menu.id_menu = {$this->table}.id_menu")
                            ->get($this->table)->result();

        $data = [];

        foreach($result as $item) {
            $explode = explode("/", $item->url);
            $data[] = $explode[0];
        }

        return array_unique($data);
    }
}
