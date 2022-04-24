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
Route::prefix('{local}')->group(function ($local) {
});

Route::prefix('auth')->group(function () {
    Route::post('register', [\App\Http\Controllers\API\Auth\AuthController::class, 'register'])->name('register');
    Route::post('login', [\App\Http\Controllers\API\Auth\AuthController::class, 'login'])->name('login');
    Route::post('logout', [\App\Http\Controllers\API\Auth\AuthController::class, 'logout'])->middleware('auth:sanctum')->name('logout');
});

Route::prefix('friend')->middleware(['auth:sanctum'])->group(function () {
    Route::post('add', [\App\Http\Controllers\API\User\AddFriendController::class, 'addFriend'])->name('add');
    Route::post('delete', [\App\Http\Controllers\API\User\AddFriendController::class, 'deleteFriend'])->name('friend.delete');
    Route::post('accept', [\App\Http\Controllers\API\User\AddFriendController::class, 'acceptFriendQuest'])->name('accept');
    Route::get('request', [\App\Http\Controllers\API\User\AddFriendController::class, 'getFriendRequest'])->name('request');
});

Route::prefix('event')->middleware(['auth:sanctum'])->group(function () {
    Route::get('all',[\App\Http\Controllers\API\Events\EventsController::class,'getAllEvent'])->name('event.all');
    Route::get('get_joined',[\App\Http\Controllers\API\Events\JoinedEventsController::class,'getJoinedEvents'])->name('event.joined');
    Route::post('create', [\App\Http\Controllers\API\Events\EventsController::class, 'createEvent'])->name('create');
    Route::post('delete', [\App\Http\Controllers\API\Events\EventsController::class, 'deleteEvent'])->middleware(['isOwner'])->name('event.delete');
    Route::post('update', [\App\Http\Controllers\API\Events\EventsController::class, 'updateEvent'])->middleware(['isOwner'])->name('event.update');
    Route::post('join', [\App\Http\Controllers\API\Events\JoinedEventsController::class, 'joinEvent'])->name('join');
    Route::post('exit', [\App\Http\Controllers\API\Events\JoinedEventsController::class, 'exitEvent'])->name('exit');
    Route::post('get', [\App\Http\Controllers\API\Events\EventsController::class, 'getEvent'])->name('event.get');
});

Route::prefix('user')->middleware(['auth:sanctum'])->group(function () {
    Route::get('friends', [\App\Http\Controllers\API\User\UserController::class, 'getFriends'])->name('friends');
    Route::post('get', [\App\Http\Controllers\API\User\UserController::class, 'getUser'])->name('get');
    Route::post('update', [\App\Http\Controllers\API\User\UserController::class, 'updateUser'])->middleware(['isOwner'])->name('update');
    Route::post('delete', [\App\Http\Controllers\API\User\UserController::class, 'deleteUser'])->middleware(['isOwner'])->name('delete');
});

Route::prefix('search')->middleware(['auth:sanctum'])->group(function () {
    Route::post('user', [\App\Http\Controllers\API\Events\SearchController::class, 'userSearch'])->name('user');
    Route::post('category', [\App\Http\Controllers\API\Events\SearchController::class, 'categorySearch'])->name('category');
    Route::post('event', [\App\Http\Controllers\API\Events\SearchController::class, 'eventSearch'])->name('event');
    Route::post('/', [\App\Http\Controllers\API\Events\SearchController::class, 'allSearch'])->name('all');
});

