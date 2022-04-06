<?php

namespace App\Http\Requests\User\Auth;

use App\Http\Helpers\Classes\CustomJsonResponse;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use JetBrains\PhpStorm\ArrayShape;

class LoginRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    #[ArrayShape(['email' => "string", 'password' => "string"])] public function rules(): array
    {
        return [
            'email' => 'required|email', 'password' => 'required|min:8'

        ];
    }

    #[ArrayShape(['email.required' => "string", 'email.email' => "string", 'password.required' => "string", 'password.min' => "string"])] public function messages(): array
    {
        return [
            'email.required' => 'Lütfen E-Posta Adresi Giriniz.',
            'email.email' => 'Lütfen Geçerli Bir E-Posta Adresi Giriniz.',
            'password.required' => 'Lütfen Parolanızı Giriniz.',
            'password.min' => 'Minimum 8 Karakterli Parolanızı Giriniz.',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $response = new CustomJsonResponse(422, "Giriş Başarısız", $validator->errors()->all());

        throw new \Illuminate\Validation\ValidationException($validator, $response);
    }
}
