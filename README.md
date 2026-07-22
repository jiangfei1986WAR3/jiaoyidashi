# Trading Codex System

Private backup of the Codex trading skill system.

This repository contains the reusable skill layer for evidence-grounded market
reasoning, Binance USDT perpetual futures analysis, scanning, execution planning,
risk sizing, signal monitoring, and trade review.

## Contents

- `skills/evidence-reasoning-kernel`: upstream evidence audit, competing-hypothesis, scenario, and calibrated-confidence layer.
- `skills/trading-command-center`: workflow router for scans, plans, monitoring, and reviews.
- `skills/binance-market-scanner`: public Binance USDT perpetual scanner.
- `skills/trading-analysis`: trading framework, source references, entry/exit and volume-price rules.
- `skills/trade-execution-planner`: converts analysis into entry, stop, TP, cancel, and order-parameter drafts.
- `skills/risk-manager`: position size, stop distance, leverage and liquidation-risk estimates.
- `skills/auto-signal-monitor`: public-market trigger and invalidation monitor.
- `skills/trade-review`: review framework for completed or active trades.
- `examples/market-scans`: small sample scan outputs for format reference only.
- `restore`: scripts for restoring skills on a new machine.

## Restore On Windows

From the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\restore\restore-windows.ps1
```

This copies `skills/*` into:

```text
$env:USERPROFILE\.codex\skills
```

## Restore On Linux Or Server

From the repository root:

```bash
bash ./restore/restore-linux.sh
```

This copies `skills/*` into:

```text
~/.codex/skills
```

## After Restore

Ask Codex to verify the restored system:

```text
Please inspect ~/.codex/skills and verify the trading skills were restored.
Update any hard-coded local paths for this machine.
```

Known paths that may need adjustment after moving machines:

- `D:\Projects\codex1\market-scans`
- `D:\Projects\codex1\signal-plans`
- `C:\Users\000\.codex\skills\...`

## Safety Notes

- This repository should stay private.
- Do not commit exchange API keys, account screenshots, live position snapshots,
  wallet files, or personal credentials.
- The included scripts use public market data only and do not place orders.
- All trade outputs are decision support for manual execution.
