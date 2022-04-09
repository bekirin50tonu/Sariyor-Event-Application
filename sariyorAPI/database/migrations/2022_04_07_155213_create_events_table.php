<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('events', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('cat_id');
            $table->foreign('cat_id')->references('id')->on('categories');
            $table->unsignedBigInteger('owner_id');
            $table->foreign('owner_id')->references('id')->on('users');
            $table->string('name');
            $table->string('description');
            $table->string('image_path')->nullable();
            $table->integer('count')->default(-1);
            $table->boolean('only_friends')->default(false);
            // Maps Data
            $table->float('lat');
            $table->float('long');
            // Dates
            $table->dateTime('start_time');
            $table->dateTime('end_time');
            $table->dateTime('join_start_time');
            $table->dateTime('join_end_time');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('events');
    }
};
