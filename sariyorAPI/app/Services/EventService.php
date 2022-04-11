<?php

namespace App\Services;

use App\Http\Helpers\Classes\CustomJsonResponse;
use App\Http\Helpers\EnumTypes\ImageRoute;
use App\Models\Events;
use App\Models\JoinedEvent;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\UploadedFile;

class EventService
{
    public function createEvent(
        ImageService      $service,
        Authenticatable   $user,
        UploadedFile|null $image_path,
        array             $params)
    {
        try {
            $params['owner_id'] = $user->id;
            $params['image_path'] = !is_null($image_path) ? $service->storeImage($image_path, ImageRoute::Events) : null;

            $data = Events::query()->create($params);
            return new CustomJsonResponse(200, 'Etkinlik Başarıyla Oluşturuldu.', [$data]);
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

    public function updateEvent(
        ImageService      $service,
        UploadedFile|null $image_path,
        int               $id,
        array             $params)
    {
        try {
            $params['image_path'] = $image_path != null ? $service->storeImage($image_path, ImageRoute::Events) : null;
            $data = Events::query()->where('id', $id)->update($params);
            return new CustomJsonResponse(200, 'Etkinlik Başarıyla Güncellendi.', [$data]);
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

    public function deleteEvent(int $id)
    {
        try {
            $data = Events::query()->where('id', $id)->delete();
            return new CustomJsonResponse(200, 'Etkinlik Başarıyla Kaldırıldı.', [$data]);
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

    public function getEvent(int $id)
    {
        try {
            $data = Events::query()->where('id', $id)->with(['user:id,first_name,last_name,username,image_path', 'category:id,name,image_path'])->firstOrFail();
            return new CustomJsonResponse(200, 'Etkinlik Başarıyla Getirildi.', [$data]);
        } catch (ModelNotFoundException $e) {
            return new CustomJsonResponse(404, 'Etkinlik Bulunamadı', ['İstenilen Etkinlik Bulunamadı.']);
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

    public function joinEvent(Authenticatable $user, array $params)
    {
        try {
            $array = $params;
            $array['user_id'] = $user->id;
            $array['event_id'] = $params['id'];
            $status = JoinedEvent::query()->updateOrCreate($array);
            return new CustomJsonResponse(200, 'Etkinlik Girişi Başarıyla Oluşturuldu.', [$status]);
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

    public function exitEvent(Authenticatable $user, array $params)
    {
        try {
            $status = JoinedEvent::query()->where($params)->where('user_id', $user->id)->delete();
            return new CustomJsonResponse(200, 'Etkinlik Girişi Başarıyla Silindi.', [$status]);
        } catch (\Exception $e) {
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        }
    }

    public function getFilteredEvents()
    {

    }

    public function createCategory()
    {

    }

    public function deleteCategory()
    {

    }

    public function updateCategory()
    {

    }

    public function getCategory()
    {

    }

    public function getAllCategories()
    {

    }
}
