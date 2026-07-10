---
name: trading-command-center
description: Orchestrate the user's crypto futures workflow by routing between market scanning, immediate-execution scanning, trade analysis, execution-plan generation, risk sizing, signal monitoring, position management, and trade review. Use when the user asks for a total trading assistant, command center, combined use of trading skills, what to do when flat or holding a position, which pair is closest to a signal, what can be entered now, how to turn a setup into entry/stop/take-profit/position size, how to monitor an executable plan, or how to coordinate binance-market-scanner, trading-analysis, trade-execution-planner, risk-manager, auto-signal-monitor, and trade-review.
---

# Trading Command Center

Use this skill as the workflow router for the user's crypto futures process. It coordinates these skills:

- `binance-market-scanner`: scan Binance USDT perpetual markets and save ranked results.
- `trading-analysis`: analyze trend, entry logic, stop/protection line, targets, holding, adding, reducing, and exit.
- `trade-execution-planner`: convert analysis into executable entry, stop, take-profit, risk, position size, monitor conditions, and order-parameter drafts.
- `risk-manager`: calculate position size, stop distance, leverage exposure, and liquidation-risk warnings.
- `auto-signal-monitor`: monitor public-market triggers from a complete trade plan.
- `trade-review`: review completed or in-progress trades and produce next-time rules.

Do not duplicate child-skill instructions. Load and use the relevant child skill when the workflow requires it.

## User Preference

The user prefers quality over speed for opportunity discovery. Unless the user explicitly asks for a quick scan, use a deeper Binance market scan with longer public-API timeouts, retries, and progress output. It is acceptable for scanning to take several minutes when it improves candidate quality.

## Safety

- Never log in, place orders, set stops, close positions, transfer funds, or operate accounts.
- Only use public market data unless the user manually provides account/position facts.
- Treat all outputs as decision support. The user must manually confirm and execute.
- If the user requests autonomous trading, refuse that prohibited action and continue with plan, monitor, or risk guidance.
- Do not let monitoring trigger a trade unless a complete execution plan already exists.

## State Router

First identify the user's state:

1. `FLAT`: no current position; user wants opportunities.
2. `PLANNING`: user is considering an entry, has a candidate pair, or wants executable prices.
3. `PLAN_READY`: entry, stop, targets, risk, and monitor conditions are defined.
4. `TRIGGERED`: a monitored plan has reached its trigger and needs revalidation.
5. `HOLDING`: user has an open position.
6. `EXITED`: trade is closed and user wants review.
7. `MONITORING`: user wants recurring or repeated watch logic.
8. `QUESTION`: user asks conceptual Skill/process questions.

If the state is unclear, infer from the message. Ask only when missing facts would make the answer unsafe.

## Core Pipeline

Use this as the default pipeline for new trades:

```text
scan or symbol request
-> trading-analysis
-> trade-execution-planner
-> risk-manager or plan_calculator when exact sizing is needed
-> auto-signal-monitor only when status is PLAN_READY
-> trigger revalidation
-> manual confirmation / command draft
-> trade-review after exit
```

The main rule: create a complete execution plan before monitoring or drafting exchange commands.

When the user explicitly asks what can be entered now, use the scanner's strict `--executable-now` mode first. This mode is optional and must not replace the default watchlist workflow.

## Workflows

### FLAT: Find A Trade Candidate

Use when the user has no position and asks what is worth watching.

1. Use `binance-market-scanner`.
   - Default to a quality-first scan, not a minimal fast scan.
   - If Binance public endpoints are slow, wait longer and rely on progress output before downgrading.
2. Summarize strongest long and short watchlists.
3. Apply market filter from BTC/ETH.
4. Pick at most 3 candidates:
   - closest confirmed setup
   - best pullback candidate
   - strongest risk warning or avoid candidate
5. For selected candidates, use `trading-analysis` to define trigger, protection line, and target zones.
6. Use `trade-execution-planner` for any candidate that could become actionable.
7. Output candidate status:
   - `WATCH_ONLY`: interesting but no concrete plan yet
   - `PLAN_READY`: can be monitored
   - `EXECUTABLE_NOW`: strict scanner layer says current price is still inside the executable entry band; revalidate with `trade-execution-planner` before any command draft
   - `WAIT_TRIGGER`: setup is valid enough to watch, but trigger has not occurred
   - `MISSED_ENTRY`: trigger happened, but price is no longer in the acceptable entry band
   - `NOT_EXECUTABLE`: invalid or missing required risk/price inputs

