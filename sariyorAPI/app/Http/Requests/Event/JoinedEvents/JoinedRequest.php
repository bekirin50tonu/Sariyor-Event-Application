<?php

namespace App\Http\Requests\Event\JoinedEvents;

use App\Http\Helpers\Classes\CustomJsonResponse;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use JetBrains\PhpStorm\ArrayShape;

class JoinedRequest extends FormRequest
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
    #[ArrayShape(['id' => "string", 1 => "string"])] public function rules(): array
    {
        return ['id' => 'required', 'exists:events.id'];
    }

    #[ArrayShape(['id.required' => "string", 'id.exists' => "string"])] public function messages(): array
    {
        return ['id.required' => 'Etkinlik Numarası Gereklidir.', 'id.exists' => 'İstenilen Veri Bulunamadı.'];
    }

    protected function failedValidation(Validator $validator)
    {
        $response = new CustomJsonResponse(422, "Giriş Başarısız", $validator->errors()->all());

        throw new \Illuminate\Validation\ValidationException($validator, $response);
    }
}
