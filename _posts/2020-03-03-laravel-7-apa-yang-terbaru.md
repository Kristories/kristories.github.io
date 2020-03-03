---
layout: post
title:  "Laravel 7, Apa yang Terbaru?"
---

Hari ini [Taylor](https://twitter.com/taylorotwell) telah merilis bersi mayor [Laravel 7](https://laravel.com/docs/7.x/), dan satya akan membahas beberapa fitur baru yang ada di Laravel versi terbaru.



#[Airlock](https://laravel.com/docs/7.x/airlock)

Jika kalian sering berhubungan dengan token API ataupun SPA (single page applications), selamat! Laravel kini telah memiliki paket resmi yang memiliki dua fitur, yaitu API Token dan otentikasi SPA.

### API Token

Terinspirasi oleh GitHub, Airlock dapat digunakan untuk membuat token API tanpa komplikasi OAuth. Token dapat dengan mudah dibuat dan dikelola oleh Airlock.

Fitur ini menyimpan token API pengguna dalam tabel database tunggal dan mengautentikasi permintaan masuk melalui otorisasi header yang pastinya diisi dengan token yang valid.

### Otentikasi SPA

Airlock juga menawarkan cara sederhana untuk otentikasi SPA yang berkomunikasi dengan API. SPA ini dapat digunakan bersama-sama pada aplikasi Laravel, ataupun yang dibuat terpisah.

Berbeda dengan API Token, otentikasi SPA tidak menggunakan token apa pun. Airlock menggunakan otentikasi bawaan Laravel, yang pastinya memiliki perlindungan CSRF, otentikasi sesi, serta melindungi terhadap kebocoran kredensial otentikasi melalui XSS. 



#[Custom Casts](https://laravel.com/docs/7.x/eloquent-mutators#custom-casts)

Siapa yang tidak menggunakan property `$casts`? Sejauh ini, casting banyak membantu untuk merubah tipe data. Pada Laravel 7, kini telah hadir Custom Cast yang dapat digunakan untuk membuat tipe data sendiri.

Custom Cast adalah sebuah class yang didalamnya memiliki metode `set` dan `get`, contohnya :

```php
<?php

namespace App\Casts;

use Illuminate\Contracts\Database\Eloquent\CastsAttributes;

class Json implements CastsAttributes
{
    public function get($model, $key, $value, $attributes)
    {
        return json_decode($value, true);
    }

    public function set($model, $key, $value, $attributes)
    {
        return json_encode($value);
    }
}
```

Setelah Custom Cast dibuat, selanjutnya kita dapat menggunakannya seperti :

```php
protected $casts = [
    'options' => Json::class,
];
```



#[Query Time Casting](https://laravel.com/docs/7.x/eloquent-mutators#query-time-casting)

Query Time Casting dapat digunakan untuk menerapkan cast saat menjalankan query, seperti saat memilih nilai mentah dari tabel, dengan contoh sebagai berikut :

```php
$users = User::select([
    'users.*',
    'last_posted_at' => Post::selectRaw('MAX(created_at)')
            ->whereColumn('user_id', 'users.id')
  ])
  ->withCasts(['last_posted_at' => 'date'])
  ->get();
```



#[Blade Component](https://laravel.com/docs/7.x/blade#components)

Pernah menggunakan **[Laravel Livewire](https://laravel-livewire.com/)** yang dibuat oleh **[Caleb Porzio](https://twitter.com/calebporzio)**? Atau pernah menggunakan **[Blade-X](https://docs.spatie.be/laravel-blade-x/v2/introduction/)** yang dibuat oleh **[Spatie](https://spatie.be/)**? Ya, Blade kini memiliki fitur Component yang mirip dengan Laravel Livewire dan Blade-X. 

**Components** dan **slots** telah dirombak ulang, untuk memungkinkan rendering berbasis tag, manajemen atribut, kelas komponen, komponen tampilan inline, dan lainnya. Component memiliki manfaat untuk membuat suatu komponen yang berhubungan dengan view. 

Sebagai contoh, kita dapat membuat suatu component dengan memanfaatkan Artisan :

```bash
php artisan make:component Alert
```

Command tersebut akan membuat component `Alert` pada `App\View\Components` beserta templatenya pada `resources/views/components`.

```php
<?php

namespace App\View\Components;

use Illuminate\View\Component;

class Alert extends Component
{
    public $type;
    public $message;

    public function __construct($type, $message)
    {
        $this->type = $type;
        $this->message = $message;
    }

    public function render()
    {
        return view('components.alert');
    }
}
```

Setelah mendaftarkan component dengan `Blade::component(AlertComponent::class, 'package-alert')`, kita dapat menggunakannya sebagai berikut :

```html
<x-package-alert/>
```



#[HTTP Client](https://laravel.com/docs/7.x/http-client)

HTTP Client adalah sebuah wrapper dari **[Guzzle](http://docs.guzzlephp.org/en/stable/)** yang memungkinkan membuat permintaan HTTP keluar untuk berkomunikasi dengan aplikasi web lainnya. Sebagai contoh :

```php
use Illuminate\Support\Facades\Http;

$response = Http::withHeaders([
    'X-First' => 'foo'
    'X-Second' => 'bar'
])->post('http://test.com/users', [
    'name' => 'Taylor',
]);

return $response['id'];
```



#[Fluent String](https://laravel.com/docs/7.x/helpers#fluent-strings)

Laravel 7 memiliki helper baru yaitu Fluent String yang berfungsi manipulasi string. Berbeda dengan `Str`, Fluent String memanipulasi string lebih object-oriented, seperti :

```php
Str::of('  Laravel Framework 6.x ')
  ->trim()
  ->replace('6.x', '7.x')
  ->slug();
```



#[Multiple Mail Drivers](https://laravel.com/docs/7.x/mail)

Seperti penggunaan beberapa driver database, kini Laravel 7 memungkinkan menggunakan beberapa driver mail pada satu aplikasi. 

Sebagai contoh, kita dapat menggunakan Mailgun untuk mengirim email transaksional, dan menggunakan Amazon SES untuk mengirim email massal.

```php
Mail::mailer('mailgun')
  ->to($request->user())
  ->send(new OrderShipped($order));
```



#[CORS](https://laravel.com/docs/7.x/routing#cors)

Laravel 7 dapat secara otomatis menanggapi permintaan CORS OPTIONS. Kita dapat mengatur konfigurasi `cors` pada config. Permintaan OPTIONS akan secara otomatis ditangani oleh middleware `HandleCors` yang sudah disertakan secara default di pada middleware global.



#Artisan `test` Command

![img](https://res.cloudinary.com/dtfbvvkyp/image/upload/v1582142435/Screen_Shot_2020-02-19_at_2.00.01_PM.png)

Selain `phpunit`, kita dapat menggunakan perintah Artisan `test` untuk menjalankan tes dengan UX dan informasi yang lebih baik mengenai tes yang sedang berjalan. 

```bash
php artisan test
```



#Stub Customization

`artisan make` dapat digunakan untuk membuat beberapa keperluan class seperti controller, migration, request, dan lainnya. Secara default akan menggunakan stub atau template bawaan Laravel. Jika kita ingin memembuat beberapa perubahan pada default stub yang telah ada, kita dapat merubahnya dengan mempublikasikan stub sebelumnya :

```bash
php artisan stub:publish
```



#[Queue `maxExceptions` Configuration](https://laravel.com/docs/7.x/queues)

Kini, kita dapat menentukan suatu `job` dapat dijalankan kembali (jika gagal) dengan mendefinisikan `maxExceptions` :

```php
<?php

namespace App\Jobs;

class ProcessPodcast implements ShouldQueue
{
    public $tries = 25;
    public $maxExceptions = 3;

    public function handle()
    {
        Redis::throttle('key')->allow(10)->every(60)->then(function () {
            // Lock obtained, process the podcast...
        }, function () {
            // Unable to obtain lock...
            return $this->release(10);
        });
    }
}
```





---





Ulasan diatas ada beberapa fitur baru yang ada pada Laravel 7. Tidak hanya fitur baru, improvisasi pada fitur sebelumnya juga telah disertakan pada Laravel 7, seperti Markdown Mail Template, MySQL 8+ Database Queue, dan lainnya. Informasi detail dapat dilihat pada [dokumentasi Laravel 7](https://laravel.com/docs/7.x).