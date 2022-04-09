<?php

namespace App\Http\Controllers\API\Events;

use App\Http\Controllers\Controller;
use App\Http\Requests\Event\CRUD\CreateEventRequest;
use App\Services\EventService;
use App\Services\ImageService;
use Illuminate\Http\Request;

class EventsController extends Controller
{

    // dependency injection
    public function createEvent(CreateEventRequest $request, EventService $service , ImageService $imageService): \App\Http\Helpers\Classes\CustomJsonResponse
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

}
