<?php

defined('BASEPATH') OR exit('No direct script access allowed');
// base url bpjs
$config['bpjs_url'] = 'https://dvlp.bpjs-kesehatan.go.id/vclaim-rest/';

// kode dari bpjs
$config['bpjs_id'] = '';
$config['bpjs_key'] = '';


$_SESSION['cid']= $config['bpjs_id'];
$_SESSION['ckey'] = $config['bpjs_key'];
