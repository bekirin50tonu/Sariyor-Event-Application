<?php

namespace App\Http\Requests\User;

use App\Http\Helpers\Classes\CustomJsonResponse;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use JetBrains\PhpStorm\ArrayShape;

class RegisterRequest extends FormRequest
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
    #[ArrayShape(['first_name' => "string", 'last_name' => "string", 'username' => "string", 'email' => "string"])] public function rules(): array
    {
        return [
            'first_name' => 'required|max:15|min:3',
            'last_name' => 'required|max:15|min:3',
            'username' => 'required|max:15|min:3|unique:users',
            'email' => 'email|required|unique:users',
        ];
    }

    public function messages(): array
    {
        return [
            'first_name.required' => 'Lütfen Adınızı Giriniz.',
            'first_name.max' => 'Lütfen 15\'ten Fazla Karakter Girmeyiniz.',
            'first_name.min' => 'Lütfen 2\'den Fazla Karakter Giriniz.',
            'last_name.required' => 'Lütfen SOyadınızı Giriniz.',
            'last_name.max' => 'Lütfen 15\'ten Fazla Karakter Girmeyiniz.',
            'last_name.min' => 'Lütfen 2\'den Fazla Karakter Giriniz.',
            'username.required' => 'Lütfen Kullanıcı Adınızı Giriniz.',
            'username.max' => 'Lütfen 15\'ten Fazla Karakter Girmeyiniz.',
            'username.min' => 'Lütfen 2\'den Fazla Karakter Giriniz.',
            'username.unique' => 'Lütfen Kullanılmayan Kullanıcı Adı Giriniz.',
            'email.required' => 'Lütfen E Posta Adresinizi Giriniz.',
            'email.email' => 'Lütfen Geçerli Bir E Posta Adresi Giriniz.',
            'email.unique' => 'Lütfen Kullanılmayan E-Posta Adresi Giriniz.',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $response = new CustomJsonResponse(422, "Kayıt İşlemi Başarısız", $validator->errors()->all());

        throw new \Illuminate\Validation\ValidationException($validator, $response);
    }
}
