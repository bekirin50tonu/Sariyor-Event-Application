<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Events extends Model
{
    use HasFactory;

    protected $table = 'events';

    protected $fillable = ['name', 'description', 'owner_id', 'cat_id', 'lat', 'long', 'start_time', 'end_time', 'join_start_time', 'join_end_time', 'count', 'image_path'];
}