### FLAT: Find Immediately Executable Candidates

Use when the user has no position and asks what can be entered now, asks for direct entry candidates, or says not to return setups that only need waiting.

1. Use `binance-market-scanner` with `--executable-now`.
2. Lead with `EXECUTABLE_NOW` candidates only.
3. If there are no `EXECUTABLE_NOW` candidates, say that clearly and then list the closest `WAIT_TRIGGER` or `MISSED_ENTRY` candidates separately.
4. For each `EXECUTABLE_NOW` candidate, show:
   - side
   - entry band
   - protection / invalidation
   - target1 and reward/risk
   - stop distance
   - BTC/ETH market-filter note
   - cancellation condition
5. Use `trade-execution-planner` to revalidate the best candidate before command drafts, monitoring, or position sizing.
6. Do not auto-execute. Treat `EXECUTABLE_NOW` as manual-confirmation status, not an order instruction.

### PLANNING: Validate One Candidate

Use when the user names a symbol, entry idea, planned stop, or asks whether a signal can be entered.

1. Use `trading-analysis` for setup validity when levels are not already clear.
2. Use `trade-execution-planner` to convert the idea into:
   - entry trigger
   - stop / invalidation
   - TP1 / TP2
   - cancel condition
   - execution status
3. Use `risk-manager` or the execution planner calculator if entry, stop, equity, and risk are known.
4. If any required field is missing, mark the result `WATCH_ONLY` or `NOT_EXECUTABLE` and state what is missing.

### PLAN_READY: Prepare Monitoring

Use when a plan has concrete entry, stop, target, and risk fields.

1. Confirm the plan contains entry, stop, targets, invalidation, risk percent, and cancel condition.
2. Use `auto-signal-monitor` to monitor the exact entry trigger, invalidation, BTC/ETH filter, and expiration.
3. Keep the reminder explicit: monitoring is not automatic execution.
4. Do not create a monitor for vague analysis such as "breakout can watch" without concrete prices.

### TRIGGERED: Revalidate Before Execution

Use when a monitor fires or the user says a plan has triggered.

1. Recheck current price context, BTC/ETH filter, funding/OI, spread/liquidity if available, and whether the plan expired.
2. Use `trade-execution-planner` to update status:
   - `EXECUTABLE_AFTER_CONFIRMATION`
   - `INVALIDATED`
   - `EXPIRED`
   - `NOT_EXECUTABLE`
3. If still valid, provide order-parameter drafts or Binance Futures command drafts only when the user asks or they are useful.
4. Do not execute the command. Require explicit manual confirmation for any live-account action.

### HOLDING: Manage An Open Position

Use when the user has an open position or asks whether to hold, reduce, add, move stop, or exit.

1. Use `trading-analysis` first.
2. Use `risk-manager` if position size, entry, stop, leverage, liquidation price, or equity are provided.
3. Use `trade-execution-planner` only when converting a management decision into a concrete action plan:
   - move stop
   - reduce at TP
   - add only after original logic is further validated and current position is not losing
   - exit/reduce when protection line breaks
4. Do not give a single absolute order instruction. Give conditions and manual action choices.

### EXITED: Review The Trade

Use when the position is closed or the user asks what went wrong/right.

1. Use `trade-review`.
2. If needed, use `trading-analysis` to reconstruct market context.
3. Extract one or two concrete next-time rules.
4. If the issue was poor execution, update the next plan requirements: clearer entry, stop, TP, expiration, or risk limit.

### MONITORING: Set Or Update A Watch Process

Use when the user wants live watching or repeated reminders.

1. If no complete trade plan exists, use `trading-analysis` and `trade-execution-planner` first.
2. Create or update monitoring only for a `PLAN_READY` setup.
3. Use public data only.
4. If app automation tools are available and the user wants recurring checks, create/update the automation through the automation tool.
5. Keep reminders concise:
   - notify only when signal is near/triggered, invalidated, expired, or market-filter risk appears
   - otherwise keep status quiet

## Output Format

Answer in Chinese unless the user asks otherwise. Use this structure:

```text
Conclusion:
Current state:
Workflow used:
Key result:
Execution-plan status:
Next step:
Risk:
```

For flat users, lead with candidates. For planning users, lead with execution status and invalidation. For holding users, lead with hold/reduce/exit conditions.

## Reference

Read `references/routing.md` when refining workflow decisions or explaining why a child skill was selected.
