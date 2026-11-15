\# CMPE3209 - Computer Organization Dönem Projesi



\## RISC-V Mimari, Önbellek ve Performans Analizi (Final Teslimi — Adım 0–5)



\*\*CMPE3209 - Computer Organization / G2 - Sınav notu dağılımı / RV32IM\*\*



\*\*Kerem Yılmaz - 5001240012\*\*



Bu proje; C dilinde yazılmış doğrusal eşlik üreteci (LCG) tabanlı sınav notu üretimi, aralık sınıflandırma (bucket), ortalama hesabı ve baraj kontrolü algoritmasının \*\*RV32IM\*\* mimarisi üzerinde uçtan uca bilgisayar organizasyonu analizini kapsamaktadır. Çalışma; C kaynak kodundan `-O0` ve `-O1` seviyesinde RISC-V assembly ve makine kodu (hex) üretimi, tek çevrimli (non-pipelined) CPU veri yolu ve kesme (interrupt) izlemesi, sistem veri yolu (bus) ve PCIe paket verimi hesabı, kişiye özel önbellek (cache) simülasyonu, tasarım uzayı deneyleri ile CPI, MIPS ve Amdahl Yasası performans değerlendirmelerini içermektedir.



\---



\## 📁 Dosya Yapısı



\* `main.c` - Algoritmanın temel C kaynak kodu (Adım 1.3).

\* `main\_v2.c` - Döngü birleştirme (loop fusion) ve yerel değişken optimizasyonu uygulanmış C kodu (Adım 4g).

\* `asm\_O0.s` - `-O0` derlemesi ile üretilmiş RARS 1.6 uyumlu RISC-V assembly çıktısı.

\* `asm\_O1.s` - `-O1` derleyici optimizasyonu uygulanmış RISC-V assembly çıktısı.

\* `objdump.txt` - Makine kodlarının doğrulanması için alınan `objdump -d` ve RARS Text Segment dökümü.

\* `trace.csv` - `-O0` yürütmesine ait 1460 satırlık bellek erişim (load/store) izi (`sira,RW,adres\_hex,boyut,c\_satiri,stack\_mi`).

\* `cache\_sim.py` - Önbellek isabet/ıska (hit/miss), write-back ve tasarım uzayı simülasyonu ile grafik üretimini gerçekleştiren Python betiği.

\* `cache\_design\_space\_4e.png` - Eşleme türü (Associativity) ve satır boyutu (Line Size) değişiminin hit oranına etkisini gösteren grafik.

\* `bucket.png`, `mean.png`, `below\_count.png`, `pass\_count.png` - RARS 1.6 Data Segment bellek çıktıları ve doğrulama ekran görüntüleri.

\* `CMPE3209\_5001240012\_Final.docx` / `.pdf` - Tüm adımları (Adım 0–5) kapsayan resmi Proje Teslim Tutanağı (düzenlenebilir ve PDF sürümleri).

\* `README.md` - Proje final dokümantasyonu.



\---



\## 🛠️ Geliştirme ve Simülasyon Ortamı



\* \*\*Derleyici:\*\* `RISC-V GCC 16.1.0 (riscv32-unknown-elf-gcc)`

\* \*\*Derleyici Parametreleri:\*\* `-march=rv32im -mabi=ilp32 -O0 / -O1 -mcmodel=medlow -std=c99`

\* \*\*Analiz Araçları:\*\* `riscv64-unknown-elf-objdump`, Python 3 (`pandas`, `matplotlib`)

\* \*\*Simülatörler:\*\* RARS 1.6 (RISC-V Assembler and Runtime Simulator), RARS Instruction Counter, RARS Data Cache Simulator



\---



\## 🚀 Çalıştırma Adımları



\### 1. RARS 1.6 Üzerinde Assembly Simülasyonu

1\. RARS 1.6 simülatörünü açın ve `asm\_O0.s` (veya `asm\_O1.s`) dosyasını yükleyin.

2\. Klavyeden \*\*F3\*\* (\*Assemble\*) tuşuna basarak kodu derleyin.

3\. \*\*F5\*\* (\*Run\*) tuşuna basarak simülasyonu çalıştırın.

4\. Program sonlandığında sonuçlar alt paneldeki \*\*Data Segment\*\* penceresinden (`0x10010000` taban adresi) okunabilir.



\### 2. Python ile Önbellek Simülasyonu ve Grafik Üretimi

1\. Terminalde `trace.csv` ve `cache\_sim.py` dosyalarının bulunduğu dizine geçin.

2\. `python cache\_sim.py` komutunu çalıştırın.

3\. Betik; ilk 30 referans ile tam izin (1460 referans) hit/miss istatistiklerini konsola yazdıracak ve `cache\_design\_space\_4e.png` grafiğini oluşturacaktır.



\---



\## 📊 Özet Çıktılar ve Bellek Adresleri



| Değişken | Bellek Adresi (Hex) | Hesaplanan Değer | Açıklama |

| :--- | :--- | :--- | :--- |

| `bucket\[0..4]` | `0x100100A0` – `0x100100B0` | `20, 3, 6, 2, 5` | 5 farklı not aralığındaki öğrenci dağılımı |

| `mean` | `0x100100B4` | `47` | 36 öğrencinin tam sayı not ortalaması (`1705 / 36`) |

| `below\_count` | `0x100100B8` | `19` | Ortalamanın altında kalan ve `0x100` ile işaretlenen not sayısı |

| `pass\_count` | `0x100100BC` | `16` | Geçme barajını (`P = 52`) sağlayan öğrenci sayısı |



