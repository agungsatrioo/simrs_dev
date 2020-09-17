<section class="sidebar">
    <!-- search form -->
    <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
            <input type="text" name="q" class="form-control" placeholder="Search...">
            <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
            </span>
        </div>
    </form>
    <!-- /.search form -->
    <!-- sidebar menu: : style can be found in sidebar.less -->
    <ul class="sidebar-menu" data-widget="tree">
        <?php
        // display all data main menu
        $this->db->where('is_main_menu',0);
        $this->db->where('is_aktif','y');
        $main_menu = $this->db->get('tbl_menu')->result();
        
        foreach ($main_menu as $menu){
            // chek is have sub menu
            $this->db->where('is_main_menu',$menu->id_menu);
            $this->db->where('is_aktif','y');
            $submenu = $this->db->get('tbl_menu');

            if($submenu->num_rows()>0){
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

                // display sub menu
                echo "<li class='treeview $menu_open_str'>
                        <a href='#'>
                            <i class='$menu->icon'></i> <span>".strtoupper($menu->title)."</span>
                            $pull_span_str
                        </a>
                        <ul class='treeview-menu' style='$display_style_str;'>
                        $submenu_list
                        </ul>
                        </li>
                        ";
            }else{
                // display main menu
                $menu_active = current_url() == base_url($menu->url) ? "class='active'" : "";

                echo "<li $menu_active>";
                echo anchor($menu->url,"<i class='".$menu->icon."'></i> ".strtoupper($menu->title));
                echo "</li>";
            }
        }
        ?>
        <li><?php echo anchor('auth/logout',"<i class='fa fa-sign-out'></i> LOGOUT");?></li>
    </ul>
</section>
<!-- /.sidebar -->