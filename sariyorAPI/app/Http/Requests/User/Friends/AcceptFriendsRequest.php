<?php

namespace App\Http\Requests\User\Friends;

use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Models\AddFriend;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class AcceptFriendsRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return AddFriend::query()->where('response_user_id',Auth::id())->exists();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'id' => ['required', 'exists:add_friends']
        ];
    }

    public function messages()
    {
        return [
            'id.required' => 'Onaylamak İstediğiniz İsteği Seçiniz.',
            'id.exists' => 'Böyle Bir Arkadaşlık İsteği Bulunamadı.',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $response = new CustomJsonResponse(422, "Onaylama İşlemi Başarısız.", $validator->errors()->all());

        throw new \Illuminate\Validation\ValidationException($validator, $response);
    }
}
