<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class JoinedEvent extends Model
{
    use HasFactory;

    protected $table = 'joined_events';
    protected $fillable = ['user_id', 'event_id'];
    protected $appends = ['time_str','locate'];
    protected $hidden = ['user_id', 'event_id'];

    public function getTimeSTRAttribute()
    {
        return $this->updated_at->diffForHumans();
    }

    public function getLocateAttribute()
    {

        return "";
    }

    public function user(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(User::class, 'id', 'user_id');
    }

    public function event(): \Illuminate\Database\Eloquent\Relations\HasOne
    {
        return $this->hasOne(Events::class, 'id', 'event_id')->with('user:id,first_name,last_name,username,email,image_path')->with('category:id,name,image_path');
    }
}
