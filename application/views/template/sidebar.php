<section class="sidebar">
    <!-- sidebar menu: : style can be found in sidebar.less -->
    <ul class="sidebar-menu" data-widget="tree">
        <?= $sidebar_menu ?>
        <li><?php echo anchor('auth/logout',"<i class='fa fa-sign-out'></i> LOGOUT");?></li>
    </ul>
</section>
<!-- /.sidebar -->