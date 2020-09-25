<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');
?>

<script>
    $(document).ready(function() {
        $('#tbl_apoteker').DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: 'apotek_area/apotek_ajax',
                method: 'POST'
            },
        });
    });
</script>