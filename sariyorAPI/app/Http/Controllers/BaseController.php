<?php

namespace App\Http\Controllers;

class BaseController extends Controller
{
    /**
     * @param int $status_code
     * @param string $message
     * @param array $returned_data
     */
    function success(int $status_code, string $message, array $data): \Illuminate\Http\JsonResponse
    {
        $json_message = [
            'status_code' => $status_code,
            "message" => $message,
            "data" => $data
        ];
        return response()->json($json_message,$status_code);
    }

    function error(int $status_code, string $message, array $data): \Illuminate\Http\JsonResponse
    {
        $json_message = [
            'status_code' => $status_code,
            "message" => $message,
            "data" => $data
        ];
        return response()->json($json_message,$status_code);
    }
}
