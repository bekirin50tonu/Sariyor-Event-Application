<?php

namespace App\Http\Controllers\API\User;

use App\Exceptions\ModelDataNotFound;
use App\Http\Controllers\Controller;
use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Services\ImageService;
use App\Services\UserService;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * @throws ModelDataNotFound
     */
    public function getUser(Request $request, UserService $service): CustomJsonResponse
    {
        $user = $request->has('id') ? $service->getUserDetail($request['id']) : $service->getUserDetail($request->user()->id);
        return $service->getUser($user);
    }

    public function updateUser(Request $request, UserService $service, ImageService $imageService): CustomJsonResponse
    {
        return $service->updateUser($request->user(), $imageService, $request);
    }

    public function deleteUser(Request $request, UserService $service): CustomJsonResponse
    {
        return $service->deleteUser($request->user());
    }

    public function getFriends(Request $request, UserService $service): \App\Http\Helpers\Classes\CustomJsonResponse
    {
        $user = $request->user();
        return $service->getFriends($user);
    }
}
