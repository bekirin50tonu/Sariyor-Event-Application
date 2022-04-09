<?php

namespace App\Exceptions;

use App\Http\Helpers\Classes\CustomJsonResponse;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Illuminate\Validation\ValidationException;
use JetBrains\PhpStorm\ArrayShape;
use Throwable;

class Handler extends ExceptionHandler
{
    /**
     * A list of the exception types that are not reported.
     *
     * @var array<int, class-string<Throwable>>
     */
    protected $dontReport = [
        Throwable::class
    ];

    /**
     * A list of the inputs that are never flashed for validation exceptions.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    /**
     * Register the exception handling callbacks for the application.
     *
     * @return void
     */
    public function register()
    {
        $this->reportable(function (ModelDataNotFound $e){
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        });
        $this->reportable(function (NotOwnerException $e){
            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        });
        $this->reportable(function (Throwable $e) {
//            return new CustomJsonResponse(403, $e->getMessage(), $e->getTrace());
        });
    }

    protected function unauthenticated($request, AuthenticationException $exception): CustomJsonResponse|\Symfony\Component\HttpFoundation\Response|\Illuminate\Http\RedirectResponse
    {
        if ($request->expectsJson()) {
            return new CustomJsonResponse(401, 'Başarısız', ['Giriş Yapılmadı.']);
        }

        return redirect()->guest('login');
    }
    protected function invalidJson($request, ValidationException $exception)
    {
        if ($request->expectsJson()) {
            return new CustomJsonResponse(403, 'Başarısız', ['Geçersiz JSON Tipi.']);
        }
    }

    protected function renderExceptionResponse($request, Throwable $e)
    {
        if ($request->expectsJson()) {
            return new CustomJsonResponse(403, get_class($e), [$e->getMessage()]);
        }
    }
}
