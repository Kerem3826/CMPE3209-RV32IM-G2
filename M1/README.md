# CMPE3209 - Computer Organization Dönem Projesi
# RISC-V LCG Grade Distribution and Analysis
**CMPE3209 - Computer Organization / G2 - Sınav notu dağılımı / RV32IM** 

**Kerem Yılmaz - 5001240012**

Bu proje; C dilinde yazılmış rastgele sayı üretimi (LCG), bucket sıralama, ortalama hesabı ve baraj kontrolü algoritmalarının RISC-V assembly diline dönüştürülmesini ve **RARS 1.6** simülatöründeki bellek/yürütme analizlerini kapsamaktadır.



## 📁 Dosya Yapısı



* `G2.c` - Algoritmanın C dilindeki kaynak kütüphane kodu.

* `G2.s` - RARS 1.6 uyumlu bare-metal RISC-V assembly derleme çıktısı.

* `CMPE3209_5001240012_M1.pdf` - Deney raporu (Aşama 1 bellek haritası, adres analizleri ve grafikler).

* `CMPE3209_5001240012_M1.docx` - Deney raporunun .docx versiyonu

* `README.md` - Proje dokümantasyonu.



## 🛠️ Geliştirme ve Simülasyon Ortamı



* **Derleyici:** `RISC-V GCC 16.1.0 (riscv32-unknown-elf-gcc)`

* **Derleyici Parametreleri:** `-march=rv32im -mabi=ilp32 -O0 -mcmodel=medlow -std=c99`

* **Simülatör:** RARS 1.6 (RISC-V Assembler and Runtime Simulator)



## 🚀 Çalıştırma Adımları



1. RARS 1.6 simülatörünü açın ve `G2.s` dosyasını yükleyin.

2. Klavyeden **F3** (Assemble) tuşuna basarak kodu derleyin.

3. **F5** (Run) tuşuna basarak simülasyonu çalıştırın.

4. Program sonlandığında sonuçlar sol alttaki **Data Segment** penceresinden okunabilir.



## 📊 Özet Çıktılar ve Bellek Adresleri



|ㅤㅤDeğişkenㅤㅤ|ㅤㅤㅤㅤBellek Adresi (Hex)ㅤㅤㅤ|ㅤHesaplanan Değerㅤ|

|ㅤ:---ㅤㅤㅤㅤㅤㅤ|ㅤㅤㅤㅤㅤㅤㅤ:---ㅤㅤㅤㅤㅤㅤㅤ|ㅤㅤㅤㅤ:---ㅤㅤㅤㅤ|

|ㅤ`bucket\[0..4]`ㅤ|ㅤ`0x1001009C`ㅤ-ㅤ`0x100100AC`ㅤ|ㅤ`20, 3, 6, 2, 5`ㅤ|

|ㅤㅤㅤ`mean`ㅤㅤㅤ|ㅤㅤㅤㅤㅤ`0x100100B0`ㅤㅤㅤㅤㅤ|ㅤㅤㅤㅤ`47`ㅤㅤㅤㅤ|

|ㅤ`below\_count`ㅤ|ㅤㅤㅤㅤㅤ`0x100100B4`ㅤㅤㅤㅤㅤ|ㅤㅤㅤㅤ`19`ㅤㅤㅤㅤ|

|ㅤ`pass\_count`ㅤ|ㅤㅤㅤㅤㅤㅤ`0x100100B8`ㅤㅤㅤㅤㅤ|ㅤㅤㅤㅤ`16`ㅤㅤㅤㅤ|

\---

