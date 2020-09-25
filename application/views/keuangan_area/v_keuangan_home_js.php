<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');
?>

<script>
    $(document).ready(function() {
        $('#tbl_keuangan').DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: 'keuangan_area/keu_ajax',
                method: 'POST'
            },
        });
    });
</script>