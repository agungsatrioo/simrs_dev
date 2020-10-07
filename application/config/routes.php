<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	https://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There are three reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router which controller/method to use if those
| provided in the URL cannot be matched to a valid route.
|
|	$route['translate_uri_dashes'] = FALSE;
|
| This is not exactly a route, but allows you to automatically route
| controller and method names that contain dashes. '-' isn't a valid
| class or method name character, so it requires translation.
| When you set this option to TRUE, it will replace ALL dashes in the
| controller and method URI segments.
|
| Examples:	my-controller/index	-> my_controller/index
|		my-controller/my-method	-> my_controller/my_method
*/
$route['default_controller'] = 'dashboard';
$route['404_override'] = '';
$route['translate_uri_dashes'] = FALSE;

$route['barang/kelompok'] = "kelompokbarang";
$route['barang/kelompok/json'] = "kelompokbarang/json";
$route['barang/kelompok/create'] = "kelompokbarang/create";
$route['barang/kelompok/(:num)/update'] = "kelompokbarang/update/$1";
$route['barang/kelompok/(:num)/delete'] = "kelompokbarang/delete/$1";
$route['barang/kelompok/do_create'] = "kelompokbarang/create_action";
$route['barang/kelompok/do_update'] = "kelompokbarang/update_action";

$route['barang/kategori'] = "kategoribarang";
$route['barang/kategori/json'] = "kategoribarang/kategori_json";
$route['barang/kategori/create'] = "kategoribarang/kategori_create";
$route['barang/kategori/(:num)/update'] = "kategoribarang/kategori_update/$1";
$route['barang/kategori/(:num)/delete'] = "kategoribarang/kategori_delete/$1";
$route['barang/kategori/do_create'] = "kategoribarang/kategori_create_action";
$route['barang/kategori/do_update'] = "kategoribarang/kategori_update_action";

$route['barang/satuan'] = "datasatuan";
$route['barang/satuan/json'] = "datasatuan/json";
$route['barang/satuan/create'] = "datasatuan/create";
$route['barang/satuan/(:num)/update'] = "datasatuan/update/$1";
$route['barang/satuan/(:num)/delete'] = "datasatuan/delete/$1";
$route['barang/satuan/do_create'] = "datasatuan/create_action";
$route['barang/satuan/do_update'] = "datasatuan/update_action";

$route['barang/supplier'] = "supplier";
$route['barang/supplier/json'] = "supplier/json";
$route['barang/supplier/create'] = "supplier/create";
$route['barang/supplier/(:num)/update'] = "supplier/update/$1";
$route['barang/supplier/(:num)/delete'] = "supplier/delete/$1";
$route['barang/supplier/do_create'] = "supplier/create_action";
$route['barang/supplier/do_update'] = "supplier/update_action";

$route['pendaftaran/detail/(:num)/mutasi'] = "pendaftaran/mutasi/$1";

$route['pendaftaran/detail/(:num)/perjalanan'] = "pendaftaran/perjalanan/$1";
$route['pendaftaran/detail/(:num)/perjalanan/(:num)/delete'] = "pendaftaran/rj_delete/$1/$2";
$route['pendaftaran/detail/(:num)/perjalanan/create'] = "pendaftaran/rj_form/$1";

$route['pendaftaran/detail/(:num)/diary'] = "pendaftaran/diary/$1";
$route['pendaftaran/detail/(:num)/diary/(:num)/delete'] = "pendaftaran/diary_delete/$1/$2";
$route['pendaftaran/detail/(:num)/diary/create'] = "pendaftaran/diary_form/$1";
