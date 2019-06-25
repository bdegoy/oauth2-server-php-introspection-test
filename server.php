<?php

$dsn      = 'mysql:dbname=o2spdnc_data;host=localhost';
$username = 'o2spdnc_user';
$password = 'o2dnY10CWrB9!';

// error reporting (this is a demo, after all!)
ini_set('display_errors',1);error_reporting(E_ALL);

// Autoloading (composer is preferred, but for this example let's just do this)
require_once('vendor/bshaffer/oauth2-server-php/src/OAuth2/Autoloader.php');
OAuth2\Autoloader::register();

// $dsn is the Data Source Name for your database, for exmaple "mysql:dbname=my_oauth2_db;host=localhost"
$storage = new OAuth2\Storage\Pdo(array('dsn' => $dsn, 'username' => $username, 'password' => $password));

// Configure the server for OpenID Connect
$config = array(
    'use_openid_connect' => true,
    'issuer' => 'o2sp.dnc.global',
    'use_jwt_access_tokens' => false,
    'token_param_name' => 'token',   // rfc7662 Section 2.1.
);

// Create the server
$server = new OAuth2\Server($storage, $config);

// Add the OpenID Connect "Authorization Code" grant type
$server->addGrantType(new OAuth2\OpenID\GrantType\AuthorizationCode($storage));

// Configure available scopes
$defaultScope = 'basic';
$supportedScopes = array(
    'openid',
    'basic',
    'profile',
    'email',
    'address',
    'phone', 
);
$memory = new OAuth2\Storage\Memory(array(
    'default_scope' => $defaultScope,
    'supported_scopes' => $supportedScopes
));
$scopeUtil = new OAuth2\Scope($memory);
// Set scopes
$server->setScopeUtil($scopeUtil);
