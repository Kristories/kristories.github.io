---
layout: post
title:  "OAuth Bukan Passport"
---

Beberapa waktu lalu sempat melihat pertanyaan tentang perbedaan OAuth dan [Laravel Passport](https://laravel.com/docs/6.x/passpor) ataupun [Passport.js](http://www.passportjs.org) di StackOverflow. Ya memang tidak sedikit yang beranggapan bahwa dua hal tersebut adalah sama, begitupun beberapa teman di kantor.

Saya mencoba menjelaskan tentang kedua hal tersebut dengan menggunakan analogi kepada teman di kantor.

## Ini adalah masalah otentikasi dan otorisasi.

> Ketika kita datang ke kantor, maka kita menghampiri mesin absensi untuk absen kehadiran. Ini adalah **otentikasi**, bahwa kita adalah karyawan disini yang melakukan absensi kehadiran.

> Selanjutnya, kita akan masuk ke ruangan dimana tempat kita bekerja. Jika kita seorang akuntan, maka ruangan yang kita masuki adalah ruangan akuntan. Kita tidak dapat memasuki ruangan yang bukan berada di ranah kita, misalnya ruangan HRD. Ini adalah **otorisasi**, bahwa kita memiliki izin memasuki ruangan tempat kita bekerja.

Proses otorisasi berbeda dari proses otentikasi.

- Otentikasi adalah proses memverifikasi bahwa **"Anda adalah..."**
- Otorisasi adalah proses memverifikasi bahwa **"Anda diizinkan.."**.


## OAuth

**OAuth** adalah sebuah protokol otorisasi yang memberikan alur otorisasi khusus untuk aplikasi web, desktop, mobile, ataupun perangkat lainnya.

## Passport

**Passport** adalah middleware otentikasi yang menerapkan standar untuk mengimplementasikan apa yang menjadi kepatuhan pada OAuth.
