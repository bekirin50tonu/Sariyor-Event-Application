<?php

namespace App\Http\Controllers\API\Auth;

use App\Http\Controllers\BaseController;
use App\Http\Requests\User\RegisterRequest;
use App\Services\UserService;
use Illuminate\Contracts\Container\BindingResolutionException;
use Illuminate\Http\Request;
use JetBrains\PhpStorm\Pure;

class AuthController extends BaseController
{
    private UserService $user_service;

    /**
     * @throws BindingResolutionException
     */
    #[Pure] public function __construct()
    {
        $this->user_service = app()->make(UserService::class);
    }

    function register(RegisterRequest $request): \Illuminate\Http\JsonResponse
    {
        $status = $this->user_service->register($request->all());
        return $this->success(...$status);
    }

    function login(Request $request): string
    {
        return $this->success(401, 'Başarılı', [$this->user_service->login($request->all())]);
    }

    function logout()
    {
        $status = $this->user_service->logout(auth('api')->user());
        return $status == true ? $this->success(200, 'Başarılı', []) : $this->error(403, 'Hata', []);
    }

}
