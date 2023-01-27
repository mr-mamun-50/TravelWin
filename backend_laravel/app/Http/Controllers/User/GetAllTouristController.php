<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\TouristGuide;
use Illuminate\Http\Request;

class GetAllTouristController extends Controller
{
    public function getAllTourist()
    {
        $tourist = TouristGuide::all();
        return response()->json([
            'tourists' => $tourist
        ], 200);
    }
}
