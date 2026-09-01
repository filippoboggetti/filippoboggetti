# Market-risk models — MATLAB part of the group work

Group work for *Risk Management and Value in Banking and Insurance* (Bocconi MSc, spring 2023): parametric,
hybrid and liquidity-adjusted Value-at-Risk of an equal-weighted portfolio of three stocks (IBM, Philips,
Shell; EUR 100 in each), daily data 4 Jan 2016 – 10 Feb 2023. These files are the MATLAB part of the work.

| File | What it does |
|---|---|
| `Risk_finale.m` | Entry script: daily log returns from the price sheet, EWMA (λ = 0.94) volatilities via `EWMASTD`, correlation matrix, 1-day and 10-day 95 % parametric VaR per position and for the portfolio, histogram/normal fits, and an EM iteration for a Student-t location-scale fit of the returns |
| `Riuscito.m` | Stand-alone EM / ECME routine for the t location-scale fit of one return series (degrees of freedom from the digamma equation by bisection); expects `Returns` from the first block of `Risk_finale.m` |
| `EWMASTD.m` | `Y = EWMASTD(X, d, n_lags, cut)` — EWMA standard deviation with decay `d` |
| `bisectionMethod.m` | `c = bisectionMethod(f, a, b, error)` — bisection root finder |

**Data.** The input workbook is a Refinitiv Datastream extract (sheet `Parametric`: date and the three mid
prices, newest first; 1,797 daily rows). It is vendor-licensed and not redistributed: place a workbook with the
same layout next to the scripts as `Data.xlsx`. The EM block of `Risk_finale.m` also relies on variables created
interactively in the original MATLAB session (Distribution Fitter app); `Riuscito.m` is the self-contained version.
