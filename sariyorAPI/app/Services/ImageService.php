<?php

namespace App\Services;

use App\Http\Helpers\EnumTypes\ImageRoute;
use App\Http\Helpers\EnumTypes\ImageType;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Storage;

class ImageService
{
    public function storeImage(UploadedFile $image, string $path): bool|string
    {
        $image->store($path);
        return $image->hashName();
    }

    public function getStoredImage(string $path, string $type): \Illuminate\Http\Response
    {
        $image = Storage::disk($type);
        if (!is_null($image->get($path))) return Response::make($image->get($path), 200, ['Content-Type' => 'image/png']);
        $image = Storage::disk(ImageType::DUMMY);
        if ($type === ImageType::PROFILE) return Response::make($image->get('profile.png'), 200, ['Content-Type' => 'image/png']);
        return Response::make($image->get('event.jpeg'), 200, ['Content-Type' => 'image/png']);
    }
}
