<?php

namespace App\Services;

use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthService
{

    public function register(array $data): array
    {
        try {
            $data['password'] = Hash::make($data['password']);
            $user = \App\Models\User::query()->create($data);
            return [
                'status_code' => 200,
                'message' => 'İşlem Başarılı',
                'data' => [$user]
            ];
        } catch (\Exception $e) {
            return [
                'status_code' => 403,
                'message' => $e->getMessage(),
                'data' => []
            ];
        }
    }

    public function login(array $data)
    {
        try {
            if (Auth::attempt($data)) {
                $user = Auth::user();
                return $user->createToken('access_token');
            }
            return null;
        } catch (\Exception $e) {
            return $e->getMessage();
        }
    }

    public function logout(Authenticatable $user){
        $user->logout();
        return true;
    }
}
