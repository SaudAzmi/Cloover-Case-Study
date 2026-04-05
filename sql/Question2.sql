WITH first_due AS (
    SELECT 
        contract_key,
        MIN(due_date) AS first_due_date
    FROM fct_invoice
    GROUP BY contract_key
),

first_payment AS (
    SELECT 
        fi.contract_key,
        MIN(pt.payment_date) AS first_payment_date
    FROM payment_transactions pt
    JOIN fct_invoice fi 
        ON pt.invoice_key = fi.invoice_key
    GROUP BY fi.contract_key
),

contract_delay AS (
    SELECT 
        dc.contract_id,
        di.installer_name,
        dcu.credit_score_band,
        fd.first_due_date,
        fp.first_payment_date,
        DATEDIFF(fp.first_payment_date, fd.first_due_date) AS days_to_first_payment
    FROM dim_contract dc
    JOIN first_due fd 
        ON dc.contract_key = fd.contract_key
    JOIN first_payment fp 
        ON dc.contract_key = fp.contract_key
    JOIN dim_installer di 
        ON dc.installer_key = di.installer_key
    JOIN dim_customer dcu 
        ON dc.customer_key = dcu.customer_key
)

SELECT *
FROM contract_delay
ORDER BY days_to_first_payment DESC
LIMIT 15;

