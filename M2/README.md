# CMPE3209 - Computer Organization Dönem Projesi

## RISC-V Assembly & Machine Code Analysis (Milestone 2 - M2)

**CMPE3209 - Computer Organization / G2 - Sınav notu dağılımı / RV32IM**

**Kerem Yılmaz - 5001240012**

Bu proje; C dilinde yazılmış rastgele sayı üretimi (LCG), bucket sıralama, ortalama hesabı ve baraj kontrolü algoritmalarının RISC-V assembly diline dönüştürülmesini, derleyici optimizasyon seviyelerinin (`-O0` vs `-O1`) karşılaştırılmasını, makine kollarının (Machine Code / Hex) elle kodlanmasını ve **RARS 1.6** simülatörü ile `objdump` üzerindeki yürütme/bellek analizlerini kapsamaktadır.

---

## 📁 Dosya Yapısı

* `G2_M2_3.c` - Algoritmanın C dilindeki kaynak kütüphane koda karşılık gelen dosyası.
* `G2_M2_3.s` - `-O0` derlemesi ile üretilmiş RARS 1.6 uyumlu bare-metal RISC-V assembly koda karşılık gelen dosya (`asm_O0.s`).
* `g2_o1_2.s` - Derleyici optimizasyonu uygulanmış `-O1` seviyesindeki assembly çıktısı (`asm_O1.s`).
* `objdumpdeneme.txt` - Makine kodlarının doğrulanması için alınan `objdump -d` ve RARS Text Segment dökümü.
* `CMPE3209_Proje_Teslim_Tutanagi_3.docx` - Proje M2 teslim tutanağı ve detaylı analiz belgesi.
* `README.md` - Proje M2 dokümantasyonu.

---

## 🛠️ Geliştirme ve Simülasyon Ortamı

* **Derleyici:** `RISC-V GCC 16.1.0 (riscv32-unknown-elf-gcc)`
* **Derleyici Parametreleri:** `-march=rv32im -mabi=ilp32 -O0 -mcmodel=medlow -std=c99`
* **Analiz Araçları:** `riscv64-unknown-elf-objdump`
* **Simülatör:** RARS 1.6 (RISC-V Assembler and Runtime Simulator), RARS Instruction Counter

---

## 🚀 Çalıştırma Adımları

1. RARS 1.6 simülatörünü açın ve `G2_M2_3.s` dosyasını yükleyin.
2. Klavyeden **F3** (Assemble) tuşuna basarak kodu derleyin.
3. **F5** (Run) tuşuna basarak simülasyonu çalıştırın.
4. Program sonlandığında sonuçlar sol alttaki **Data Segment** penceresinden okunabilir.

---

## 📊 Özet Çıktılar ve Bellek Adresleri

| Değişken | Bellek Adresi (Hex) | Hesaplanan Değer |
| :--- | :--- | :--- |
| `bucket[0..4]` | `0x100100A0` - `0x100100B0` | `20, 3, 6, 2, 5` |
| `mean` | `0x100100B4` | `47` |
| `below_count` | `0x100100B8` | `19` |
| `pass_count` | `0x100100BC` | `16` |

---

## ⚡ M2 Öne Çıkan Analizler

### 1. `-O0` ve `-O1` Optimizasyon Karşılaştırması (`passCheck` Kernel'i)

| Ölçüt | `-O0` | `-O1` | Farkın Nedeni |
| :--- | :---: | :---: | :--- |
| **Dinamik Komut Sayısı** | **15** | **3** | `-O1` derleyicisi gereksiz stack çerçevesini kaldırarak mantıksal kontrolü dallanmasız (`sltiu`, `seqz`) komutlara indirgemiştir. |
| **Bellek Erişimi (Load / Store)** | **3 / 3** | **0 / 0** | `-O0` parametreleri stack'e yazıp okurken, `-O1` işlemleri doğrudan `a0` yazmacında tamamlar. |
| **Kullanılan Register** | **6** | **2** | Derece farkı yazmaç tahsisi (register allocation) optimizasyonundan kaynaklanır (`a0`, `ra`). |

### 2. Makine Kodu Kodlaması & `objdump` Doğrulaması
* Proje kapsamında 10 farklı RISC-V komutu (U, I, S, B, J, R formatları) elle parçalanıp Little-Endian sıralamasına göre hex kodlarına dönüştürülmüş ve `objdump` çıktılarıyla **%100 uyumluluğu** doğrulanmıştır.
* `bltu` komutunun +12 byte offset hesabı ve 32-bit `SID = 1240012` sabiti için `lui` + `addi` sign-extension telafisi başarıyla hesaplanmıştır.