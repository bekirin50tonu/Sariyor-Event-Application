<?php

namespace App\Exceptions;

use App\Http\Helpers\Classes\CustomJsonResponse;
use ErrorException;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Illuminate\Validation\ValidationException;
use Psy\Exception\FatalErrorException;
use Throwable;

class Handler extends ExceptionHandler
{
    /**
     * A list of the exception types that are not reported.
     *
     * @var array<int, class-string<Throwable>>
     */
    protected $dontReport = [
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

    }

    protected function unauthenticated($request, AuthenticationException $exception): CustomJsonResponse|\Symfony\Component\HttpFoundation\Response|\Illuminate\Http\RedirectResponse
    {
        if ($request->expectsJson()) {
            return new CustomJsonResponse(401, 'Başarısız', ['Giriş Yapılmadı.']);
        }

        return redirect()->guest('login.get');
    }

    protected function invalidJson($request, ValidationException $exception)
    {
        if ($request->expectsJson()) {
            return new CustomJsonResponse(403, 'Başarısız', ['Geçersiz JSON Tipi.']);
        }
    }

    protected function renderExceptionResponse($request, Throwable $e): \Illuminate\Http\Response|CustomJsonResponse|\Illuminate\Http\JsonResponse|\Symfony\Component\HttpFoundation\Response
    {
        if ($request->expectsJson()) {
            return new CustomJsonResponse(403, get_class($e), [$e->getMessage()]);
        }
        return parent::renderExceptionResponse($request, $e);
    }
}
