<?php

namespace App\Services;

use Illuminate\Support\Facades\App;

class UserService
{

    protected AuthService $auth;
    private App $app;

    public function __construct(App $app, AuthService $auth)
    {
        $this->auth = $auth;
        $this->app = $app;
    }

}
