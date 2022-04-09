<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Events extends Model
{
    use HasFactory;

    protected $table = 'events';

    protected $fillable = ['name', 'description', 'owner_id', 'cat_id', 'lat', 'long', 'start_time', 'only_friends' ,'end_time', 'join_start_time', 'join_end_time', 'count', 'image_path'];

    protected $hidden = ['owner_id','cat_id'];

    protected $casts = [
        'only_friends' => 'boolean',
        'count' => 'int',
        'lat' => 'float',
        'long' => 'float',
        'start_time' => 'datetime',
        'end_time' => 'datetime',
        'join_start_time' => 'datetime',
        'join_end_time' => 'datetime',
    ];

    public function user(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(User::class,'id','owner_id');
    }

    public function category(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(Categories::class,'id','cat_id');
    }
}
