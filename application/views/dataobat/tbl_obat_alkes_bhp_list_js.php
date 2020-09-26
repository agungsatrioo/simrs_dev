<script type="text/javascript">
    $(document).ready(function() {
        $('#barangTable').DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: "<?php echo base_url("dataobat/json") ?>",
                method: 'POST'
            }
        });
    });
</script>