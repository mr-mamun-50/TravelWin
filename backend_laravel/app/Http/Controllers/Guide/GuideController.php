<?php

namespace App\Http\Controllers\Guide;

use App\Http\Controllers\Controller;
use App\Models\TouristGuide;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;

class GuideController extends Controller
{
    //__Register user
    public function register(Request $request)
    {
        $validate = $request->validate([
            'name' => 'required|string',
            'email' => 'required|string|email|unique:tourist_guides',
            'phone' => 'required|string|unique:tourist_guides|min:11',
            'password' => 'required|string|confirmed|min:8'
        ]);

        $user = TouristGuide::create([
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'password' => bcrypt($request->password)
        ]);

        $token = $user->createToken('TravelWin', ['tourist_guide'])->plainTextToken;

        return response()->json([
            'access_token' => $token,
            'user' => $user
        ]);
    }


    //__Login user
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        $credentials = request(['email', 'password']);

        if (!Auth::guard('tourist_guide')->attempt($credentials)) {
            return response()->json([
                'message' => 'Invalid credentials',
            ], 403);
        }

        $user = Auth::guard('tourist_guide')->user();
        $token = $user->createToken('TravelWin', ['tourist_guide'])->plainTextToken;

        return response()->json([
            'access_token' => $token,
            'user' => $user
        ], 200);
    }


    //__Logout user
    public function logout()
    {
        Auth::user()->tokens()->delete();

        return response()->json([
            'message' => 'Logged out'
        ], 200);
    }


    //__Get user
    public function user()
    {
        return response()->json([
            'user'  => Auth::user(),
        ], 200);
    }


    //__update profile
    public function updateProfile(Request $request)
    {
        $user = Auth::user();

        $request->validate([
            'name' => 'required|string',
            'phone' => 'required|string|min:11',
            'address' => 'required|string',
            'nid' => 'required|string|min:10',
            'rent_per_hour' => 'required',
            'credit_card' => 'required|string|min:16',
        ]);
        $data = [
            'name' => $request->name,
            'phone' => $request->phone,
            'address' => $request->address,
            'nid' => $request->nid,
            'rent_per_hour' => $request->rent_per_hour,
            'credit_card' => $request->credit_card,
        ];

        if ($request->photo) {

            if ($user->photo != null) {
                File::delete(public_path('/images/profile_pictures/' . $user->photo));
            }
            $photo = base64_decode($request->photo);
            $photo_name = time() . '.png';
            $path = public_path() . '/images/profile_pictures/' . $photo_name;
            file_put_contents($path, $photo);

            $data['photo'] = $photo_name;
        }

        $user->update($data);

        return response()->json([
            'user' => $user
        ], 200);
    }


    //__update lat long
    public function updateServiceArea(Request $request)
    {
        $user = Auth::user();

        $request->validate([
            'service_area' => 'required',
            'service_area_lat' => 'required|min:2',
            'service_area_lng' => 'required|min:2',
        ]);

        $user->update([
            'service_area' => $request->service_area,
            'service_area_lat' => $request->service_area_lat,
            'service_area_lng' => $request->service_area_lng,
        ]);

        return response()->json([
            'user' => $user
        ], 200);
    }
}
