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
        Schema::create('tourist_guide_bookings', function (Blueprint $table) {
            $table->id();
            $table->foreignId('tourist_guide_id')->constrained('tourist_guides')->onDelete('cascade');
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('tourist_spot_id')->constrained('tourist_spots')->onDelete('cascade')->nullable();
            $table->string('date')->nullable();
            $table->string('time')->nullable();
            $table->string('status')->default('pending');
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
        Schema::dropIfExists('tourist_guide_bookings');
    }
};
