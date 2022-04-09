<?php

namespace App\Http\Controllers\API\User;

use App\Http\Controllers\Controller;
use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Http\Requests\User\Friends\AcceptFriendsRequest;
use App\Http\Requests\User\Friends\AddFriendsRequest;
use App\Http\Requests\User\Friends\DeleteFriendsRequest;
use App\Models\AddFriend;
use Illuminate\Http\Request;

class AddFriendController extends Controller
{
    public function addFriend(AddFriendsRequest $request): CustomJsonResponse
    {
        try {
            $user = $request->user();
            $receiver['request_user_id'] = $user->id;
            $receiver['response_user_id'] = $request['user_id'];
            print_r($request->get('user_id'));
            if ($receiver['request_user_id'] == $receiver['response_user_id']) {
                return new CustomJsonResponse(403, 'Kendini Arkadaş Olarak Ekleyemezsin.', []);
            }
            $status = AddFriend::query()->create($receiver);
            return new CustomJsonResponse(200, 'Başarılı', [$status]);
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }

    }

    public function deleteFriend(DeleteFriendsRequest $request): CustomJsonResponse
    {
        try {
            $status = AddFriend::query()->where('id', $request['id'])->delete();
            return new CustomJsonResponse(200, 'Başarılı', [$status]);
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

    public function acceptFriendQuest(AcceptFriendsRequest $request): CustomJsonResponse
    {
        try {
            $status = AddFriend::query()->where('id', $request['id']);
            if ($status->where('status', 'accepted')->first()) {
                return new CustomJsonResponse(403, 'Arkadaşlık İsteği Zaten Kabul Edilmiş.', []);
            }
            $status->update(['status' => 'accepted']);
            return new CustomJsonResponse(200, 'Başarılı', [$status]);
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());

        }

    }


    public function getFriendRequest(Request $request): CustomJsonResponse
    {
        try {
            $user = $request->user();
            $quests = AddFriend::query()->where('response_user_id', $user->id)->get();
            return new CustomJsonResponse(200, 'Arkadaşlık İstekleri Başarıyla Getirildi.', $quests->toArray());
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

    public function getFollowers(Request $request): CustomJsonResponse
    {
        try {
            $user = $request->user();
            $quests = AddFriend::query()->where('response_user_id', $user->id)->get();
            return new CustomJsonResponse(200, 'Takip Edenler Başarıyla Getirildi.', $quests->toArray());
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

    //NOTE:  Burası Kaldırılabilir.
    public function getFollowedBy(Request $request)
    {
        try {
            $user = $request->user();
            $quests = AddFriend::query()->where('request_user_id', $user->id)->get();
            return new CustomJsonResponse(200, 'Takip Edilenler Başarıyla Getirildi', $quests->toArray());
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }
}
