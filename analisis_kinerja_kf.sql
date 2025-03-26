---Perbandingan Pendapatan Kimia Farma dari tahun ke tahun
SELECT 
    EXTRACT(year from date) AS year,
    SUM(price * (1 - discount_percentage / 100)) AS total_revenue
FROM `rakaminkfanalytics-454405.kimia_farma.kf_final_transaction`
GROUP BY year
ORDER BY year

---Top 10 total produk dan jenis produk terjual
SELECT 
    p.product_category, 
    t.product_id, 
    COUNT(*) AS total_terjual
FROM `rakaminkfanalytics-454405.kimia_farma.kf_final_transaction` t
JOIN `rakaminkfanalytics-454405.kimia_farma.kf_product` p 
    ON t.product_id = p.product_id
GROUP BY p.product_category, t.product_id
ORDER BY total_terjual DESC
LIMIT 10;

---Top 10 Total transaksi cabang provinsi
SELECT 
    p.provinsi,  
    COUNT(*) AS total_terjual
FROM `rakaminkfanalytics-454405.kimia_farma.kf_final_transaction` t
JOIN `rakaminkfanalytics-454405.kimia_farma.kf_kantor_cabang` p 
ON t.branch_id = p.branch_id
GROUP BY p.provinsi
ORDER BY total_terjual DESC
LIMIT 10

---Top 10 Nett sales cabang provinsi
SELECT 
    p.provinsi,
    SUM(price - (price * discount_percentage)) AS net_sales
FROM `rakaminkfanalytics-454405.kimia_farma.kf_final_transaction` AS t
JOIN `rakaminkfanalytics-454405.kimia_farma.kf_kantor_cabang` AS p
ON p.branch_id = t.branch_id
GROUP BY p.provinsi
ORDER BY net_sales DESC
LIMIT 10;

---Top 5 Cabang Dengan Rating Tertinggi, namun Rating Transaksi Terendah
SELECT
    p.provinsi,
    MAX(p.rating) AS rating_cabang,
    MIN(t.rating) AS rating_transaksi,
FROM `rakaminkfanalytics-454405.kimia_farma.kf_final_transaction`t
JOIN `rakaminkfanalytics-454405.kimia_farma.kf_kantor_cabang`p
ON p.branch_id = t.branch_id
GROUP BY p.provinsi
ORDER BY rating_cabang DESC
LIMIT 5

---Persebaran produk yang tersedia di setiap provinsi
SELECT
    distinct(p.product_category),
    t.provinsi,
    t.rating
FROM `rakaminkfanalytics-454405.kimia_farma.kf_product` AS p
CROSS JOIN `rakaminkfanalytics-454405.kimia_farma.kf_kantor_cabang` AS t

---Indonesia's Geo Map Untuk Total Profit Masing-masing Provinsi
SELECT 
    p.provinsi,
    ROUND(SUM((t.price - (t.price * t.discount_percentage)) * 0.30),2) AS profit
FROM `rakaminkfanalytics-454405.kimia_farma.kf_final_transaction` AS t
JOIN `rakaminkfanalytics-454405.kimia_farma.kf_kantor_cabang` AS p
ON p.branch_id = t.branch_id
GROUP BY p.provinsi
ORDER BY profit DESC
LIMIT 10;

---Produk apa yang termasuk opname_stock
SELECT DISTINCT 
    p.date,
    t.product_id,
    t.product_name,
    t.opname_stock
FROM `rakaminkfanalytics-454405.kimia_farma.kf_inventory` AS t
JOIN `rakaminkfanalytics-454405.kimia_farma.kf_final_transaction` AS p
ON t.product_id = p.product_id
WHERE t.opname_stock <> 0
ORDER BY p.date DESC;

---total transaksi di indonesia
SELECT
    COUNT(transaction_id) as total_transaksi
FROM `rakaminkfanalytics-454405.kimia_farma.kf_final_transaction`

---total transaski di indonesia per tahun
SELECT
    EXTRACT(YEAR from date) as tahun,
    COUNT(transaction_id) as total_transaksi
FROM `rakaminkfanalytics-454405.kimia_farma.kf_final_transaction`
GROUP BY tahun
ORDER BY tahun ASC

---menenntukan top 10 pelanggan yang sering melakukan transaksi
SELECT 
  customer_name,
  count(transaction_id) as langganan
FROM `rakaminkfanalytics-454405.kimia_farma.kf_final_transaction` as t
GROUP BY customer_name
ORDER BY langganan DESC
LIMIT 10

