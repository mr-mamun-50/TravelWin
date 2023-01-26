<?php

namespace App\Http\Controllers\Driver;

use App\Http\Controllers\Controller;
use App\Models\Driver;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DriverController extends Controller
{
    //__Register user
    public function register(Request $request)
    {
        $validate = $request->validate([
            'name' => 'required|string',
            'email' => 'required|string|email|unique:drivers',
            'phone' => 'required|string|unique:drivers|min:11',
            'password' => 'required|string|confirmed|min:8'
        ]);

        $user = Driver::create([
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'password' => bcrypt($request->password)
        ]);

        $token = $user->createToken('TravelWin', ['driver'])->plainTextToken;

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

        if (!Auth::guard('driver')->attempt($credentials)) {
            return response()->json([
                'message' => 'Invalid credentials',
            ], 403);
        }

        $user = Auth::guard('driver')->user();
        $token = $user->createToken('TravelWin', ['driver'])->plainTextToken;

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
}
