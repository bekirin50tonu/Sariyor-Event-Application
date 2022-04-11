<?php

namespace App\Http\Controllers\WEB\Admin;

use App\Http\Controllers\Controller;
use App\Http\Helpers\EnumTypes\ImageRoute;
use App\Models\Categories;
use App\Models\Events;
use App\Models\User;
use App\Services\ImageService;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\View;

class CategoryController extends Controller
{
    public function get(): \Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View|\Illuminate\Contracts\Foundation\Application
    {
        $user = Auth::id();
        $user = User::query()->where('id', $user)->first();
        $categories = Categories::all();
        $events = Events::all();
        return View::make('admin.dashboard', compact('user', 'categories', 'events'));
    }

    public function createCategory(Request $request, ImageService $service): \Illuminate\Http\RedirectResponse
    {
//        dd($request);
        try {
            $params['name'] = $request['cat_name'];
            $image = $request->file('cat_image');
            if (!is_null($image)) {
                $params['image_path'] = $service->storeImage($image, ImageRoute::Category);
            }
            Categories::query()->create($params);
            return redirect()->route('admincategoryget');
        } catch (\Throwable $e) {
            return redirect()->back()->withErrors($e->getMessage());
        }
    }

    public function updateCategory(int $id, Request $request, ImageService $service)
    {
        try {
            $query = Categories::query()->where('id', $id)->firstOrFail();
            $params['name'] = $request['cat_name'];
            $image = $request->file('cat_image');
            if (!is_null($image)) {
                $params['image_path'] = $service->storeImage($image, ImageRoute::Category);
            }
            $status = $query->update($params);
            return redirect()->route('admincategoryget');
        } catch (ModelNotFoundException $e) {
            return redirect()->back()->withErrors('Belirtilen Veri Bulunamadı.');
        }
    }

    public function deleteCategory(int $id, Request $request)
    {
        try {
            $query = Categories::query()->where('id', $id)->firstOrFail();
            $status = $query->delete();
            return redirect()->route('admincategoryget');
        } catch (ModelNotFoundException $e) {
            return redirect()->back()->withErrors('Belirtilen Veri Bulunamadı.');
        }
    }
}
