<?php

namespace App\Http\Controllers\API\Auth;

use App\Http\Controllers\Controller;
use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Http\Requests\User\Auth\LoginRequest;
use App\Http\Requests\User\Auth\RegisterRequest;
use App\Services\AuthService;
use Illuminate\Http\Request;

class AuthController extends Controller
{

    function register(RegisterRequest $request, AuthService $userService): CustomJsonResponse
    {
        return $userService->register($request->all());
    }

    function login(LoginRequest $request, AuthService $userService): CustomJsonResponse
    {
        return $userService->login($request->get('email'), $request->get('password'));
    }

    function logout(Request $request, AuthService $userService): CustomJsonResponse
    {
        $user = $request->user();
        return $userService->logout($user);
    }

}
