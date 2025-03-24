# Lex & Yacc Hesap Makinesi

## 🔍 Proje Özeti

Bu projede, Lex ve Yacc kullanılarak hem **ondalıklı sayı** hem de **üs alma** destekleyen bir hesap makinesi geliştirildi. Kullanıcıdan alınan aritmetik ifadeler Lex ile tokenize edilir, Yacc ile gramer kurallarına göre ayrıştırılır ve sonuç hesaplanır.  
Proje, temel işlemlere ek olarak hata yönetimi, operatör önceliği ve bonus destekleriyle kapsamlı hale getirilmiştir.

---

## ⚙️ Tasarım Kararları

### 🔹 Tokenizasyon (Lex)

- **NUMBER:** Hem tam sayılar hem de ondalıklı sayılar desteklenir. `atof(yytext)` ile `yylval.val` atanır.
- **Operatörler ve Parantezler:** `+`, `-`, `*`, `/`, `^`, `**`, `(`, `)` gibi operatörler ayrı token'lar olarak tanımlanmıştır.
- **Boşluk Yönetimi:** Boşluk ve tab karakterleri göz ardı edilmiştir
- **Hatalı Karakterler:** Tanınmayan karakterler için `Geçersiz karakter: X` mesajı basılır.

### 🔹 Gramer Kuralları (Yacc)

- **Temel işlemler:** `expr + expr`, `expr - expr`, `expr * expr`, `expr / expr`, `( expr )`, `NUMBER` gramerine göre tanımlanmıştır.
- **Üstel işlem:** `^` ve `**` operatörleri `EXP` token'ına karşılık gelir. `pow($1, $3)` ile hesaplanır.
- **Unary minus:** `-5`, `2**-2` gibi ifadeler desteklenir. `%prec UMINUS` öncelik tanımıyla sağlanmıştır.
- **Operatör Önceliği:**
  - `%left PLUS MINUS`
  - `%left TIMES DIVIDE`
  - `%right EXP`
  - `%precedence UMINUS`
    ile öncelik sırası netleştirilmiştir.
- **Ambiguous grammar çözümü:** Grammar değiştirilmemiştir, ancak `%left`, `%right`, `%prec` ile yönlendirme sağlanmıştır

### 🔹 Hata Yönetimi

- **Sıfıra bölme:** `10 / 0` gibi durumlarda özel kontrolle `"Hata: Sıfıra bölme hatası!"` mesajı basılır.
- **Yapı hataları:** Eksik parantez veya yanlış yapı için `"Hata: Geçersiz ifade!"` basılır.
- **Geçersiz karakterler:** Lex seviyesi hatalar, kullanıcıya açıkça belirtilir.
- **Program durmaz:** Her hatada işlem devam eder, sonraki ifadeler çalıştırılır.

---

## Derleme ve Çalıştırma

```bash
lex calculator.l
yacc -d calculator.y
gcc lex.yy.c y.tab.c -lm -o calculator
./calculator < test_cases.txt
```
