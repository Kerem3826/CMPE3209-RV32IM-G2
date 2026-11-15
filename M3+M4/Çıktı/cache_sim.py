import pandas as pd
import matplotlib.pyplot as plt

# 1. trace.csv dosyasını oku
df = pd.read_csv("trace.csv")

def parse_addr(addr, line_size=16, num_sets=16):
    w_bits = line_size.bit_length() - 1
    s_bits = num_sets.bit_length() - 1
    word = addr & ((1 << w_bits) - 1)
    set_idx = (addr >> w_bits) & ((1 << s_bits) - 1)
    tag = addr >> (w_bits + s_bits)
    return tag, set_idx, word

def simulate_cache(trace_df, cache_size=256, line_size=16, assoc=1):
    num_lines = cache_size // line_size
    num_sets = num_lines // assoc
    sets = [
        [{"valid": False, "tag": None, "dirty": False, "lru": i} for i in range(assoc)]
        for _ in range(num_sets)
    ]
    hits = misses = wb_evictions = 0

    for _, row in trace_df.iterrows():
        addr = int(row["adres_hex"], 16)
        rw = row["RW"]
        tag, set_idx, _ = parse_addr(addr, line_size, num_sets)
        s = sets[set_idx]

        hit_way = next((i for i, w in enumerate(s) if w["valid"] and w["tag"] == tag), None)
        if hit_way is not None:
            hits += 1
            if rw == "W":
                s[hit_way]["dirty"] = True
            old_lru = s[hit_way]["lru"]
            for w in s:
                if w["lru"] < old_lru:
                    w["lru"] += 1
            s[hit_way]["lru"] = 0
        else:
            misses += 1
            victim_way = next((i for i, w in enumerate(s) if not w["valid"]), None)
            if victim_way is None:
                victim_way = max(range(assoc), key=lambda i: s[i]["lru"])
            victim = s[victim_way]
            if victim["valid"] and victim["dirty"]:
                wb_evictions += 1
            victim["valid"] = True
            victim["tag"] = tag
            victim["dirty"] = (rw == "W")
            old_lru = victim["lru"]
            for w in s:
                if w["lru"] < old_lru:
                    w["lru"] += 1
            victim["lru"] = 0

    total = len(trace_df)
    dirty_remaining = sum(1 for s in sets for w in s if w["valid"] and w["dirty"])
    return {
        "total": total,
        "hits": hits,
        "misses": misses,
        "H": hits / total,
        "wb_evictions": wb_evictions,
        "dirty_remaining": dirty_remaining,
    }

# Adım 4d: İlk 30 ve Tam İz Simülasyonu
res_30 = simulate_cache(df.iloc[:30], cache_size=256, line_size=16, assoc=1)
res_all = simulate_cache(df, cache_size=256, line_size=16, assoc=1)
print("4d İlk 30 :", res_30)
print("4d Tam İz :", res_all)

# Adım 4e: Tasarım Uzayı Deneyleri (Cache = 256 B sabit)
mappings = [("Direct\n(1-way)", 1), ("2-way\nSet-Assoc.", 2), ("4-way\nSet-Assoc.", 4), ("Fully Assoc.\n(16-way LRU)", 16)]
map_results = [simulate_cache(df, cache_size=256, line_size=16, assoc=a) for _, a in mappings]

line_sizes = [8, 16, 32, 64]
line_results = [simulate_cache(df, cache_size=256, line_size=ls, assoc=1) for ls in line_sizes]

# Grafik Çizimi -> cache_design_space_4e.png
fig, axes = plt.subplots(1, 2, figsize=(12, 4.8), dpi=160)
fig.patch.set_facecolor("white")

ax1 = axes[0]
x1 = [m[0] for m in mappings]
y1_h = [r["H"] * 100 for r in map_results]
y1_m = [r["misses"] for r in map_results]
bars1 = ax1.bar(x1, y1_h, color="#1f6f8b", width=0.52, edgecolor="#112629", linewidth=1)
ax1.set_ylim(95.0, 100.5)
ax1.set_ylabel("Hit Ratio H (%)", fontsize=10, fontweight="bold")
ax1.set_title("4e-1: Eşleme Türü Değişimi\n(Cache = 256 B, Line Boyu = 16 B Sabit)", fontsize=11, fontweight="bold", pad=10)
ax1.grid(axis="y", linestyle="--", alpha=0.45)
for bar, h_val, m_val in zip(bars1, y1_h, y1_m):
    ax1.text(bar.get_x() + bar.get_width()/2, h_val + 0.15, f"{h_val:.2f}%\n({m_val} miss)",
             ha="center", va="bottom", fontsize=8.5, fontweight="bold", color="#112629")

ax2 = axes[1]
x2 = [f"{ls} B\n({ls//4} word)" for ls in line_sizes]
y2_h = [r["H"] * 100 for r in line_results]
y2_m = [r["misses"] for r in line_results]
bars2 = ax2.bar(x2, y2_h, color="#2a9d8f", width=0.52, edgecolor="#112629", linewidth=1)
ax2.set_ylim(95.0, 100.5)
ax2.set_ylabel("Hit Ratio H (%)", fontsize=10, fontweight="bold")
ax2.set_title("4e-2: Line Boyu Değişimi\n(Cache = 256 B, Direct-Mapped Sabit)", fontsize=11, fontweight="bold", pad=10)
ax2.grid(axis="y", linestyle="--", alpha=0.45)
for bar, h_val, m_val in zip(bars2, y2_h, y2_m):
    ax2.text(bar.get_x() + bar.get_width()/2, h_val + 0.15, f"{h_val:.2f}%\n({m_val} miss)",
             ha="center", va="bottom", fontsize=8.5, fontweight="bold", color="#112629")

plt.suptitle("CMPE3209 Adım 4e — Önbellek Tasarım Uzayı Analizi (G2: 5001240012)", fontsize=12.5, fontweight="bold", y=1.02)
plt.tight_layout()
plt.savefig("cache_design_space_4e.png", bbox_inches="tight")