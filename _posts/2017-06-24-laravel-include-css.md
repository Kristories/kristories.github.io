---
layout: post
title:  "Laravel Include CSS"
---

Ketika berselancar di StackOverflow, saya melihat petanyaan ["Including a css file in a blade template?"](https://stackoverflow.com/q/45279612/984422). Seseorang berfikir bahwa `include` pada Blade sama halnya seperti pada native PHP.

```php
@include(public_path('css/styles.css'))
```

Sedangkan pada [dokumentasi Laravel](https://laravel.com/docs/5.4/blade), sudah dijelaskan bahwa :

> Blade's @include directive allows you to include a Blade view from within another view.

Dengan kata lain, `@include` hanya digunakan untuk mengambil sumber Blade view lain atau parsial. Juga, path yang digunakan adalah `resources/views`. Anda tidak dapat menggunakan direktori lain, kecuali mengaturnya pada config.

Untuk memuat aset, dapat dilakukan dengan berbagai cara, seperti dibawah ini.

## Asset

Laravel memiliki helper `asset()` yang menghasilkan path aset :

{% raw %}
```php
<link href="{{ asset('css/styles.css') }}" rel="stylesheet">
<script type="text/javascript" src="{{ asset('js/scripts.js') }}"></script>
```
{% endraw %}

Akan menghasilkan :

```html
<link href="http://domain.tld/css/styles.css" rel="stylesheet">
<script type="text/javascript" src="http://domain.tld/js/scripts.js"></script>
```

## Stack

Blade memiliki compiler bernama **Stack**, untuk menerapkan include pada berbagai kondisi.

### Memuat aset

Stack dapat digunakan untuk memuat aset seperti CSS dan JS, dengan cara :

```php
<!-- layout.blade.php -->
<html>
    <head>
        @stack('styles')
        @stack('scripts')
    </head>
    <body>
        @yield('content')
    </body>
</html>
```

Untuk memuat CSS atau JS dari sub-view menggunakan `@push()` :

{% raw %}
```php
<!-- home.blade.php -->
@push('styles')
<link href="{{ asset('css/styles.css') }}" rel="stylesheet">
@endpush

@push('scripts')
<script type="text/javascript" src="{{ asset('js/scripts.js') }}"></script>
@endpush
```
{% endraw %}

Akan menghasilkan :

{% raw %}
```php
<html>
    <head>
        <link href="http://domain.tld/css/styles.css" rel="stylesheet">
        <script type="text/javascript" src="http://domain.tld/js/scripts.js"></script>
    </head>
    <body>
        <!-- Content -->
    </body>
</html>
```
{% endraw %}

### Memuat beberapa kondisi aset

Stack dapat di deklarasikan seperti dibawah ini :

{% raw %}
```php
<!-- layout.blade.php -->
<html>
    <head>
        @stack('styles-before')
        <link href="{{ asset('css/main.css') }}" rel="stylesheet">
        @stack('styles-after')
    </head>
    <body>
        @yield('content')

        @stack('scripts-before')
        <script type="text/javascript" src="{{ asset('js/main.js') }}"></script>
        @stack('scripts-after')
    </body>
</html>
```
{% endraw %}

{% raw %}
```php
<!-- home.blade.php -->
@push('styles-before')
<link href="{{ asset('css/before.css') }}" rel="stylesheet">
@endpush

@push('styles-after')
<link href="{{ asset('css/after.css') }}" rel="stylesheet">
@endpush

@push('scripts-before')
<script type="text/javascript" src="{{ asset('js/before.js') }}"></script>
@endpush

@push('scripts-after')
<script type="text/javascript" src="{{ asset('js/after.js') }}"></script>
@endpush
```
{% endraw %}

Akan menghasilkan :

{% raw %}
```php
<html>
    <head>
        <link href="http://domain.tld/css/before.css" rel="stylesheet">
        <link href="http://domain.tld/css/main.css" rel="stylesheet">
        <link href="http://domain.tld/css/after.css" rel="stylesheet">
    </head>
    <body>
        <!-- Content -->

        <script type="text/javascript" src="http://domain.tld/js/before.js"></script>
        <script type="text/javascript" src="http://domain.tld/js/main.js"></script>
        <script type="text/javascript" src="http://domain.tld/js/after.js"></script>
    </body>
</html>
```
{% endraw %}


### Membuat sederhana tumpukkan kode

```php
<!-- layout.blade.php -->
<html>
    <head>
        @stack('styles')
        @stack('scripts')
    </head>
    <body>
        @yield('content')
        @stack('modals')
    </body>
</html>
```

{% raw %}
```php
<!-- home.blade.php -->

<ul>
@foreach($iems as $item)
    <li>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-{{ $item->id }}">
            Buka modal {{ $item->id }}
        </button>

        @push('modals')
        <div class="modal fade" id="modal-{{ $item->id }}" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">{{ $item->name }}</h5>
                    </div>
                    <div class="modal-body">
                        {{ $item->description }}
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        @endpush
    </li>
@endforeach
</ul>
```
{% endraw %}


Akan menghasilkan :

{% raw %}
```php
<html>
    <head>
        <link href="http://domain.tld/css/styles.css" rel="stylesheet">
        <script type="text/javascript" src="http://domain.tld/js/scripts.js"></script>
    </head>
    <body>
        <ul>
            <li>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-1">
                    Buka modal 1
                </button>
            </li>
            <li>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-2">
                    Buka modal 2
                </button>
            </li>
            <li>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-3">
                    Buka modal 3
                </button>
            </li>
        <ul>

        <div class="modal fade" id="modal-1" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Modal 1</h5>
                    </div>
                    <div class="modal-body">
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modal-2" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Modal 2</h5>
                    </div>
                    <div class="modal-body">
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modal-3" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Modal 3</h5>
                    </div>
                    <div class="modal-body">
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
```
{% endraw %}

















