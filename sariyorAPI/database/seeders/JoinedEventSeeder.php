<?php

namespace Database\Seeders;

use App\Models\JoinedEvent;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class JoinedEventSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        JoinedEvent::factory(10)->create();
    }
}
