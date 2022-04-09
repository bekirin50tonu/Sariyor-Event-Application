<?php

namespace App\Services;

use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Models\User;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Support\Facades\Hash;
use JetBrains\PhpStorm\ArrayShape;

class AuthService
{

    #[ArrayShape(['status_code' => "int", 'message' => "string", 'data' => "array"])] public function register(array $data): CustomJsonResponse
    {
        try {
            $data['password'] = Hash::make($data['password']);
            $user = \App\Models\User::query()->create($data);
            return new CustomJsonResponse(200, 'Kayıt Başarıyla Oluşturuldu ve Giriş Yapıldı', [
                'user' => $user,
                'token' => $user->createToken($data['email'])->plainTextToken
            ]);
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

    public function login(string $email, string $password): CustomJsonResponse
    {
        try {
            $user = User::query()->where('email', '=', $email)->first();
            if (!$user) return new CustomJsonResponse(303, 'Başarısız.', ["Belirtilen Kullanıcı Bulunamadı"]);
            else if (!Hash::check($password, $user->password)) return new CustomJsonResponse(303, 'Başarısız.', ["Belirtilen Parola Yanlış, Tekrar Deneyiniz."]);
            return new CustomJsonResponse(200, 'İşlem Başarılı.', [
                "user" => $user,
                "token" => $user->createToken($email)->plainTextToken
            ]);

        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

    public
    function logout(Authenticatable $user): CustomJsonResponse
    {
        try {
            $user->tokens()->delete();
            return new CustomJsonResponse(200, 'Başarıyla Çıkış Yapıldı.', ["Başarıyla Çıkış Yapıldı. Yönlendiriliyor."]);
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

}
