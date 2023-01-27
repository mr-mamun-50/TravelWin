<?php

use App\Http\Controllers\Admin\AdminController;
use App\Http\Controllers\Driver\DriverController;
use App\Http\Controllers\Guide\GuideController;
use App\Http\Controllers\Hotel\HotelController;
use App\Http\Controllers\TouristSpots\TouristSpotsController;
use App\Http\Controllers\User\GetAllTouristController;
use App\Http\Controllers\User\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });



/*
|--------------------------------------------------------------------------
| User Routes
|--------------------------------------------------------------------------
*/

Route::post('/user/login', [UserController::class, 'login']);
Route::post('/user/register', [UserController::class, 'register']);

Route::group(['middleware' => ['auth:sanctum']], function () {

    Route::post('/user/logout', [UserController::class, 'logout']);
    Route::get('/user', [UserController::class, 'user']);
    Route::get('/user/all_tourist_guides', [GetAllTouristController::class, 'getAllTourist']);
});
Route::resource('/user/tourist_spots', TouristSpotsController::class);



/*
|--------------------------------------------------------------------------
| Admin Routes
|--------------------------------------------------------------------------
*/

Route::post('/admin/login', [AdminController::class, 'login']);

Route::group(['middleware' => ['auth:sanctum', 'abilities:admin']], function () {

    Route::post('/admin/logout', [AdminController::class, 'logout']);
    Route::get('/admin/user', [AdminController::class, 'user']);
});



/*
|--------------------------------------------------------------------------
| Tourist tourist_guide Routes
|--------------------------------------------------------------------------
*/

Route::post('/tourist_guide/login', [GuideController::class, 'login']);
Route::post('/tourist_guide/register', [GuideController::class, 'register']);

Route::group(['middleware' => ['auth:sanctum', 'abilities:tourist_guide']], function () {

    Route::post('/tourist_guide/logout', [GuideController::class, 'logout']);
    Route::get('/tourist_guide/user', [GuideController::class, 'user']);
    Route::put('/tourist_guide/update', [GuideController::class, 'updateProfile']);
    Route::put('/tourist_guide/update/service_area', [GuideController::class, 'updateServiceArea']);
});



/*
|--------------------------------------------------------------------------
| Hotel Routes
|--------------------------------------------------------------------------
*/

Route::post('/hotel/login', [HotelController::class, 'login']);
Route::post('/hotel/register', [HotelController::class, 'register']);

Route::group(['middleware' => ['auth:sanctum', 'abilities:hotel']], function () {

    Route::post('/hotel/logout', [HotelController::class, 'logout']);
    Route::get('/hotel/user', [HotelController::class, 'user']);
    Route::put('/hotel/update', [HotelController::class, 'updateProfile']);
    Route::put('/hotel/update/address', [HotelController::class, 'updateAddress']);
});



/*
|--------------------------------------------------------------------------
| Driver Routes
|--------------------------------------------------------------------------
*/

Route::post('/driver/login', [DriverController::class, 'login']);
Route::post('/driver/register', [DriverController::class, 'register']);

Route::group(['middleware' => ['auth:sanctum', 'abilities:driver']], function () {

    Route::post('/driver/logout', [DriverController::class, 'logout']);
    Route::get('/driver/user', [DriverController::class, 'user']);
});


// php artisan serve --host 192.168.42.113 --port 8000
// php artisan serve --host 192.168.137.71 --port 8000
// php artisan serve --host 10.100.111.34 --port 8000
