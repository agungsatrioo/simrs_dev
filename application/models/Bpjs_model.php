<?php

class Bpjs_model extends CI_Model{
	public $url;
	public $id;
    public $key;
    
	function __construct(){
		parent:: __construct();
		require APPPATH . 'config/bpjs.php';
		foreach ($config as $key =>$val) {
			$$key = $val;
		}
		$this->url = $bpjs_url;
		$this->id = $bpjs_id;
		$this->key = $bpjs_key;
	}

	public function get_users(){
		return $this->db->get('admin');
	}

	public function post_user($arr){
		return $this->db->insert('user',$arr);
	}

	public function delete($id){
		$this->db->where('id_user',$id);
		return $this->db->delete('user');
	}

	public function get_userById($id){
		$this->db->where('id',$id);
		return $this->db->get('admin');
	}

	 public function peserta($id,$date,$option){
	 	// require APPPATH . 'config/bpjs.php';
        $url = $this->url.'peserta/'.$option.'/'.$id.'/tglSEP/'.$date; 
            
            $cid = $this->id ;
            $ckey = $this->key;

            date_default_timezone_set("Asia/Jakarta");
            $timestamp = strtotime(date("Y/m/d H:i:s"));
            $data = $cid."&".$timestamp;
            $signature = hash_hmac('sha256', $data, $ckey, true);
            $encodedSignature = base64_encode($signature);


            $arrheader = array(
                'X-cons-id: '.$cid,
                'X-Timestamp: '.$timestamp,
                'X-Signature: '.$encodedSignature,
                'Accept: application/json',
                'Content-Type: application/json'
            );
                   $session = curl_init (); 
                    curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
                    curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
                    curl_setopt($session, CURLOPT_URL, $url);
                    // curl_setopt($session, CURLOPT_TIMEOUT, 5);
                    // curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
                $response = curl_exec($session);
                if (!$response) {
                   echo $err = curl_error($session);

                }else{
                   
                }
                curl_close($session);
             return $response;
    }


    

      public function poli($no =""){

        $url = $this->url.'referensi/poli/'.$no;   
            
            $cid = $this->id ;
            $ckey = $this->key;

            date_default_timezone_set("Asia/Jakarta");
            $timestamp = strtotime(date("Y/m/d H:i:s"));
            $data = $cid."&".$timestamp;
            $signature = hash_hmac('sha256', $data, $ckey, true);
            $encodedSignature = base64_encode($signature);


            $arrheader = array(
                'X-cons-id: '.$cid,
                'X-Timestamp: '.$timestamp,
                'X-Signature: '.$encodedSignature,
                'Accept: application/json',
                'Content-Type: application/json'
            );
                   $session = curl_init (); 
                    curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
                    curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
                    curl_setopt($session, CURLOPT_URL, $url);
                    curl_setopt($session, CURLOPT_TIMEOUT, 5);
                    curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
                $response = curl_exec($session);
                if (!$response) {
                   echo $err = curl_error($session);

                }else{
                   
                }
                curl_close($session);
             return $response;
    } 


