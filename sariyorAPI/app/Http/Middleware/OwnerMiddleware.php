<?php

namespace App\Http\Middleware;

use App\Exceptions\NotOwnerException;
use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Models\Events;
use Closure;
use Illuminate\Http\Request;

class OwnerMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param \Illuminate\Http\Request $request
     * @param \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     * @throws NotOwnerException
     */
    public function handle(Request $request, Closure $next)
    {
        $user = $request->user();
        if (!Events::query()->where('id',$request['id'])->where('owner_id',$user->id)->exists()) {
            throw new NotOwnerException('Veri Sana Ait Değil!');
        }
        return $next($request);
    }


}
