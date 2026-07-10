---
name: auto-signal-monitor
description: Convert crypto futures trade plans into recurring public-market signal monitors with concise text alerts, optional local beep/WAV/text-to-speech notifications, and manual-execution reminders. Use when the user wants to monitor Binance USDT perpetual pairs for breakout, pullback, invalidation, BTC/ETH market-filter, funding/OI, or volume conditions without logging in or placing orders.
---

# Auto Signal Monitor

Use this skill to turn a trading-analysis plan into a monitored signal checklist. This skill is for alerts only.

## Safety

- Use only public Binance market endpoints.
- Never log in, read account data, place orders, set stops, close positions, or operate funds.
- Treat all alerts as decision support. The user manually confirms and executes.
- If the user asks for automatic trading, decline execution and offer signal monitoring, paper trading, or bot design instead.

## Workflow

1. If no trade plan exists, use `trading-analysis` first to define:
   - symbol, direction, timeframe
   - breakout trigger
   - pullback/reclaim trigger
   - invalidation/protection line
   - BTC/ETH market filter
   - alert frequency and whether sound is wanted
2. Convert the plan into a JSON monitor plan. Use `references/plan-schema.md`.
3. For quick one-off checks, run `scripts/signal_monitor.py --plan <plan.json> --once`.
4. For repeated local monitoring with sound, prefer the directory supervisor: `scripts/signal_monitor.py --plans-dir <plans-dir> --loop --interval-seconds 60`.
5. Save each new pair setup as one `*.json` file in the plans directory. The supervisor auto-detects new files on the next loop and ignores `*.state.json`.
6. For Codex heartbeat monitoring, create/update an app heartbeat automation and include the same plan rules in its prompt. Heartbeats may not guarantee local sound; use the script for reliable audible alerts.
7. Alert only when a trigger, near-trigger, invalidation, or market-filter risk appears. Keep quiet status short.

## Alert Levels

- `DONT_NOTIFY`: no meaningful trigger.
- `WATCH`: near a trigger or setup forming; optional soft sound.
- `ALERT`: trigger/invalidation/risk-filter condition met; use sound or text-to-speech if enabled.

Use a cooldown to avoid repeated alerts when price hovers around a level.

## Script Usage

Create a plan file, then run:

```powershell
python "C:\Users\000\.codex\skills\auto-signal-monitor\scripts\signal_monitor.py" --plan "D:\Projects\codex1\signal-plans\uniusdt-plan.json" --once
```

Run one plan continuously with local sound:

```powershell
python "C:\Users\000\.codex\skills\auto-signal-monitor\scripts\signal_monitor.py" --plan "D:\Projects\codex1\signal-plans\uniusdt-plan.json" --loop --interval-seconds 60
```

Run the local supervisor for every plan in a directory:

```powershell
python "C:\Users\000\.codex\skills\auto-signal-monitor\scripts\signal_monitor.py" --plans-dir "D:\Projects\codex1\signal-plans" --loop --interval-seconds 60
```

## Output Rules

When reporting a monitor setup, include:

- monitored symbol and direction
- exact trigger levels
- invalidation/protection levels
- market-filter condition
- alert mode: text only, beep, WAV, or speech
- clear reminder: no automatic execution

When an alert fires, keep it concise:

```text
UNIUSDT ALERT: 15m volume breakout above 3.00; BTC/ETH filter acceptable. Decision support only; manually confirm execution.
```
