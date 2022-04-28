<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Categories extends Model
{
    use HasFactory;

    protected $table = 'categories';

    protected $fillable = ['name', 'image_path'];

    protected $appends = ['count'];

    public function getCountAttribute(): int
    {
        return $this->hasMany(Events::class,'cat_id','id')->count();
    }
}
