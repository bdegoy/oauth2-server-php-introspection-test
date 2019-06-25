<?php
// include our OAuth2 Server object
require_once __DIR__.'/server.php';

$request = OAuth2\Request::createFromGlobals();
$response = new OAuth2\Response();

// Handle a request for introspection and authenticate the access token
$server->handleIntrospectRequest( $request, $response );
$response->send();

