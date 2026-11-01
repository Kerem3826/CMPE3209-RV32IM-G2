\*\*CMPE3209 - Computer Organization\*\*
\*\*Kerem Yılmaz - 5001240012\*\*
\*\*G2 - Sınav notu dağılımı\*\*

\*\*RV32IM\*\*

# RISC-V LCG \& Grade Distribution and Analysis




Bu proje; C dilinde yazılmış rastgele sayı üretimi (LCG), bucket sıralama, ortalama hesabı ve baraj kontrolü algoritmalarının RISC-V assembly diline dönüştürülmesini ve \*\*RARS 1.6\*\* simülatöründeki bellek/yürütme analizlerini kapsamaktadır.



\## 📁 Dosya Yapısı



\* `G2.c` - Algoritmanın C dilindeki kaynak kütüphane kodu.

\* `G2.s` - RARS 1.6 uyumlu bare-metal RISC-V assembly derleme çıktısı.

\* `CMPE3209\_5001240012\_M1.pdf` - Deney raporu (Aşama 1 bellek haritası, adres analizleri ve grafikler).
\* `CMPE3209\_5001240012\_M1.docx` - Deney raporunun .docx versiyonu

\* `README.md` - Proje dokümantasyonu.



\## 🛠️ Geliştirme ve Simülasyon Ortamı



\* \*\*Derleyici:\*\* `RISC-V GCC 16.1.0 (riscv32-unknown-elf-gcc)`

\* \*\*Derleyici Parametreleri:\*\* `-march=rv32im -mabi=ilp32 -O0 -mcmodel=medlow -std=c99`

\* \*\*Simülatör:\*\* RARS 1.6 (RISC-V Assembler and Runtime Simulator)



\## 🚀 Çalıştırma Adımları



1\. RARS 1.6 simülatörünü açın ve `G2.s` dosyasını yükleyin.

2\. Klavyeden \*\*F3\*\* (Assemble) tuşuna basarak kodu derleyin.

3\. \*\*F5\*\* (Run) tuşuna basarak simülasyonu çalıştırın.

4\. Program sonlandığında sonuçlar sol alttaki \*\*Data Segment\*\* penceresinden okunabilir.



\## 📊 Özet Çıktılar ve Bellek Adresleri



|    Değişken    |     Bellek Adresi (Hex)     | Hesaplanan Değer |

| :---           |            :---             |       :---       |

| `bucket\[0..4]` | `0x1001009C` - `0x100100AC` | `20, 3, 6, 2, 5` |

| `mean`         |         `0x100100B0`        |       `47`       |

| `below\_count`  |         `0x100100B4`        |       `19`       |

| `pass\_count`   |         `0x100100B8`        |       `16`       |

\---

