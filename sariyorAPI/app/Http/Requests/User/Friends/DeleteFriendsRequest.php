<?php

namespace App\Http\Requests\User\Friends;

use App\Http\Helpers\Classes\CustomJsonResponse;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;

class DeleteFriendsRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'id' => ['required', 'exists:add_friends',]
        ];
    }

    public function messages()
    {
        return [
            'id.required' => 'Lütfen Silmek İstediğiniz Arkadaşı Seçiniz.',
            'id.exists' => 'Arkadaşlık Verisi Bulunamadı'
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $response = new CustomJsonResponse(422, "Silme İşlemi Başarısız.", $validator->errors()->all());

        throw new \Illuminate\Validation\ValidationException($validator, $response);
    }
}