    public function carisep($no){

        $url = $this->url.'SEP/'.$no;   
        $cid = $this->id ;
        $ckey = $this->key;

        date_default_timezone_set("Asia/Jakarta");
        $timestamp = strtotime(date("Y/m/d H:i:s"));
        $data = $cid."&".$timestamp;
        $signature = hash_hmac('sha256', $data, $ckey, true);
        $encodedSignature = base64_encode($signature);


        $arrheader = array(
            'X-cons-id: '.$cid,
            'X-Timestamp: '.$timestamp,
            'X-Signature: '.$encodedSignature,
            'Accept: application/json',
            'Content-Type: Application/x-www-form-urlencoded'
        );
               $session = curl_init (); 
                curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
                curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($session, CURLOPT_URL, $url);
                curl_setopt($session, CURLOPT_TIMEOUT, 5);
                curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
            $response = curl_exec($session);
            if (!$response) {
               echo $err = curl_error($session);

            }else{
                curl_close($session);
         return $response;
            }
 
}



public function insert_sep($arr){


    // create
    $url = $this->url.'SEP/1.1/insert'; 
    // update
    // $url = 'https://dvlp.bpjs-kesehatan.go.id/vclaim-rest/SEP/1.1/update'; 
    $kode_ppk = "1406R001";

     $data = array("request"=> array( 
                          "t_sep"=> array( 
                             "noKartu"=> $arr['noKartu'],
                             "tglSep"=> $arr['tglSep'],
                             "ppkPelayanan"=>$arr['ppkPelayanan'],
                             "jnsPelayanan"=> $arr['jnsPelayanan'],
                             "klsRawat"=> $arr['klsRawat'],
                             "noMR"=> $arr['noMR'],
                             "rujukan"=> array( 
                                            "asalRujukan"=> $arr['asalRujukan'],
                                            "tglRujukan"=> $arr['tglRujukan'],
                                            "noRujukan"=> $arr['noRujukan'],
                                            "ppkRujukan"=> $arr['ppkRujukan']
                                        ),
                             "catatan"=> $arr['catatan'],
                             "diagAwal"=> $arr['diagAwal'],
                             "poli"=> array( 
                                            "tujuan"=> $arr['tujuan'],
                                            "eksekutif"=>$arr['eksekutif']
                                        ),
                             "cob"=> array( 
                                            "cob"=> $arr['cob']
                                        ),
                             "katarak"=> array( 
                                            "katarak"=> $arr['katarak']
                                        ),
                             "jaminan"=> array( 
                                "lakaLantas"=>$arr['lakaLantas'],
                                "penjamin"=> array(
                                                "penjamin"=> $arr['penjamin'],
                                                "tglKejadian"=> $arr['tglKejadian'],
                                                "keterangan"=>$arr['keterangan'],
                                                "suplesi"=> array(
                                                                "suplesi"=> $arr['suplesi'],
                                                                "noSepSuplesi"=> $arr['noSepSuplesi'],
                                                                "lokasiLaka"=> array(
                                                                                "kdPropinsi"=> $arr['kdPropinsi'],
                                                                                "kdKabupaten"=> $arr['kdKabupaten'],
                                                                                "kdKecamatan"=> $arr['kdKecamatan']
                                                                               )
                                                             )
                                             )     
                                        ),
                             "skdp"=> array( 
                                        "noSurat"=> $arr['noSurat'],
                                        "kodeDPJP"=> $arr['kodeDPJP']
                                     ),
                                         "noTelp"=>$arr['noTelp'],
                                         "user"=> $arr['user']
                            )
                       )
   );

       $post =  json_encode($data);
       $cid = $this->id ;
       $ckey = $this->key;

            date_default_timezone_set("Asia/Jakarta");
            $timestamp = strtotime(date("Y/m/d H:i:s"));
            $data = $cid."&".$timestamp;
            $signature = hash_hmac('sha256', $data, $ckey, true);
            $encodedSignature = base64_encode($signature);


            $arrheader = array(
                'X-cons-id: '.$cid,
                'X-Timestamp: '.$timestamp,
                'X-Signature: '.$encodedSignature,
                'Accept: application/json',
                'Content-Type: Application/x-www-form-urlencoded'
            );
    //$submit = json_encode($array_submit);
    $process = curl_init($url);

    curl_setopt($process, CURLOPT_URL, $url);
    curl_setopt($process, CURLOPT_VERBOSE, true);
    curl_setopt($process, CURLOPT_TIMEOUT, 30); 
    curl_setopt($process, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($process, CURLOPT_HTTPHEADER, $arrheader);
    curl_setopt($process, CURLOPT_CUSTOMREQUEST, "POST");
    // untuk update, matikan untuk create
    // curl_setopt($process, CURLOPT_CUSTOMREQUEST, "PUT");
    curl_setopt($process, CURLOPT_POST, true); 
    curl_setopt($process, CURLOPT_POSTFIELDS, $post);

    $return = curl_exec($process);
    curl_close($process);

    $response2 = json_encode($return, true);
    // $response1 = preg_replace('/\\\\/', '', $response2);
    // $response = trim($response1,'"');

    return $response2;
}










public function cari_faskes($arr){

    $url = $this->url.'referensi/faskes/'.$arr['no'].'/'.$arr['jenis'];   
    // $url = 'https://dvlp.bpjs-kesehatan.go.id/vclaim-rest/referensi/faskes/00161001/1';   
    $cid = $this->id ;
    $ckey = $this->key;

    date_default_timezone_set("Asia/Jakarta");
    $timestamp = strtotime(date("Y/m/d H:i:s"));
    $data = $cid."&".$timestamp;
    $signature = hash_hmac('sha256', $data, $ckey, true);
    $encodedSignature = base64_encode($signature);


    $arrheader = array(
        'X-cons-id: '.$cid,
        'X-Timestamp: '.$timestamp,
        'X-Signature: '.$encodedSignature,
        'Accept: application/json',
        'Content-Type: Application/x-www-form-urlencoded'
    );
           $session = curl_init (); 
            curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
            curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($session, CURLOPT_URL, $url);
            curl_setopt($session, CURLOPT_TIMEOUT, 5);
            curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
        $response = curl_exec($session);
        if (!$response) {
           echo $err = curl_error($session);

        }else{
            curl_close($session);
     return $response;
        }

}



public function dokterdjp($arr){
// $param1,$param2,$param3
$url = $this->url.'referensi/dokter/pelayanan/'.$arr['pel'].'/tglPelayanan/'.$arr['tgl'].'/Spesialis/'.$arr['kode'];   
    // $url = 'https://dvlp.bpjs-kesehatan.go.id/vclaim-rest/referensi/dokter/pelayanan/1/tglPelayanan/2019-03-06/Spesialis/31486';  
    $cid = $this->id ;
    $ckey = $this->key;

    date_default_timezone_set("Asia/Jakarta");
    $timestamp = strtotime(date("Y/m/d H:i:s"));
    $data = $cid."&".$timestamp;
    $signature = hash_hmac('sha256', $data, $ckey, true);
    $encodedSignature = base64_encode($signature);


    $arrheader = array(
        'X-cons-id: '.$cid,
        'X-Timestamp: '.$timestamp,
        'X-Signature: '.$encodedSignature,
        'Accept: application/json',
        'Content-Type: Application/x-www-form-urlencoded'
    );
           $session = curl_init (); 
            curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
            curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($session, CURLOPT_URL, $url);
            curl_setopt($session, CURLOPT_TIMEOUT, 5);
            curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
        $response = curl_exec($session);
        if (!$response) {
           echo $err = curl_error($session);

        }else{
            curl_close($session);
     return $response;
        }

}


public function provinsi(){

    $url = $this->url.'referensi/propinsi';   
    
    $cid = $this->id ;
            $ckey = $this->key;

    date_default_timezone_set("Asia/Jakarta");
    $timestamp = strtotime(date("Y/m/d H:i:s"));
    $data = $cid."&".$timestamp;
    $signature = hash_hmac('sha256', $data, $ckey, true);
    $encodedSignature = base64_encode($signature);


    $arrheader = array(
        'X-cons-id: '.$cid,
        'X-Timestamp: '.$timestamp,
        'X-Signature: '.$encodedSignature,
        'Accept: application/json',
        'Content-Type: application/json'
    );
           $session = curl_init (); 
            curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
            curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($session, CURLOPT_URL, $url);
                // curl_setopt($session, CURLOPT_TIMEOUT, 5);
                // curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
        $response = curl_exec($session);
        if (!$response) {
           echo $err = curl_error($session);

        }else{
           
        }
        curl_close($session);
     return $response;
} 


public function kabupaten($no=''){

    $url = $this->url.'referensi/kabupaten/propinsi/'.$no;   
    
    $cid = $this->id ;
    $ckey = $this->key;

    date_default_timezone_set("Asia/Jakarta");
    $timestamp = strtotime(date("Y/m/d H:i:s"));
    $data = $cid."&".$timestamp;
    $signature = hash_hmac('sha256', $data, $ckey, true);
    $encodedSignature = base64_encode($signature);


    $arrheader = array(
        'X-cons-id: '.$cid,
        'X-Timestamp: '.$timestamp,
        'X-Signature: '.$encodedSignature,
        'Accept: application/json',
        'Content-Type: application/json'
    );
           $session = curl_init (); 
            curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
            curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($session, CURLOPT_URL, $url);
                // curl_setopt($session, CURLOPT_TIMEOUT, 5);
                // curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
        $response = curl_exec($session);
        if (!$response) {
           echo $err = curl_error($session);

        }else{
           
        }
        curl_close($session);
     return $response;
}  


public function kecamatan($no){

    $url = $this->url.'referensi/kecamatan/kabupaten/'.$no;   
    
    $cid = $this->id ;
            $ckey = $this->key;

    date_default_timezone_set("Asia/Jakarta");
    $timestamp = strtotime(date("Y/m/d H:i:s"));
    $data = $cid."&".$timestamp;
    $signature = hash_hmac('sha256', $data, $ckey, true);
    $encodedSignature = base64_encode($signature);


    $arrheader = array(
        'X-cons-id: '.$cid,
        'X-Timestamp: '.$timestamp,
        'X-Signature: '.$encodedSignature,
        'Accept: application/json',
        'Content-Type: application/json'
    );
           $session = curl_init (); 
            curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
            curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($session, CURLOPT_URL, $url);
                // curl_setopt($session, CURLOPT_TIMEOUT, 5);
                // curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
        $response = curl_exec($session);
        if (!$response) {
           echo $err = curl_error($session);

        }else{
           
        }
        curl_close($session);
     return $response;
}  





  



public function klaim($date,$jenis,$status){

    $url = $this->url.'Monitoring/Klaim/Tanggal/'.$date.'/JnsPelayanan/'.$jenis.'/Status/'.$status;   
    
    $cid = $this->id ;
            $ckey = $this->key;

    date_default_timezone_set("Asia/Jakarta");
    $timestamp = strtotime(date("Y/m/d H:i:s"));
    $data = $cid."&".$timestamp;
    $signature = hash_hmac('sha256', $data, $ckey, true);
    $encodedSignature = base64_encode($signature);


    $arrheader = array(
        'X-cons-id: '.$cid,
        'X-Timestamp: '.$timestamp,
        'X-Signature: '.$encodedSignature,
        'Accept: application/json',
        'Content-Type: application/json'
    );
           $session = curl_init (); 
            curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
            curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($session, CURLOPT_URL, $url);
                // curl_setopt($session, CURLOPT_TIMEOUT, 5);
                // curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
        $response = curl_exec($session);
        if (!$response) {
           echo $err = curl_error($session);

        }else{
           
        }
        curl_close($session);
     return $response;
}  


public function klaim_jasaraharja($dates,$datee){

    $url = $this->url.'monitoring/JasaRaharja/tglMulai/'.$dates.'/tglAkhir/'.$datee;   
    
    $cid = $this->id ;
            $ckey = $this->key;

    date_default_timezone_set("Asia/Jakarta");
    $timestamp = strtotime(date("Y/m/d H:i:s"));
    $data = $cid."&".$timestamp;
    $signature = hash_hmac('sha256', $data, $ckey, true);
    $encodedSignature = base64_encode($signature);


    $arrheader = array(
        'X-cons-id: '.$cid,
        'X-Timestamp: '.$timestamp,
        'X-Signature: '.$encodedSignature,
        'Accept: application/json',
        'Content-Type: application/json'
    );
           $session = curl_init (); 
            curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
            curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($session, CURLOPT_URL, $url);
                // curl_setopt($session, CURLOPT_TIMEOUT, 5);
                // curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
        $response = curl_exec($session);
        if (!$response) {
           echo $err = curl_error($session);

        }else{
           
        }
        curl_close($session);
     return $response;
}




public function aproval_sep($arr){

    $url = $this->url.'Sep/aprovalSEP';   
    
    $cid = $this->id ;
    $ckey = $this->key;

    date_default_timezone_set("Asia/Jakarta");
    $timestamp = strtotime(date("Y/m/d H:i:s"));
    $data = $cid."&".$timestamp;
    $signature = hash_hmac('sha256', $data, $ckey, true);
    $encodedSignature = base64_encode($signature);

  
   
        $arr = array(

            "request"=> array(
                "t_sep"=> array(
                   "noKartu"=>$arr['nokartu'],
                   "tglSep"=> $arr['tglsep'],
                   "jnsPelayanan"=> $arr['jenispelayanan'],
                   "keterangan"=> $arr['keterangan'],
                   "user"=> $arr['user']
                )
            )

        );
     $post = json_encode($arr);

    $arrheader = array(
        'X-cons-id: '.$cid,
        'X-Timestamp: '.$timestamp,
        'X-Signature: '.$encodedSignature,
        'Accept: application/json',
        'Content-Type: Application/x-www-form-urlencoded'
    );
           $session = curl_init (); 
            curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
            curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($session, CURLOPT_URL, $url);
            curl_setopt($session,CURLOPT_CUSTOMREQUEST,"POST");
            curl_setopt($session, CURLOPT_POST, true); 
            curl_setopt($session, CURLOPT_POSTFIELDS, $post);
            curl_setopt($session, CURLOPT_TIMEOUT, 5);
            curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
        $response = curl_exec($session);
        if (!$response) {
           echo $err = curl_error($session);

        }else{
            curl_close($session);
     return json_decode($response,true);
        }
}
 

public function insert_lpk($arr){


    // create
    $url = $this->url.'LPK/insert'; 
    // update
    // $url = 'https://dvlp.bpjs-kesehatan.go.id/vclaim-rest/SEP/1.1/update'; 
    

    $data = array("request"=>array(
        "t_lpk" => array(
           "noSep"=> $arr['noSep'],
           "tglMasuk"=> $arr['tglMasuk'],
           "tglKeluar"=> $arr['tglKeluar'],
           "jaminan"=> $arr['jaminan'],
           "poli"=> array(
              "poli"=> $arr['poli']
           ),
           "perawatan"=>array(
              "ruangRawat"=> $arr['ruangRawat'],
              "kelasRawat"=> $arr['kelasRawat'],
              "spesialistik"=> $arr['spesialistik'],
              "caraKeluar"=> $arr['caraKeluar'],
              "kondisiPulang"=> $arr['kondisiPulang']
           ),
           "diagnosa" => array(
             array(
                 "kode"=> $arr['D1kode'],
                 "level"=> $arr['D1level']
             ),
             array(
                 "kode"=> $arr['D2kode'],
                 "level"=> $arr['D2level']
             )
             ),
           "procedure"=> array(
             array(
                 "kode"=>$arr['P1kode']
             ),
              array(
                 "kode"=> $arr['P1kode']
              )
              ),
           "rencanaTL"=> array(
              "tindakLanjut"=> $arr['tindakLanjut'],
              "dirujukKe"=> array(
                 "kodePPK"=> $arr['kodePPK']
              ),
              "kontrolKembali"=> array(
                 "tglKontrol"=> $arr['tglKontrol'],
                 "poli"=>$arr['poli']
              )
             ),
           "DPJP"=>$arr['DPJP'],
           "user"=> $arr['user']
)
)
    
);

       $post =  json_encode($data);
       $cid = $this->id ;
       $ckey = $this->key;

            date_default_timezone_set("Asia/Jakarta");
            $timestamp = strtotime(date("Y/m/d H:i:s"));
            $data = $cid."&".$timestamp;
            $signature = hash_hmac('sha256', $data, $ckey, true);
            $encodedSignature = base64_encode($signature);


            $arrheader = array(
                'X-cons-id: '.$cid,
                'X-Timestamp: '.$timestamp,
                'X-Signature: '.$encodedSignature,
                'Accept: application/json',
                'Content-Type: Application/x-www-form-urlencoded'
            );
    //$submit = json_encode($array_submit);
    $process = curl_init($url);

    curl_setopt($process, CURLOPT_URL, $url);
    curl_setopt($process, CURLOPT_VERBOSE, true);
    // curl_setopt($process, CURLOPT_TIMEOUT, 30); 
    curl_setopt($process, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($process, CURLOPT_HTTPHEADER, $arrheader);
    curl_setopt($process, CURLOPT_CUSTOMREQUEST, "POST");
    // untuk update, matikan untuk create
    // curl_setopt($process, CURLOPT_CUSTOMREQUEST, "PUT");
    curl_setopt($process, CURLOPT_POST, true); 
    curl_setopt($process, CURLOPT_POSTFIELDS, $post);

    $return = curl_exec($process);
    curl_close($process);

    $response2 = json_encode($return, true);
    // $response1 = preg_replace('/\\\\/', '', $response2);
    // $response = trim($response1,'"');

    echo $response2;
}


public function update_lpk($arr){


    // create
    $url = $this->url.'LPK/update'; 
    // update
    // $url = 'https://dvlp.bpjs-kesehatan.go.id/vclaim-rest/SEP/1.1/update'; 
    

     $data = array("request"=>array(
               "t_lpk" => array(
                  "noSep"=> $arr['noSep'],
                  "tglMasuk"=> $arr['tglMasuk'],
                  "tglKeluar"=> $arr['tglKeluar'],
                  "jaminan"=> $arr['jaminan'],
                  "poli"=> array(
                     "poli"=> $arr['poli']
                  ),
                  "perawatan"=>array(
                     "ruangRawat"=> $arr['ruangRawat'],
                     "kelasRawat"=> $arr['kelasRawat'],
                     "spesialistik"=> $arr['spesialistik'],
                     "caraKeluar"=> $arr['caraKeluar'],
                     "kondisiPulang"=> $arr['kondisiPulang']
                  ),
                  "diagnosa" => array(
                    array(
                        "kode"=> $arr['D1kode'],
                        "level"=> $arr['D1level']
                    ),
                    array(
                        "kode"=> $arr['D2kode'],
                        "level"=> $arr['D2level']
                    )
                    ),
                  "procedure"=> array(
                    array(
                        "kode"=>$arr['P1kode']
                    ),
                     array(
                        "kode"=> $arr['P1kode']
                     )
                     ),
                  "rencanaTL"=> array(
                     "tindakLanjut"=> $arr['tindakLanjut'],
                     "dirujukKe"=> array(
                        "kodePPK"=> $arr['kodePPK']
                     ),
                     "kontrolKembali"=> array(
                        "tglKontrol"=> $arr['tglKontrol'],
                        "poli"=>$arr['poli']
                     )
                    ),
                  "DPJP"=>$arr['DPJP'],
                  "user"=> $arr['user']
     )
     )
           
   );

       $post =  json_encode($data);
       $cid = $this->id ;
       $ckey = $this->key;

            date_default_timezone_set("Asia/Jakarta");
            $timestamp = strtotime(date("Y/m/d H:i:s"));
            $data = $cid."&".$timestamp;
            $signature = hash_hmac('sha256', $data, $ckey, true);
            $encodedSignature = base64_encode($signature);


            $arrheader = array(
                'X-cons-id: '.$cid,
                'X-Timestamp: '.$timestamp,
                'X-Signature: '.$encodedSignature,
                'Accept: application/json',
                'Content-Type: Application/x-www-form-urlencoded'
            );
    //$submit = json_encode($array_submit);
    $process = curl_init($url);

    curl_setopt($process, CURLOPT_URL, $url);
    curl_setopt($process, CURLOPT_VERBOSE, true);
    // curl_setopt($process, CURLOPT_TIMEOUT, 30); 
    curl_setopt($process, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($process, CURLOPT_HTTPHEADER, $arrheader);
    // curl_setopt($process, CURLOPT_CUSTOMREQUEST, "POST");
    // untuk update, matikan untuk create
    curl_setopt($process, CURLOPT_CUSTOMREQUEST, "PUT");
    // curl_setopt($process, CURLOPT_POST, true); 
    curl_setopt($process, CURLOPT_POSTFIELDS, $post);

    $return = curl_exec($process);
    curl_close($process);

    $response2 = json_encode($return, true);
    // $response1 = preg_replace('/\\\\/', '', $response2);
    // $response = trim($response1,'"');

    echo $response2;
}

public function delete_lpk($no){

    $url = $this->url.'LPK/Delete';   
    
    $cid = $this->id ;
    $ckey = $this->key;

    date_default_timezone_set("Asia/Jakarta");
    $timestamp = strtotime(date("Y/m/d H:i:s"));
    $data = $cid."&".$timestamp;
    $signature = hash_hmac('sha256', $data, $ckey, true);
    $encodedSignature = base64_encode($signature);

    $arr = array(

        "request"=>array(
                    "t_lpk"=>array(
                    "noSep"=>$no
                    )
            )

        );
     $post = json_encode($arr);

    $arrheader = array(
        'X-cons-id: '.$cid,
        'X-Timestamp: '.$timestamp,
        'X-Signature: '.$encodedSignature,
        'Accept: application/json',
        'Content-Type: Application/x-www-form-urlencoded'
    );
           $session = curl_init (); 
            curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
            curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($session, CURLOPT_URL, $url);
            curl_setopt($session,CURLOPT_CUSTOMREQUEST,"DELETE");
            curl_setopt($session, CURLOPT_POST, true); 
            curl_setopt($session, CURLOPT_POSTFIELDS, $post);
            curl_setopt($session, CURLOPT_TIMEOUT, 5);
            curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
        $response = curl_exec($session);
        if (!$response) {
           echo $err = curl_error($session);

        }else{
            curl_close($session);
     return json_decode($response,true);
        }
       
       
}

public function data_lembar_pengajuan_klaim($tgl,$jenis){
    // require APPPATH . 'config/bpjs.php';
   $url = $this->url.'LPK/TglMasuk/'.$tgl.'/JnsPelayanan/'.$jenis; 
       
       $cid = $this->id ;
       $ckey = $this->key;

       date_default_timezone_set("Asia/Jakarta");
       $timestamp = strtotime(date("Y/m/d H:i:s"));
       $data = $cid."&".$timestamp;
       $signature = hash_hmac('sha256', $data, $ckey, true);
       $encodedSignature = base64_encode($signature);


       $arrheader = array(
           'X-cons-id: '.$cid,
           'X-Timestamp: '.$timestamp,
           'X-Signature: '.$encodedSignature,
           'Accept: application/json',
           'Content-Type: application/json'
       );
              $session = curl_init (); 
               curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
               curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
               curl_setopt($session, CURLOPT_URL, $url);
               // curl_setopt($session, CURLOPT_TIMEOUT, 5);
               // curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
           $response = curl_exec($session);
           if (!$response) {
              echo $err = curl_error($session);

           }else{
              
           }
           curl_close($session);
        return $response;
}

public function ketersediaan_kamar(){
    // require APPPATH . 'config/bpjs.php';
   $url = 'https://dvlp.bpjs-kesehatan.go.id/aplicaresws/rest/bed/read/0005R005/1/2'; 
       
       $cid = $this->id ;
       $ckey = $this->key;

       date_default_timezone_set("Asia/Jakarta");
       $timestamp = strtotime(date("Y/m/d H:i:s"));
       $data = $cid."&".$timestamp;
       $signature = hash_hmac('sha256', $data, $ckey, true);
       $encodedSignature = base64_encode($signature);


       $arrheader = array(
           'X-cons-id: '.$cid,
           'X-Timestamp: '.$timestamp,
           'X-Signature: '.$encodedSignature,
           'Accept: application/json',
           'Content-Type: application/json'
       );
              $session = curl_init (); 
               curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
               curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
               curl_setopt($session, CURLOPT_URL, $url);
               // curl_setopt($session, CURLOPT_TIMEOUT, 5);
               // curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
           $response = curl_exec($session);
           if (!$response) {
              echo $err = curl_error($session);

           }else{
              
           }
           curl_close($session);
        return $response;
}




public function rujukan($no){
         // $url = 'https://dvlp.bpjs-kesehatan.go.id/vclaim-rest/Rujukan/Peserta/'.$no;
        $url = $this->url.'Rujukan/Peserta/'.$no;   
        $cid = $this->id ;
        $ckey = $this->key;

        date_default_timezone_set("Asia/Jakarta");
        $timestamp = strtotime(date("Y/m/d H:i:s"));
        $data = $cid."&".$timestamp;
        $signature = hash_hmac('sha256', $data, $ckey, true);
        $encodedSignature = base64_encode($signature);


        $arrheader = array(
            'X-cons-id: '.$cid,
            'X-Timestamp: '.$timestamp,
            'X-Signature: '.$encodedSignature,
            'Accept: application/json',
            'Content-Type: Application/x-www-form-urlencoded'
        );
               $session = curl_init (); 
                curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
                curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($session, CURLOPT_URL, $url);
                curl_setopt($session, CURLOPT_TIMEOUT, 5);
                curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
            $response = curl_exec($session);
            if (!$response) {
               echo $err = curl_error($session);

            }else{
                curl_close($session);
         return $response;
            }
 
}

public function rujukan_no($no){

    $url = $this->url.'Rujukan/'.$no;   
    
    $cid = $this->id ;
    $ckey = $this->key;

    date_default_timezone_set("Asia/Jakarta");
    $timestamp = strtotime(date("Y/m/d H:i:s"));
    $data = $cid."&".$timestamp;
    $signature = hash_hmac('sha256', $data, $ckey, true);
    $encodedSignature = base64_encode($signature);


    $arrheader = array(
        'X-cons-id: '.$cid,
        'X-Timestamp: '.$timestamp,
        'X-Signature: '.$encodedSignature,
        'Accept: application/json',
        'Content-Type: application/json'
    );
           $session = curl_init (); 
            curl_setopt($session, CURLOPT_HTTPHEADER, $arrheader);
            curl_setopt($session, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($session, CURLOPT_URL, $url);
                // curl_setopt($session, CURLOPT_TIMEOUT, 5);
                // curl_setopt($session, CURLOPT_CONNECTTIMEOUT, 5);
        $response = curl_exec($session);
        if (!$response) {
           echo $err = curl_error($session);

        }else{
           
        }
        curl_close($session);
     return $response;
}  




}