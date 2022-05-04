<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AddFriend extends Model
{
    use HasFactory;

    protected $fillable = ['request_user_id', 'response_user_id', 'status'];

    public function user(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(User::class, 'id', 'request_user_id')->select(['id', 'first_name', 'last_name', 'email', 'username', 'image_path']);
    }
}
