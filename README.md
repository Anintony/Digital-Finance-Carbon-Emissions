# Digital-Finance-Carbon-Emissions
# The Impact of Digital Finance on Carbon Emissions: Empirical Evidence from Chinese Cities

This repository contains the replication package for my undergraduate thesis, "数字金融发展对碳减排的影响研究——基于地级市的经验证据" (Jiangnan University, 2024).

- **Author:** Jingyi(Jenny) Chen 
- **Link to Original Paper (Chinese):** [`/paper/数字金融发展对碳减排的影响研究.pdf`](./paper/数字金融发展对碳减排的影响研究.pdf)
- **Link to English Abstract:** [`/paper/abstract_en.pdf`](./paper/abstract_en.pdf)

---

## 1. Research Question

This study investigates whether the development of digital finance contributes to carbon emission reduction. It also explores the specific mechanisms through which this effect occurs.

## 2. Data & Methodology

- **Data:** A panel dataset covering 278 Chinese prefecture-level cities from 2011 to 2020.
- **Core Variables:**
    - **Dependent Variable (CL):** Carbon Emission Intensity (Carbon emissions per unit of GDP).
    - **Independent Variable (FI):** Digital Finance Index (Source: Peking University Digital Finance Research Center).
- **Methodology:**
    - **Main Model:** A Two-Way Fixed Effects (TWFE) panel data model to control for both time-invariant city characteristics (individual effects) and common year-specific shocks (time effects).
    - **Mediation Analysis:** To test the mechanisms (Green Finance, Technological Innovation, etc.) through which digital finance impacts emissions.

## 3. Key Findings

I find a statistically significant inhibiting effect of digital finance development on carbon emissions. The mechanisms analysis shows that digital finance promotes:
- Green Financial Development (GF)
- Technological Innovation (TE)
- Industrial Structure Upgrading (IS)
- Marketization (ML)

### Baseline Regression Results (Corresponds to Table 4-1)

| Variable | (1) OLS | (2) TWFE | (3) TWFE w/ Controls |
| :--- | :---: | :---: | :---: |
| **Digital Finance (FI)** | **-0.378*** | **-0.277*** | **-0.142*** |
| | (-15.487) | (-3.753) | (-1.871) |
| Controls | No | No | Yes |
| Time FE | No | Yes | Yes |
| City FE | No | Yes | Yes |
| N | 2780 | 2780 | 2760 |
| Adj. R-sq | 0.077 | 0.911 | 0.939 |

*Notes: t-statistics in parentheses. *** p<0.01, ** p<0.05, * p<0.1.*

## 4. How to Replicate

1.  **Data:** The core dataset is the Excel file 分地区总数据指数.xlsx, located in the /data/ folder.
2.  **Code:** The main analysis is conducted in `main.do`, located in the /code/ folder. This script imports the Excel file , prepares the data, and runs all regressions.
3.  **Software:** Stata 16 .

## 5. Repository Structure

```
.
├── /code/
│   └── main.do                # Main Stata script for all regressions
├── /data/
│   └── 分地区总数据指数.xlsx      # The single raw dataset (Excel file)
├── /paper/
│   ├── 数字金融发展对碳减排的影响研究.pdf  # Original thesis (Chinese) 
│   └── abstract_en.pdf     # English abstract
└── README.md               # This file
```
