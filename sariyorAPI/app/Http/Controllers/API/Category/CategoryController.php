<?php

namespace App\Http\Controllers\API\Category;

use App\Http\Controllers\Controller;
use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Models\Categories;

class CategoryController extends Controller
{
    public function index(): CustomJsonResponse
    {
        try {
            $category = Categories::query()->orderByDesc('updated_at')->get()->toArray();
            return new CustomJsonResponse(200, 'Kategoriler Başarıyla Getirildi.', $category);
        } catch (\Throwable $e) {
            return new CustomJsonResponse(404, $e->getMessage(), $e->getTrace());

        }
    }
}
