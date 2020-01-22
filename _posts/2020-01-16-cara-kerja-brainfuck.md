---
layout: post
title:  "Cara Kerja Brainfuck"
---

![Brainfuck](/assets/img/brainfuck.png)

Saya sudah mendengar Brainfuck sejak tahun 2011, ketika melihat [pertanyaan di CodeGolf](https://codegolf.stackexchange.com/questions/84/interpret-brainf), salah satu produk dari [StackOverflow](https://stackoverflow.com).

## Lalu apa itu Brainfuck?

> Bahasa pemrograman dibuat memiliki efisiensi yang selalu menjadi hal terpenting, tapi tidak untuk Brainfuck.

Brainfuck adalah bahasa pemrograman esoterik yang memiliki kode rumit dan memang sengaja dibuat rumit. Dibuat oleh Urban Müller, seorang mahasiswa fisika Swiss.

Brainfuck terkenal karena terlalu minimalis, hanya terdiri dari delapan perintah, yaitu `<`, `>`, `+`, `-`, `[`, `]`, `,` dan `.`.

## Cara kerja Brainfuck?

Delapan perintah yang ada di Brainfuck dibagi menjadi 4 bagian :

### Dasar

- `>` digunakan untuk memindahkan pointer ke kanan
- `<` digunakan untuk memindahkan pointer ke kiri
- `+` digunakan untuk menambahkan byte pada sel
- `-` digunakan untuk mengurangi byte pada sel

### Input

- `,` menerima input lalu menyimpan nilainya pada sel. Nilainya tergatung dari apa yang kita masukkan.

### Output

- `.` menampilkan byte pada sel terpilih

### Looping

- `[` awal
- `]` akhir

## Penggunaan

Dibawah ini adalah contoh program "Hello World!" pada Brainfuck.

```
++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.
```

Sebelum kita mulai, kita perlu membuat cantik perintah diatas agar mudah dipahami, menjadi :

```
1.  +++++ +++++
2.  [
3.     > +++++ ++
4.     > +++++ +++++
5.     > +++
6.     > +
7.     <<<< -
8.  ]
9.  > ++ .
10. > + .
11. +++++ ++ .
12. .
13. +++ .
14. > ++ .
15. << +++++ +++++ +++++ .
16. > .
17. +++ .
18. ----- - .
19. ----- --- .
20. > + .
```

### Pemahaman

Sebelum memulai, perlu diketahui bahwa nilai yang ada pada tiap-tiap sel merupakan [desimal ASCII](https://en.wikipedia.org/wiki/ASCII).

Pertama-tama kita akan membayangkan memiliki 5 sel seperti :

```
[0][0][0][0][0]
```

Kemudian, saya akan mengasumsikan mengenai posisi pointer yang terpilih dengan menggunakan `[*0*]` (nilai `0` dapat berubah).

```
// Pointer terpilih di sel 2, dengan nilai 0

[0][*0*][0][0][0]
```

---

## Mari kita mulai :smile:

Baris 1 adalah 10 kali `+`, akan menambahkan sel pertama dengan `10` byte.

```
1. ++++++++++

[*10*][0][0][0][0]
```

Baris 2 adalah looping dengan awalan `[` dan berakhir pada baris ke 8, yaitu `]`. Looping hanya merupakan putaran dari `[` hingga `]`. Looping tidak memiliki nilai, dan akan berhenti ketika nilai pada sel terpilih adalah `0`.

```
2. [

[*10*][0][0][0][0]

8. ]
```

Baris 3 berada dalam looping. `>` menandakan bahwa pointer maju selangkah ke kanan pada sel `2`, lalu `+` menambahkan byte pada sel yang terpilih oleh `>`.

```
3. > +++++ ++

[10][*7*][0][0][0]
```

Pada baris 4, tahapnya sama seperti yang sudah saya jelaskan sebelumnya.

```
4. > +++++ +++++

[10][7][*10*][0][0]
```

Pada baris 5, sudah mulai mengerti kan?

```
5. > +++

[10][7][10][*3*][0]
```

Pada baris 6, anda pasti sudah paham :smile:.

```
6. > +

[10][7][10][3][*1*]
```

Di baris 7, kita menemukan perintah 4 kali `<`. Artinya adalah, pindahkan pointer ke kiri 4 kali dan berada di sel pertama. Lalu `-` adalah mengurangi nilai pada sel terpilih.

```
7. <<<< -

[*9*][7][10][3][1]
```

Baris 8 memiliki `]` yang menandakan akhir putaran. Tapi, perlu diingat bahwa proses tidak akan berhenti hingga sel menjadi `0` oleh perintah terakhir iterasi.

```
8.  ]

[*9*][7][10][3][1]
```

Sampai titik ini, kita akan mengulangi proses yang sama dari baris `3` hingga `7`, sampai sel yang dimaksud menjadi `0`.

Jika sel yang dimaksud menjadi `0`, maka hasilnya adalah :

```
[*0*][70][100][30][10]
```

Kita akan melanjutkannya ke baris 9, yaitu `>` pindah pointer ke sel `2` lalu 2 kali `+` :

```
9. > ++ .

[0][*72*][100][30][10]
// H
```

Pada baris tersebut, memiliki perintah `.`. Artinya menampilkan hasil sel tersebut.

Pada [tabel ASCII](https://en.wikipedia.org/wiki/ASCII), nilai desimal `72` adalah `H`.

Pada beris berikutnya, sudah kita ketahui bahwa `>` mengarahkan ke sel `3` dan menambahkan byte, lalu menampilkan hasilnya, yaitu `e`.

```
10. > + .

[0][72][*101*][30][10]
// He
```

Baris selanjutnya, saya tidak perlu menjelaskan lagi, bahwa perintah tersebut adalah hal yang sama seperti perintah sebelumnya.

```
11. +++++ ++ .

[0][72][*108*][30][10]
// Hel
```

```
12. .

[0][72][*108*][30][10]
// Hell
```

```
13. +++ .

[0][72][*111*][30][10]
// Hello
```

Baris 14 menampilkan nilai `32` yang merupakan spasi.

```
14. > ++ .

[0][72][111][*32*][10]
// Hello
```

```
15. << +++++ +++++ +++++ .

[0][*87*][111][32][10]
// Hello W
```

```
16. > .

[0][87][*111*][32][10]
// Hello Wo
```

```
17. +++ .

[0][87][*114*][32][10]
// Hello Wor
```

```
18. ----- - .

[0][87][*108*][32][10]
// Hello Worl
```

```
19. ----- --- .

[0][87][*100*][32][10]
// Hello World
```

```
20. > + .

[0][87][100][*33*][10]
// Hello World!
```

Hasilnya menjadi `Hello World!`. Jadi, apa sudah pusing? :smile:


## Referensi

- [Wikipedia](https://en.wikipedia.org/wiki/Brainfuck)
- [Brainfuck: code that was designed to hurt](https://theoutline.com/post/825/brainfuck-coding-languages)
- [How does the Brainfuck Hello World actually work?](https://stackoverflow.com/a/19869651/984422)
- [Brainfuck Interpreter and Visualizer](http://fatiherikli.github.io/brainfuck-visualizer)
