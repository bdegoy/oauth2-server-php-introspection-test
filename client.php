<?php
/* client.php
Client app for testing introspection.

Usage : https://o2sp.dnc.global/client.php

Using OpenID Connect Authorization Code Flow :
Step 1 - ask for authorization Code at authorization endpoint.
Step 2 - exchange Authorization Code for Tokens at token endpoint.
Step 3 - pass the JWT to introspection endpoint to test its validity.

Be sure to have te necessary definitions in database, see database.sql.

Note that the redirect URI is that of this script itself.

References:
https://datatracker.ietf.org/doc/rfc7662/

Author :
Bertrand Degoy https://oa.dnc.global
Credits :
bschaffer https://github.com/bshaffer/oauth2-server-php

Licence : GPL v3.0
Copyright (c) 2019 - DnC

*/

ini_set('display_errors', 1);

$client_id = 'testclient';
$client_secret = 'testpass';

$authorization_endpoint = 'https://o2sp.dnc.global/authorize.php';
$token_endpoint = 'https://o2sp.dnc.global/token.php';
$introspect_endpoint = 'https://o2sp.dnc.global/introspect.php';

if (isset($_GET['error']))
{
    exit("Error: {$_GET['error']}. Description: {$_GET['error_description']}");
}

if ( ! isset($_GET['code'] ) ) {

    // Step 1. Authorization Code request

    $data = array(
        'response_type' => 'code',
        'client_id' => $client_id,
        'state' => 'xyz',
        'scope' => 'openid profile',    
    );

    $authorization_endpoint .= '?' . http_build_query($data);
    header('Location: ' . $authorization_endpoint);
    exit();

}
else if ( isset($_GET['state']) ) {
    
    DebugBreak("435347910947900005@127.0.0.1;d=1");  //DEBUG
    
    // Step 2. Token request

    $code = $_GET['code'];
   
    $data = array(
        'grant_type' => 'authorization_code',
        'code' => $code,
    );

    $h = curl_init($token_endpoint);
    curl_setopt($h, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($h, CURLOPT_TIMEOUT, 10);
    curl_setopt($h, CURLOPT_USERPWD, "{$client_id}:{$client_secret}");
    curl_setopt($h, CURLOPT_POST, true);
    curl_setopt($h, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded'));
    curl_setopt($h, CURLOPT_POSTFIELDS, http_build_query($data));
    curl_setopt($h, CURLOPT_SSL_VERIFYPEER, false);    // as long as the certificate is not ready

    $res = curl_exec($h);
    if (!$res)
        exit(curl_error($h));

    curl_close($h);
    $res = json_decode($res, true);

    // Step 3. Check JWT
    $id_token = $res['id_token'];

    /* Methode Request Header (not in the rfc7662 oct. 2015) 
    $h = curl_init($introspect_endpoint);
    curl_setopt($h, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($h, CURLOPT_TIMEOUT, 10);
    curl_setopt($h, CURLOPT_HTTPHEADER, array('Authorization: Bearer ' . $id_token));
    curl_setopt($h, CURLOPT_SSL_VERIFYPEER, false);    // as long as the certificate is not ready
    //*/
    
    /** Methode POST (rfc7662 oct. 2015 Section 2.1.)
    * Following rfc, token parameter should be named 'token'. Set by token_param_name configuration parameter.
    * 
    */
    $data = array(
        'token' => $id_token,
    );
    $h = curl_init($introspect_endpoint);
    curl_setopt($h, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($h, CURLOPT_TIMEOUT, 10);
    curl_setopt($h, CURLOPT_POST, true);
    curl_setopt($h, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded'));     
    curl_setopt($h, CURLOPT_POSTFIELDS, http_build_query($data));

    $res = curl_exec($h);
    if (!$res)
        exit(curl_error($h));

    curl_close($h);
    $res = json_decode($res, true);

    echo "Introspection Response:\n";
    print_r($res);
}
