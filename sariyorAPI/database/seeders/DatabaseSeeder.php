<?php

namespace Database\Seeders;

use App\Models\Admin;
use App\Models\Categories;
use App\Models\Events;
use App\Models\JoinedEvent;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     * @throws \Exception
     */
    public function run()
    {
        $verified = new \DateTime("now", new \DateTimeZone("UTC"));
        $user = User::query()->create(['first_name' => 'admin', 'last_name' => 'admin', 'username' => 'admin', 'email_verified_at' => $verified, 'email' => 'admin@admin.com', 'image_path' => 'h1uj24h1ujı5h1uoh51huoh12o4h12o4h.png', 'password' => Hash::make('password')]);
        $beko = User::query()->create(['first_name' => 'bekir', 'last_name' => 'görmez', 'username' => 'bekirin50tonu', 'email_verified_at' => $verified, 'email' => 'bgrmz@yandex.com', 'image_path' => 'h1uj24h1ujı5h1uoh51huoh12o4h12o4h.png', 'password' => Hash::make('password')]);
        Admin::query()->create(['user_id' => $user->id]);
        User::factory(10)->create();
        Categories::factory(10)->create();
        Events::factory(20)->create();
        JoinedEvent::factory(20)->create();

    }
}
