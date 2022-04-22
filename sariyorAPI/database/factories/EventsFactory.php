<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Carbon;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Events>
 */
class EventsFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     * @throws \Exception
     */
    public function definition()
    {
        $date = Carbon::now();
        return
            [
                'name' => $this->faker->userName(),
                'description' => $this->faker->paragraph(),
                'owner_id' => 2,
                'cat_id' => 1,
                'lat' => $this->faker->latitude(),
                'long' => $this->faker->longitude(),
                'start_time' => $date->toDateString(),
                'only_friends' => rand(0, 1) == 1,
                'end_time' => $date->addDays(10)->toDateString(),
                'join_start_time' => $date->toDateString(),
                'join_end_time' => $date->addDay(30)->toDateString(),
                'count' => rand(1, 10),
            ];
    }
}
