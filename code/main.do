* ===================================================================
* STATA REPLICATION SCRIPT
* Project: The Impact of Digital Finance on Carbon Emissions
* Author: Jingyi Chen
* Thesis: Jiangnan University, 2024
* ===================================================================

* -------------------------------------------------------------------
* 1. SETUP AND DATA IMPORT
* -------------------------------------------------------------------

clear all

* Set the working directory to the /code/ folder
* cd "path/to/your/code/folder"

* Import data directly from the original Excel file
* This file ("分地区总数据指数.xlsx") should be in the /data/ folder
import excel "../data/分地区总数据指数.xlsx", sheet("Sheet1") firstrow

* -------------------------------------------------------------------
* 2. DATA PREPARATION
* -------------------------------------------------------------------

* Encode string variables 'province' and 'city' into numeric IDs
encode province, gen(province1)
encode city, gen(city1)

* Set the panel data structure: 'city1' is the individual ID, 'time' is the year
xtset city1 time

* -------------------------------------------------------------------
* 3. DESCRIPTIVE STATISTICS
* -------------------------------------------------------------------

* Summarize all variables used in the analysis
sum C FI GF TE ML IS OPEN UL GDP PD GOV ST

* Generate a pairwise correlation matrix with significance levels
pwcorr_a C FI GF TE ML IS OPEN UL GDP PD GOV ST, sig

* -------------------------------------------------------------------
* 4. MODEL SELECTION (FE vs. RE)
* -------------------------------------------------------------------
* These commands help decide between Fixed Effects (FE) and Random Effects (RE)

* Run Fixed Effects model
xtreg C FI OPEN UL GDP PD GOV ST, fe
* Run Random Effects model
xtreg C FI OPEN UL GDP PD GOV ST, re

* (Optional: `xttest0` is an older test for panel effects)
* xttest0 

* Store the FE and RE model results for comparison
xtreg C FI OPEN UL GDP PD GOV ST, fe
est store fe
xtreg C FI OPEN UL GDP PD GOV ST, re
est store re

* Run the Hausman test to compare FE and RE
* A significant p-value suggests FE is the appropriate model
hausman fe re

* (Optional: `xtoverid` is another test for FE vs. RE, often used after `re`)
* xtreg C FI OPEN UL GDP PD GOV ST, re
* xtoverid

* -------------------------------------------------------------------
* 5. BASELINE REGRESSION (Corresponds to Table 4-1)
* -------------------------------------------------------------------
* 'esttab' will be used to export these results into a single table

* Model 1: Simple OLS (bivariate)
reg C FI, r
est store m1

* Model 2: Two-Way Fixed Effects (TWFE)
* Using `xi:` and `i.city1` is an alternative way to run TWFE (same as `xtreg, fe`)
xi: reg C FI i.time i.city1, r
est store m2

* Models 3-7: Sequentially adding control variables
xi: reg C FI GDP i.time i.city1, r
est store m3
xi: reg C FI GOV i.time i.city1, r
est store m4
xi: reg C FI ST i.time i.city1, r
est store m5
xi: reg C FI GDP GOV i.time i.city1, r
est store m6
xi: reg C FI GDP GOV ST i.time i.city1, r
est store m7

* Model 8: Full model (Table 4-1, Column 3)
xi: reg C FI GDP GOV ST PD UL OPEN i.time i.city1, r
est store m8

* Export all 8 models to a .rtf (Word) file named "M基准回归.rtf"
esttab m1 m2 m3 m4 m5 m6 m7 m8 using M基准回归.rtf, nogap nocompress scalar(N F p) r2 ar2

* -------------------------------------------------------------------
* 6. HETEROGENEITY ANALYSIS (Corresponds to Table 4-2)
* -------------------------------------------------------------------
* This analysis splits the sample by region ('area' variable)
* 'area==1' is East, 'area==2' is Central, 'area==3' is West, 'area==4' is Northeast

* Run full model for Eastern region (area==1)
xtreg C FI OPEN UL GDP PD GOV ST i.time i.city1 if area==1, fe
est store y1

* Run full model for Central region (area==2)
xtreg C FI OPEN UL GDP PD GOV ST i.time i.city1 if area==2, fe
est store y2

* Run full model for Western region (area==3)
xtreg C FI OPEN UL GDP PD GOV ST i.time i.city1 if area==3, fe
est store y3

* Run full model for Northeastern region (area==4)
xtreg C FI OPEN UL GDP PD GOV ST i.time i.city1 if area==4, fe
est store y4

* Export the 4 regional models to a table
* `drop(*time* *city1*)` hides the many fixed effects coefficients
esttab y1 y2 y3 y4, nogap nocompress scalar(N F p) r2 ar2 replace drop(*time* *city1*) b(3)

* (Optional: Export the heterogeneity table to a Word file)
* logout , save(异质性) word replace: esttab y1 y2 y3 y4, nogap nocompress scalar(N F p) r2 ar2 replace drop(*time* *city1*) b(3)

* -------------------------------------------------------------------
* 7. ROBUSTNESS CHECK (Corresponds to Table 4-3, Col 1)
* -------------------------------------------------------------------
* Using lagged independent variable (L.FI) to address potential endogeneity

xtreg C l.FI OPEN UL GDP PD GOV ST i.time i.city1, fe

* ===================================================================
* END OF SCRIPT
* ===================================================================