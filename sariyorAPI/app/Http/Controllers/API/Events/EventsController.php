<?php

namespace App\Http\Controllers\API\Events;

use App\Http\Controllers\Controller;
use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Http\Requests\Event\CRUD\CreateEventRequest;
use App\Models\Events;
use App\Services\EventService;
use App\Services\ImageService;
use Illuminate\Http\Request;

class EventsController extends Controller
{

    // dependency injection
    public function createEvent(CreateEventRequest $request, EventService $service, ImageService $imageService): \App\Http\Helpers\Classes\CustomJsonResponse
    {
        $user = $request->user();
        $image = $request->file('image');
        unset($request['image']);
        return $service->createEvent(service: $imageService, user: $user, image_path: $image, params: $request->all());
    }

    public function updateEvent(Request $request, EventService $service, ImageService $imageService): \App\Http\Helpers\Classes\CustomJsonResponse
    {
        $params = $request->all();
        $image = $request->file('image');
        $id = $request['id'];
        unset($params['id']);
        unset($params['image']);
        return $service->updateEvent($imageService, $image, $id, $params);

    }

    public function deleteEvent(EventService $service, Request $request): \App\Http\Helpers\Classes\CustomJsonResponse
    {
        return $service->deleteEvent($request['id']);
    }

    public function getEvent(EventService $service, Request $request): \App\Http\Helpers\Classes\CustomJsonResponse
    {
        return $service->getEvent($request['id']);
    }

    public function getAllEvent(EventService $service, Request $request): \App\Http\Helpers\Classes\CustomJsonResponse
    {
        return $service->getFilteredEvents($request);


    }

    public function getByCategory(Request $request): CustomJsonResponse
    {
        try {
            $cat_id = $request->input('id');
            $user = $request->user();
            $events = Events::query()->where('cat_id', $cat_id)->with('user:id,first_name,last_name,username,email,image_path')->with('category:id,name,image_path')->get()->toArray();
            return new CustomJsonResponse(200, 'Kateroriye Göre Etkinlikler Getirildi', $events);
        } catch (\Throwable $e) {
            return new CustomJsonResponse(404, $e->getMessage(), $e->getTrace());
        }
    }

}
