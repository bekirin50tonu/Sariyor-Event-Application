<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JoinedEvent extends Model
{
    use HasFactory;

protected $table = 'joined_events';
    protected $fillable = ['user_id','event_id'];
}
