<?php

namespace App\Http\Requests\Event\CRUD;

use App\Http\Helpers\Classes\CustomJsonResponse;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;

class CreateEventRequest extends FormRequest
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
    public function rules(): array
    {
        return [
            'cat_id' => ['required'],
            'name' => ['required', 'min:2', 'max:15'],
            'description' => ['required', 'min:5'],
            'image' => ['image', 'mimes:jpeg,jpg,png', 'nullable'],
            'lat' => ['required'],
            'long' => ['required'],
            'start_time' => ['required', 'date'],
            'end_time' => ['required', 'date'],
            'join_start_time' => ['required', 'date'],
            'join_end_time' => ['required', 'date'],
            'count' => ['nullable'],
        ];
    }

    public function messages()
    {
        return [
            'cat_id.required' => 'Kategori Numarası Girilmelidir',
            'name.required' => 'Etkinlik İsmi Girilmelidir.',
            'name.min' => 'Karakter Sayısı 2\'den Düşük Olamaz.',
            'name.max' => 'Karakter Sayısı 15\'ten Fazla Olamaz.',
            'description.required' => 'Etkinlik Açıklaması Girilmelidir.',
            'description.min' => 'Açıklama 2\'den Fazla Olmalıdır.',
            'image.image' => 'Resim Girilmelidir',
            'image.mimes' => 'Desteklenen Tipler [jpeg,jpg,png] Şeklindedir.',
            'lat.required' => 'Lat Değeri Girilmelidir.',
            'long.required' => 'Long Değeri Girilmelidir.',
            'start_time.required' => 'Etkinliğin Başlama Tarihi Girilmelidir.',
            'start_time.date' => 'Tarih Şeklinde Girilmelidir',
            'end_time.required' => 'Etkinliğin Bitiş Tarihi Girilmelidir.',
            'end_time.date' => 'Tarih Şeklinde Girilmelidir',
            'join_start_time.required' => 'Etkinliğin Katılım Tarihi Girilmelidir.',
            'join_start_time.date' => 'Tarih Şeklinde Girilmelidir',
            'join_end_time.required' => 'Etkinliğin Son Katılım Tarihi Girilmelidir.',
            'join_end_time.date' => 'Tarih Şeklinde Girilmelidir',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $response = new CustomJsonResponse(422, "Kayıt İşlemi Başarısız", $validator->errors()->all());

        throw new \Illuminate\Validation\ValidationException($validator, $response);
    }
}
