WITH split_invoices AS (
    SELECT 
        invoice_key,
        COUNT(*) AS payment_count,
        SUM(amount) AS total_paid
    FROM payment_transactions
    GROUP BY invoice_key
    HAVING COUNT(*) > 1
)

SELECT 
    dc.contract_id,
    COUNT(DISTINCT fi.invoice_key) AS total_invoices,
    COUNT(DISTINCT si.invoice_key) AS split_invoice_count,
    SUM(si.total_paid) AS total_split_amount
FROM dim_contract dc
JOIN fct_invoice fi 
    ON dc.contract_key = fi.contract_key
LEFT JOIN split_invoices si 
    ON fi.invoice_key = si.invoice_key
GROUP BY dc.contract_id
HAVING COUNT(DISTINCT si.invoice_key) > 0
ORDER BY split_invoice_count DESC;

