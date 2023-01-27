<?php

namespace App\Http\Controllers\TouristSpots;

use App\Http\Controllers\Controller;
use App\Models\TouristGuideBooking;
use App\Models\TouristSpots;
use Illuminate\Http\Request;

class TouristSpotsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $touristSpots = TouristSpots::all();

        return response()->json([
            'touristSpots' => $touristSpots
        ], 200);
    }

    public function guideBooking(Request $request)
    {
        $data = [
            'tourist_guide_id' => $request->tourist_guide_id,
            'user_id' => auth()->user()->id,
            'date' => $request->date,
            'time' => $request->time,
            // 'status' => $request->status,
        ];

        TouristGuideBooking::create($data);

        return response([
            'message' => 'Successfully booked a guide!'
        ], 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data = [
            'name' => $request->name,
            'description' => $request->description,
            'latitude' => $request->latitude,
            'longitude' => $request->longitude,
        ];

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $name = time() . '.' . $image->getClientOriginalExtension();
            $destinationPath = public_path('/images/touristSpots');
            $image->move($destinationPath, $name);
            $data['image'] = $name;
        }

        TouristSpots::create($data);

        return response([
            'message' => 'Successfully created tourist spot!'
        ], 200);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
