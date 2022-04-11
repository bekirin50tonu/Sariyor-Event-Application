<?php

namespace App\Http\Controllers\WEB\User;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Models\User;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function login(): \Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View|\Illuminate\Contracts\Foundation\Application
    {
        return view('admin.login');
    }

    public function loginPost(Request $request): \Illuminate\Routing\Redirector|\Illuminate\Contracts\Foundation\Application|\Illuminate\Http\RedirectResponse
    {
        try {
            $params = $request->all();
            unset($params['_token']);
            $rules = ['email' => ['exists:users', 'email']];
            $validator = Validator::make($params, $rules);
            if ($validator->fails()) return redirect()->back()->withErrors($validator);
            $user = User::query()->where('email', $request['email'])->first();
            Admin::query()->where('user_id', $user->id)->firstOrFail();
            if (!Hash::check($request['password'], $user->password)) return redirect()->back()->withErrors('Password is Wrong.');
            if (Auth::attempt($params)) return redirect()->route('admincategoryget');
            return redirect()->back()->withErrors('Something is Wrong.');
        } catch (ModelNotFoundException $e) {
            return redirect()->back()->withErrors('You Are Not A Admin.');
        } catch (ValidationException $e) {
            return redirect()->back()->withErrors($e->getMessage());
        }
    }

    public function logout(): \Illuminate\Http\RedirectResponse
    {
        Auth::logout();
        return redirect()->route('login.get');
    }
}
