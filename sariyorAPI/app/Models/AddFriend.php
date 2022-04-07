<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AddFriend extends Model
{
    use HasFactory;

    protected $fillable = ['request_user_id','response_user_id','status'];
}
