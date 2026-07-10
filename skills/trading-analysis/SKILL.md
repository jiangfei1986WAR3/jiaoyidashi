---
name: trading-analysis
description: Analyze cryptocurrency futures and Binance trading pairs using the user's trading documents. Use when the user asks about crypto futures trend, support/resistance, entry, exit, stop loss, take profit, holding, adding/reducing position, liquidation risk, leverage risk, volume-price behavior, market sentiment, funding/OI crowding, or trading pair selection.
---

# Trading Analysis

Use the user's trading framework as a decision aid for crypto futures analysis. Treat all conclusions as probabilistic trade planning, not guaranteed prediction or financial advice.

## Reference Routing

Read only the relevant reference files for the user's question:

- `references/crypto-futures-system.md`: Use for the full crypto perpetual futures framework, market cycle, trading pair screening, entry modes, holding rules, adding/reducing position, exits, risk control, scoring, alerts, and daily checklist.
- `references/entry-exit-position-management.md`: Use for concrete rules on entry, holding, protection lines, adding, reducing, exiting, leader/follower selection, and translating A-share short-term logic to crypto contracts.
- `references/volume-price-analysis.md`: Use for volume-price interpretation, high/low position context, divergence, shrinking volume, expanding volume, intraday execution confirmation, washout, distribution, and warning signals.
- `references/source.pdf`: Keep as the original source material. Prefer the Markdown references first; inspect the PDF only when the Markdown files are insufficient or the user explicitly asks about the original source.

## Analysis Workflow

When analyzing a live pair or position:

1. Identify the task type: trend analysis, entry setup, holding decision, stop loss, take profit, add/reduce position, exit, or trading pair selection.
2. Read the relevant reference file(s) based on Reference Routing.
3. Gather current observable facts when available: price, mark price, entry price, liquidation price, leverage, PnL, timeframe, recent high/low, volume, MA/EMA, RSI/MACD if visible, funding rate, OI, order book, and BTC/ETH market context.
4. Separate the response into observed facts, framework interpretation, actionable scenarios, and risk controls.
5. Prefer protection-line logic over prediction: define what condition allows continued holding and what condition invalidates the trade.
6. For leveraged positions, prioritize capital preservation, liquidation distance, and profit protection over maximizing theoretical upside.

## Core Rules

- First judge market environment, then the trading pair, then the entry/holding/exit condition.
- Treat volume-price signals as context-dependent. The same volume pattern can mean continuation or distribution depending on position, trend, and market sentiment.
- For long positions, continued holding generally requires price above the protection line, healthy pullback behavior, no clear high-volume stagnation, and no obvious market-cycle deterioration.
- For short positions, continued holding generally requires price below the rebound pressure/protection line, weak rebound behavior, and no obvious reversal volume.
- Do not average down losing futures positions as a default response. Adding is allowed only when the original logic has been further validated.
- When profit reaches a meaningful multiple of initial risk, consider partial reduction and move the protection line into profitable territory.
- If price breaks the protection line, treat the original trade logic as damaged. Prefer exit or reduction over emotional holding.
- For follower or catch-up coins, use faster profit-taking and stricter invalidation than for clear leaders.

## Output Style

For trading analysis, answer in this structure unless the user asks for something shorter:

```text
结论：
事实：
按你的文档框架：
关键位置：
操作场景：
风险提醒：
```

When giving stop-loss or protection-line suggestions, provide a range and one practical reference price, plus the reasoning and tradeoff. Avoid claiming that a price is certain to hold.

When the user asks whether to hold or close, do not make a single absolute decision for the user. Give a risk-based preference such as "更偏向先减仓保护利润" or "继续持有的条件是..." and define invalidation levels.
