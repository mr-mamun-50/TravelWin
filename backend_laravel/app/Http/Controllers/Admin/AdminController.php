<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AdminController extends Controller
{
    //__Login user
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        $credentials = request(['email', 'password']);

        if (!Auth::guard('admin')->attempt($credentials)) {
            return response()->json([
                'message' => 'Invalid credentials',
            ], 403);
        }

        $user = Auth::guard('admin')->user();
        $token = $user->createToken('TravelWin', ['admin'])->plainTextToken;

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

    //__User details
    public function user()
    {
        return response()->json([
            'user'  => Auth::user(),
        ], 200);
    }
}
