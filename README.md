# Lex & Yacc Hesap Makinesi

## Proje Özeti

Bu projede, Lex ve Yacc kullanılarak ondalıklı sayı ve üstel işlem destekleyen bir hesap makinesi geliştirilmiştir. Program, kullanıcıdan alınan aritmetik ifadeleri tokenize edip gramer kurallarına göre yorumlayarak sonucu hesaplar. Çalışma sırasında hata yönetimi ve öncelik kuralları dikkate alınmıştır.

---

## Tasarım Kararları

- **FLOAT Desteği:** Sayılar `double` tipiyle temsil edilmiştir. Lex'te `atof()` ile dönüştürülüp `yylval.val`'e atanır. Bu sayede ondalıklı işlemler desteklenir.
- **Üstel İşlem (^) ve (**):** `^` ve `**`operatörleri`EXP`token'ı olarak tanımlanmıştır.`pow($1, $3)` fonksiyonu kullanılarak hesaplama yapılır.
- **Unary Minus (eksi üsler):** Negatif üsler ve `-5` gibi ifadeler için `-expr` kuralı `%prec UMINUS` ile tanımlanarak desteklenmiştir.
- **Operatör Önceliği:** Yacc’te `%left`, `%right` ve `%precedence` direktifleri ile matematiksel öncelik kuralları doğru şekilde uygulanmıştır.
- **Hata Yönetimi:**
  - `10 / 0` gibi ifadelerde özel kontrol ile `"Sıfıra bölme hatası!"` mesajı verilir.
  - Geçersiz karakterler Lex'te yakalanır (`Geçersiz karakter: &`)
  - Parantez veya yapı hatalarında tek satırlık `"Hata: Geçersiz ifade!"` mesajı gösterilir.
  - Her hata programı durdurmadan geçerli bir şekilde işlemeye devam eder.

---

## Derleme ve Çalıştırma

```bash
lex calculator.l
yacc -d calculator.y
gcc lex.yy.c y.tab.c -lm -o calculator
./calculator < test_cases.txt
```
