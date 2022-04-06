<?php

namespace App\Http\Helpers\Classes;

use Illuminate\Http\JsonResponse;

class CustomJsonResponse extends JsonResponse
{
    public function __construct(int $status_code, string $message, ?array $data)
    {
        $send_array = [
            'success' => $status_code === 200, // True of False
            'message' => $message
        ];
        if ($status_code === 200) {
            $send_array['data'] = $data;
        } else {
            $send_array['errors'] = $data;
        }
        parent::__construct($send_array, $status_code);
    }
}
