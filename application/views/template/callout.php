<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

?>

<?php if(isset($error)) { ?>
            <div class="callout callout-danger">
                <h4>Maaf, kegagalan telah terjadi.</h4>
                <p><?= @$error ?></p>
            </div>
        <?php } ?>

        <?php if(isset($success) || isset($message)) { ?>
            <div class="callout callout-success">
                <h4>Pesan dari sistem:</h4>
                <p><?= @$success . @$message ?></p>
            </div>
        <?php } ?>