<?php

namespace App\Http\Controllers\API\Events;

use App\Http\Controllers\Controller;
use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Http\Requests\Event\JoinedEvents\JoinedRequest;
use App\Services\EventService;
use Illuminate\Http\Request;

class JoinedEventsController extends Controller
{

    public function joinEvent(JoinedRequest $request, EventService $service): CustomJsonResponse
    {

        $user = $request->user();
        return $service->joinEvent($user, $request->all());
    }

    public function exitEvent(JoinedRequest $request, EventService $service): CustomJsonResponse
    {
        $user = $request->user();
        return $service->exitEvent($user, $request->all());
    }

    public function getJoinedEvents(Request $request,EventService $service)
    {
        $user = $request->user();
        return $service->getJoinedEvents($user);
    }


}
