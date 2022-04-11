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

Route::prefix('image')->name('image')->group(function () {
    Route::get('event/{path}', function (ImageService $service, string $path) {
        return $service->getStoredImage($path, ImageType::EVENT);
    })->name('event');
    Route::get('profile/{path}', function (ImageService $service, string $path) {
        return $service->getStoredImage($path, ImageType::PROFILE);
    })->name('profile');
    Route::get('category/{path}', function (ImageService $service, string $path) {
        return $service->getStoredImage($path, ImageType::CATEGORY);
    })->name('category');
});

Route::prefix('auth')->group(function () {
    Route::get('login', [\App\Http\Controllers\WEB\User\AuthController::class, 'login'])->name('login.get');
    Route::post('login', [\App\Http\Controllers\WEB\User\AuthController::class, 'loginPost'])->name('login.post');
});

Route::prefix('admin')->middleware(['auth'])->name('admin')->group(function () {
    Route::prefix('category')->name('category')->group(function () {
        Route::get('/', [\App\Http\Controllers\WEB\Admin\CategoryController::class, 'get'])->name('get');
        Route::post('/create', [\App\Http\Controllers\WEB\Admin\CategoryController::class, 'createCategory'])->name('create');
        Route::post('/update/{id}', [\App\Http\Controllers\WEB\Admin\CategoryController::class, 'updateCategory'])->name('update');
        Route::post('/delete/{id}', [\App\Http\Controllers\WEB\Admin\CategoryController::class, 'deleteCategory'])->name('delete');

    });

    Route::get('logout', [\App\Http\Controllers\WEB\User\AuthController::class, 'logout'])->name('logout');
});
