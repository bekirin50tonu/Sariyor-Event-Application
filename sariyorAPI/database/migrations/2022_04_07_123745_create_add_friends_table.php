<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('add_friends', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('request_user_id');
            $table->unsignedBigInteger('response_user_id');
            $table->enum('status',['pending','accepted'])->default('pending');
            $table->foreign('request_user_id')->references('id')->on('users');
            $table->foreign('response_user_id')->references('id')->on('users');
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
        Schema::dropIfExists('add_friends');
    }
};
