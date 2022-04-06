<?php

namespace App\Http\Controllers\API\Auth;

use App\Http\Controllers\Controller;
use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Http\Requests\User\Auth\LoginRequest;
use App\Http\Requests\User\Auth\RegisterRequest;
use App\Services\AuthService;
use App\Services\UserService;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    private UserService $user_service;

    public function __construct()
    {
        $this->user_service = app(UserService::class);
    }

    function register(RegisterRequest $request, AuthService $userService): CustomJsonResponse
    {
        $status = $userService->register($request->all());
        return new CustomJsonResponse(...$status);
    }

    function login(LoginRequest $request, AuthService $userService): CustomJsonResponse
    {
        $status = $userService->login($request->get('email'), $request->get('password'));
        return new CustomJsonResponse(...$status);
    }

    function logout(Request $request, AuthService $userService)
    {
        $user = $request->user();
        $status = $userService->logout($user);
        return new CustomJsonResponse(...$status);
    }

}
