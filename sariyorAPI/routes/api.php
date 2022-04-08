<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::prefix('auth')->group(function () {
    Route::post('register', [\App\Http\Controllers\API\Auth\AuthController::class, 'register'])->name('register');
    Route::post('login', [\App\Http\Controllers\API\Auth\AuthController::class, 'login'])->name('login');
    Route::post('logout', [\App\Http\Controllers\API\Auth\AuthController::class, 'logout'])->middleware('auth:sanctum')->name('logout');
});

Route::prefix('friend')->middleware(['auth:sanctum'])->group(function () {
    Route::post('add', [\App\Http\Controllers\API\User\AddFriendController::class, 'addFriend'])->name('add');
    Route::post('delete', [\App\Http\Controllers\API\User\AddFriendController::class, 'deleteFriend'])->name('delete');
    Route::post('accept', [\App\Http\Controllers\API\User\AddFriendController::class, 'acceptFriendQuest'])->name('accept');
    Route::get('all', [\App\Http\Controllers\API\User\AddFriendController::class, 'getFriends'])->name('all');
    Route::get('request', [\App\Http\Controllers\API\User\AddFriendController::class, 'getFriendRequest'])->name('request');
});

Route::prefix('event')->middleware(['auth:sanctum'])->group(function () {
    Route::post('create', [\App\Http\Controllers\API\Events\EventsController::class, 'createEvent'])->name('create');
    Route::post('delete', [\App\Http\Controllers\API\Events\EventsController::class, 'deleteEvent'])->middleware(['isOwner'])->name('delete');
    Route::post('update', [\App\Http\Controllers\API\Events\EventsController::class, 'updateEvent'])->middleware(['isOwner'])->name('update');
    Route::get('get', [\App\Http\Controllers\API\Events\EventsController::class, 'getEvent'])->name('get');
    Route::prefix('category')->group(function (){

    });
});