\---



\## ⚡ Öne Çıkan Analizler (Adım 1–5)



\### 1. Derleyici Optimizasyonu ve Makine Kodu (Adım 2)



| Ölçüt (`passCheck` Kernel'i) | `-O0` | `-O1` | Farkın Nedeni |

| :--- | :---: | :---: | :--- |

| \*\*Komut Sayısı (Dinamik / Statik)\*\* | \*\*15 / 16\*\* | \*\*3 / 3\*\* | `-O1` derleyicisi stack çerçevesini kaldırarak kontrolü dallanmasız (`sltiu`, `seqz`, `ret`) komutlara indirgemiştir. |

| \*\*Bellek Erişimi (Load / Store)\*\* | \*\*3 / 3\*\* | \*\*0 / 0\*\* | `-O0` parametreleri stack'e yazıp okurken, `-O1` işlemleri doğrudan `a0` yazmacında tamamlar. |

| \*\*Kullanılan Register\*\* | \*\*6\*\* | \*\*2\*\* | Yazmaç tahsisi optimizasyonu ile yalnızca `a0` ve `ra` kullanılır. |



\* 10 farklı RISC-V komutu (`U`, `I`, `S`, `B`, `J`, `R` formatları) elle kodlanıp Little-Endian sıralamasıyla `objdump.txt` dökümüne karşı \*\*%100\*\* doğrulanmıştır.



\### 2. CPU Yürütme Döngüsü, Interrupt ve Bus Analizi (Adım 3)

\* \*\*Instruction Cycle \& Bus:\*\* `passCheck` kernel'inin ilk çağrısında (`arr\[0] = 82`) 15 dinamik komut yürütülmüş; 15 instruction fetch, 3 data read ve 3 data write olmak üzere toplam \*\*21 bus işlemi\*\* gerçekleşmiştir (16-bit data bus kullanılsaydı \*\*42 bus cycle\*\* gerekirdi).

\* \*\*Interrupt Senaryosu (`k = 4`, I/O):\*\* Kesme, kernel'in 4. dinamik komutu (`0x00400334: addi s0, sp, 32`) yürütülürken gelir; komut atomikliği korunarak tamamlandıktan sonra dönüş adresi `mepc = 0x00400338` ve kesme nedeni `mcause = 0x8000000B` kaydedilir.

\* \*\*PCIe TLP Verimi:\*\* 144 byte veri yükü için 12-byte header (ECRC yok) durumunda verim \*\*%87.80\*\* (`128b/130b` ile \*\*%86.45\*\*), 16-byte header (ECRC var) durumunda ise \*\*%83.72\*\* (`128b/130b` ile \*\*%82.43\*\*) olarak hesaplanmıştır.



\### 3. Önbellek Simülasyonu ve Kod Optimizasyonu (Adım 4)

\* \*\*Kişiye Özel Cache (`256 B / 16 B line / Direct-Mapped / Write-Back`):\*\* 1460 veri referansının (`1018 Load`, `442 Store`) \*\*1445\*\*'i isabet (hit), \*\*15\*\*'i zorunlu ıska (compulsory miss) ile sonuçlanmıştır (\*\*%98.97\*\* hit oranı). Çalışma kümesi önbelleğe sığdığı için çatışma ıskası (thrashing) oluşmamıştır.

\* \*\*Ortalama Erişim Süresi ($T\_s$):\*\* Cache olmadan `30 cycle` olan erişim süresi önbellek ile \*\*`1.3082 cycle`\*\* değerine düşerek \*\*22.93x\*\* bellek erişim hızlanması sağlamıştır.

\* \*\*Loop Fusion (`main\_v2.c`):\*\* İlk iki döngü birleştirilip tekrarlı dizi okumaları yerel değişkene alınarak toplam veri referansı `1460`'tan `1331`'e, toplam bellek erişim maliyeti ise `1910.0 cycle`'dan `1781.0 cycle`'a düşürülmüştür.



\### 4. Performans ve Paralelleştirme Özeti (Adım 5)



| Performans Ölçütü ($f = 1.2\\text{ GHz}$) | `-O0` | `-O1` | Karşılaştırma / Etki |

| :--- | :---: | :---: | :--- |

| \*\*Toplam Dinamik Komut ($I\_c$)\*\* | `4679` | `1272` | `%72.8` komut azalması |

| \*\*Ortalama CPI\*\* | `1.1120` | `1.3892` | `-O1`'de çarpma oranı arttığı için MIPS yanıltıcıdır (`1079.15` vs `863.84 MIPS`) |

| \*\*Yürütme Süresi ($T$, cache yok)\*\* | `40835.83 ns` | `5622.50 ns` | Önbellek kullanımı `-O0` süresini \*\*6.89x\*\* hızlandırır |

| \*\*Yürütme Süresi ($T$, cache var)\*\* | `5927.50 ns` | `1985.83 ns` | `-O1` optimizasyonu gerçek yürütme süresinde \*\*2.98x\*\* hızlanma sağlar |



\* \*\*Amdahl Yasası ($N\_c = 3$):\*\* LCG üreteci içeren 1. döngü veri bağımlılığı nedeniyle sıralı çalışırken, 2. ve 3. döngüler (`f = %50.39` yürütme payı) 3 çekirdeğe dağıtıldığında teorik hızlanma \*\*1.51x\*\* ($N\_c \\to \\infty$ limiti \*\*2.02x\*\*) olarak hesaplanmıştır.

