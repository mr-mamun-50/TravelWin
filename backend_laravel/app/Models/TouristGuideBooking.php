<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TouristGuideBooking extends Model
{
    use HasFactory;

    protected $fillable = [
        'tourist_guide_id',
        'user_id',
        'tourist_spot_id',
        'date',
        'time',
        'status',
    ];

    public function touristGuide()
    {
        return $this->belongsTo(TouristGuide::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function touristSpot()
    {
        return $this->belongsTo(TouristSpot::class);
    }
}
