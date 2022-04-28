<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Http\Request;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Auth;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'first_name',
        'last_name',
        'username',
        'îmage_path',
        'email',
        'password',
        'email_verified_at'
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    protected $appends = ['friendship'];
    public function getFriendshipAttribute()
    {
        $id = Auth::id();
        $status1 = AddFriend::query()->where('request_user_id', $id)->where('response_user_id', $this->id);
        $status2 = AddFriend::query()->where('request_user_id', $this->id)->where('response_user_id',$id);
        if ($status1->exists()) {
            return $status1->first();
        }
        if ($status2->exists()){
            return $status2->first();
        }
        return null;
    }
}
