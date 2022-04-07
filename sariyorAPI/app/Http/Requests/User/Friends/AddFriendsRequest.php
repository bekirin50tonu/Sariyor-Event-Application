<?php

namespace App\Http\Requests\User\Friends;

use App\Http\Helpers\Classes\CustomJsonResponse;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use JetBrains\PhpStorm\ArrayShape;

class AddFriendsRequest extends FormRequest
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
    #[ArrayShape(['user_id' => "string[]"])] public function rules()
    {
        return ['user_id' => ['required', 'exists:users,id', 'unique:add_friends,response_user_id']];
    }

    #[ArrayShape(['user_id.required' => "string", 'user_id.exists' => "string", 'user_id.unique' => "string[]"])] public function messages()
    {
        return [
            'user_id.required' => 'Gönderilmek İstenen Kullanıcıyı Belirtiniz.',
            'user_id.exists' => 'Belirtilen Kullanıcı Bulunamadı',
            'user_id.unique' => 'Tekrar Arkadaş Ekleyemezsin.'
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $response = new CustomJsonResponse(422, "Ekleme İşlemi Başarısız.", $validator->errors()->all());

        throw new \Illuminate\Validation\ValidationException($validator, $response);
    }
}
