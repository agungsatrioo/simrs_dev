<?php

function hari_ini()
{
	$hari = date("D");

	switch ($hari) {
		case 'Sun':
			$hari_ini = "Minggu";
			break;

		case 'Mon':
			$hari_ini = "Senin";
			break;

		case 'Tue':
			$hari_ini = "Selasa";
			break;

		case 'Wed':
			$hari_ini = "Rabu";
			break;

		case 'Thu':
			$hari_ini = "Kamis";
			break;

		case 'Fri':
			$hari_ini = "Jumat";
			break;

		case 'Sat':
			$hari_ini = "Sabtu";
			break;

		default:
			$hari_ini = "Tidak di ketahui";
			break;
	}

	return strtoupper($hari_ini);
}

function enc_str($str)
{
	return str_replace('=', '-', str_replace('/', '_', base64_encode($str)));
}

function dec_str($str)
{
	return base64_decode(str_replace('-', '=', str_replace('_', '/', $str)));
}
