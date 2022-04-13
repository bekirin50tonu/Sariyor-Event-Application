<?php

namespace App\Http\Controllers\API\Events;

use App\Http\Controllers\Controller;
use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Models\Categories;
use App\Models\Events;
use App\Models\User;
use Illuminate\Http\Request;

class SearchController extends Controller
{
    public function userSearch(Request $request): CustomJsonResponse
    {
        try {
            if (is_null($request['search'])) return new CustomJsonResponse(200, 'Başarıyla Arandı.', []);
            $response = $this->getUserCollection($request['search']);
            return new CustomJsonResponse(200, 'Başarıyla Arandı.', $response->toArray());

        } catch (\Throwable $e) {
            return new CustomJsonResponse(404, 'Hata', $e->getTrace());
        }

    }

    public function categorySearch(Request $request): CustomJsonResponse
    {
        try {
            if (is_null($request['search'])) return new CustomJsonResponse(200, 'Başarıyla Arandı.', []);
            $response = $this->getCategoryCollection($request['search']);
            return new CustomJsonResponse(200, 'Başarıyla Arandı.', $response->toArray());

        } catch (\Throwable $e) {
            return new CustomJsonResponse(404, 'Hata', $e->getTrace());
        }
    }

    public function eventSearch(Request $request): CustomJsonResponse
    {
        try {
            if (is_null($request['search'])) return new CustomJsonResponse(200, 'Başarıyla Arandı.', []);
            $response = $this->getEventCollection($request['search']);
            return new CustomJsonResponse(200, 'Başarıyla Arandı.', $response->toArray());

        } catch (\Throwable $e) {
            return new CustomJsonResponse(404, 'Hata', $e->getTrace());
        }
    }

    public function allSearch(Request $request): CustomJsonResponse
    {
        try {
            if (is_null($request['search'])) return new CustomJsonResponse(200, 'Başarıyla Arandı.', []);
            $response['users'] = $this->getUserCollection($request['search']);
            $response['events'] = $this->getEventCollection($request['search']);
            $response['categories'] = $this->getCategoryCollection($request['search']);
            return new CustomJsonResponse(200, 'Başarıyla Arandı.', $response);
        } catch (\Throwable $e) {
            return new CustomJsonResponse(404, 'Hata', $e->getTrace());
        }
    }

    /**
     * @param $search
     */
    private function getUserCollection($search): \Illuminate\Database\Eloquent\Collection|array
    {
        return User::query()
            ->where('first_name', 'LIKE', '%' . $search . '%')
            ->orWhere('username', 'LIKE', '%' . $search . '%')
            ->orWhere('email', 'LIKE', '%' . $search . '%')
            ->orWhere('last_name', 'LIKE', '%' . $search . '%')->get();
    }

    private function getEventCollection($search): \Illuminate\Database\Eloquent\Collection|array
    {
        return Events::query()
            ->where('name', 'LIKE', '%' . $search . '%')->with(['user','category'])->get();
    }

    private function getCategoryCollection($search): \Illuminate\Database\Eloquent\Collection|array
    {
        return Categories::query()
            ->where('name', 'LIKE', '%' . $search . '%')->get();
    }
}
