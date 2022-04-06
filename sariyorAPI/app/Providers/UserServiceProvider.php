<?php

namespace App\Providers;

use App\Services\AuthService;
use App\Services\IService;
use App\Services\UserService;
use Illuminate\Support\ServiceProvider;

class UserServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->singletonIf('user_service', function ($app) {
            $auth = new AuthService();
            return new UserService($app, $auth);
        });
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }

    public function provides()
    {
        return ['user_service'];
    }
}
