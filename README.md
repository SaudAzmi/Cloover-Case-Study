# Cloover —  Case Study

## Overview
Portfolio performance dashboard built in Qlik Cloud for Cloover's 
residential solar loan portfolio. Covers 3,000 contracts, 39,088 
invoices across Germany, Austria and the Netherlands.

## Deliverables
| Item | Location |
|---|---|
| SQL answers | /sql |
| Dashboard documentation | /documentation |
| Dashboard screenshots | /screenshots |
| Qlik .qvf file | Shared separately via email |

## Dashboard Sheets
1. **Portfolio Overview** — KPIs, financing mix, country summary
2. **Delinquency Breakdown** — DPD buckets, overdue exposure, 
   at-risk contracts
3. **Trend Over Time** — Monthly originations, delinquency rate trend
4. **Exposure by Dimension** — Region, installer, product, 
   credit band selector

## Key Technical Decisions
- DPD buckets created as a Master Dimension using Dual() for 
  sort order
- Aggr() used to evaluate principal and contract counts at 
  contract level, preventing double-counting across invoice rows
- Variable-driven dimension selector (vDimension) on Sheet 4 
  allows one chart to serve four dimensions
- Reference date: 2025-01-31 (hardcoded per case study spec)

## Data Model
Star schema — fct_invoice at centre joined to:
- dim_contract (via contract_key)
- dim_customer (via customer_key)  
- dim_installer (via installer_key)
- dim_date (via invoice_date_key, due_date_key, paid_date_key)

Note: Raw CSVs not included in this repo. 
Data provided by Cloover as part of the case study.

## Key Findings
- €56.67M total principal outstanding (Active + In Arrears)
- 89.7% collection rate — just below 90% threshold
- 90+ DPD bucket holds 86.3% of all overdue exposure (€906K)
- Fair + Poor credit bands drive 66% of overdue despite being 
  43% of the book
- 2,002 contracts (95% of active book) have at least one 
  invoice in 90+ DPD
