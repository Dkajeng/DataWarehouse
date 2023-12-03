-- RANK
SELECT dim_waktu.tahun, 
	   dim_waktu.bulan, 
       COUNT(*) as Total_Transaksi, 
       RANK() OVER (ORDER BY total_transaksi ASC) as rank_avg_transaksi
FROM fact_transaksi
INNER JOIN dim_waktu on dim_waktu.id_dim_waktu = fact_transaksi.id_dim_waktu
GROUP BY tahun, bulan
ORDER BY total_transaksi; 

-- DENSE RANK
SELECT dim_buku.judul_buku,
       fact_transaksi.keuntungan,
       DENSE_RANK() OVER (ORDER BY fact_transaksi.keuntungan DESC) AS dense_rank_keuntungan
FROM fact_transaksi
JOIN dim_buku ON fact_transaksi.id_dim_buku = dim_buku.id_dim_buku
GROUP BY dim_buku.judul_buku, fact_transaksi.keuntungan
ORDER BY dense_rank_keuntungan;

--ROLLUP
SELECT dim_waktu.tahun,
       dim_waktu.bulan,
       dim_nama_toko.nama_toko,
       SUM(fact_transaksi.keuntungan) AS total_pendapatan
FROM fact_transaksi
JOIN dim_nama_toko ON fact_transaksi.id_dim_nama_toko = dim_nama_toko.id_dim_nama_toko
JOIN dim_waktu ON fact_transaksi.id_dim_waktu = dim_waktu.id_dim_waktu
GROUP BY dim_waktu.tahun, dim_waktu.bulan, dim_nama_toko.nama_toko WITH ROLLUP;

-- GET TOTAL TRANSAKSI 
SELECT
COUNT(*) as "Total Transaksi", 
bulan 
FROM fact_transaksi
INNER JOIN dim_waktu on dim_waktu.id_dim_waktu = fact_transaksi.id_dim_waktu
GROUP BY bulan
ORDER BY
  CASE bulan
    WHEN 'January' THEN 1
    WHEN 'February' THEN 2
    WHEN 'March' THEN 3
    WHEN 'April' THEN 4
    WHEN 'May' THEN 5
    WHEN 'June' THEN 6
    WHEN 'July' THEN 7
    WHEN 'August' THEN 8
    WHEN 'September' THEN 9
    WHEN 'October' THEN 10
    WHEN 'November' THEN 11
    WHEN 'December' THEN 12
  END;

-- GET Jumlah Penjualan
SELECT 
	judul_buku, 
	concat(sum(stok), " buah") as "jumlah penjualan" 
FROM fact_transaksi
INNER JOIN 
dim_buku on dim_transaksi.id_dim_buku = dim_buku.id_dim_buku
GROUP BY judul_buku;


