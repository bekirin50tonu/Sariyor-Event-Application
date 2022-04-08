<?php

use App\Http\Helpers\EnumTypes\ImageType;
use App\Services\ImageService;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::prefix('image')->group(function () {
    Route::get('event/{path}', function (ImageService $service, string $path) {
        return $service->getStoredImage($path, ImageType::EVENT);
    });
    Route::get('profile/{path}', function (ImageService $service, string $path) {
        return $service->getStoredImage($path, ImageType::PROFILE);
    });
    Route::get('category/{path}', function (ImageService $service, string $path) {
        return $service->getStoredImage($path, ImageType::CATEGORY);
    });
});
