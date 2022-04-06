<?php

namespace App\Services;

use App\Models\User;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Support\Facades\Hash;
use JetBrains\PhpStorm\ArrayShape;

class AuthService
{

    #[ArrayShape(['status_code' => "int", 'message' => "string", 'data' => "array"])] public function register(array $data): array
    {
        try {
            $data['password'] = Hash::make($data['password']);
            $user = \App\Models\User::query()->create($data);
            return [
                'status_code' => 200,
                'message' => 'İşlem Başarılı',
                'data' => []
            ];
        } catch (\Exception $e) {
            return [
                'status_code' => 303,
                'message' => $e->getMessage(),
                'data' => $e->getTrace()
            ];
        }
    }

    public function login(string $email, string $password): array
    {
        try {
            $user = User::query()->where('email', '=', $email)->first();
            if (!$user) return [
                'status_code' => 303,
                'message' => "Başarısız",
                'data' => ["Belirtilen Kullanıcı Bulunamadı"]
            ];
            else if (!Hash::check($password, $user->password)) return [
                'status_code' => 303,
                'message' => "Başarısız",
                'data' => ["Belirtilen Parola Yanlış, Tekrar Deneyiniz."]
            ];
            return [
                'status_code' => 200,
                'message' => 'İşlem Başarılı',
                'data' => [
                    "user" => $user,
                    "token" => $user->createToken($email)->plainTextToken
                ]
            ];
        } catch (\Exception $e) {
            return ['status_code' => 303,
                'message' => $e->getMessage(),
                'data' => $e->getTrace()];
        }
    }

    public
    function logout(Authenticatable $user): array
    {
        try {
            $user->tokens()->delete();
            return [
                'status_code' => 200,
                'message' => "Başarılı",
                'data' => ["Başarıyla Çıkış Yapıldı. Yönlendiriliyor."]
            ];
        } catch (\Exception $e) {
            return ['status_code' => 303,
                'message' => $e->getMessage(),
                'data' => $e->getTrace()];
        }
    }

}
