<?php

namespace App\Services;

class UserService
{

    protected AuthService $auth;

    public function __construct(AuthService $auth)
    {
        $this->auth = $auth;
    }

}
