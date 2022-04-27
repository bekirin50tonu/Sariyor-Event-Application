<?php

namespace App\Services;

use App\Exceptions\ModelDataNotFound;
use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Http\Helpers\EnumTypes\ImageRoute;
use App\Models\AddFriend;
use App\Models\User;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class UserService
{

    /**
     * @throws ModelDataNotFound
     */
    public function getUserDetail(int $id): \Illuminate\Database\Eloquent\Model
    {
        $user = User::query()->where('id', $id);
        if (!$user->exists()) throw new ModelDataNotFound("İstenen Veri Bulunamadı.");
        return $user->first();
    }

    public function getUser(Model $user)
    {
        return new CustomJsonResponse(200, "Kullanıcı Bilgisi Başarıyla Getirildi.", [$user]);
        try {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        } catch (\Throwable $e) {

        }
    }

    public function updateUser(Authenticatable $user, ImageService $service, Request $request)
    {
        try {
            $params = $request->all();
            $image = $request->file('image');
            if ($image) {
                unset($params['image']);
                $params['image_path'] = $service->storeImage($image, ImageRoute::Profile);
            }
            if ($request->has('password')) {
                $params['password'] = Hash::make($request['password']);
            }
            $user = User::query()->where('id', $user->id);
            $status = $user->update($params);
            return new CustomJsonResponse(200, 'Bilgiler Başarıyla Güncellendi', [$user->first()]);
        } catch (\Throwable $e) {
            Log::error($e);
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

    public function deleteUser(Authenticatable $user)
    {
        try {
            $status = User::query()->where('id', $user->id)->delete();
            return new CustomJsonResponse(200, 'Kullanıcı Başarıyla Kaldırıldı.', [$status]);
        } catch (\Throwable $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }

    }

    public function getFriends(Authenticatable $user): CustomJsonResponse
    {
        try {
            $quests = AddFriend::query()->where('request_user_id', $user->id)->where('status', 'accepted')->orWhere('response_user_id', $user->id)->get();
            return new CustomJsonResponse(200, 'Bütün Arkadaşlar Getirildi.', $quests->toArray());
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }
}
