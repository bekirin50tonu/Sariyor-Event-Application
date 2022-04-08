<?php

namespace App\Services;

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
        return Response::make($image->get($path), 200, ['Content-Type' => 'image/png']);
    }
}
