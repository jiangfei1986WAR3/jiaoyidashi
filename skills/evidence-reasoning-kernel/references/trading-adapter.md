# Trading and NOFX Adapter

Use the kernel as an upstream market-reasoning layer. Do not let it replace trade construction, deterministic risk controls, or execution safeguards.

## Responsibility boundary

```text
market data and context
-> evidence-reasoning-kernel
-> trading-analysis
-> trade-execution-planner
-> risk-manager
-> auto-signal-monitor or manual execution
-> trade-review
```

The kernel may determine:

- What is directly observed and how reliable it is.
- Which market explanations remain plausible.
- Which scenarios, signposts, and invalidations follow from the evidence.
- Whether evidence supports a directional leaning or remains unresolved.

The kernel must not determine:

- Position size, leverage, or account risk.
- A final entry order, stop price, take-profit allocation, or exchange command.
- Whether an account should execute a trade.
- That a realistic narrative or generated price path has predictive value without validation.

## Trading handoff fields

Add these optional domain fields without removing the canonical evidence fields:

```json
{
  "market_context": {
    "symbol": "BTCUSDT",
    "timeframes": ["15m", "1h", "4h"],
    "as_of": "ISO-8601 timestamp",
    "regime_hypotheses": [],
    "directional_lean": "long | short | neutral | unresolved",
    "key_signposts": [],
    "market_invalidation_conditions": []
  },
  "handoff": {
    "recommended_skill": "trading-analysis",
    "permitted_use": "Interpret scenarios into conditional trade logic",
    "prohibited_use": "Do not infer order size, leverage, or permission to execute"
  }
}
```

Keep directional leaning separate from trade executability. A sound market hypothesis can still be a poor trade because entry location, liquidity, stop distance, reward/risk, funding, or account risk is unacceptable.

## NOFX prompt architecture

Codex Skills are not automatically loaded by a running NOFX container. To use this kernel in NOFX, translate it into an explicit prompt stage or API contract.

Prefer three layers:

1. `Reasoning layer`: Run the evidence contract with high method freedom and emit the canonical JSON.
2. `Decision compiler`: Convert scenarios into allowed trading actions and exact required fields.
3. `Risk and execution gate`: Enforce deterministic exposure, leverage, loss, cooldown, data-freshness, and order-validity rules outside the model.

If only one model call is possible, keep the sections separate inside the prompt and require separate JSON objects for `analysis` and `decision`. Apply hard risk checks in code after parsing the model output.

## Runtime inputs

Provide timestamps and provenance with every market input. Useful inputs may include:

- candles and timeframe
- mark and index price
- volume and taker flow
- open interest and its change
- funding rate and basis
- liquidation or order-book data when reliable
- BTC/ETH market context
- current positions and prior decisions in a clearly separate account-state block

Do not overload the prompt with every available indicator. Supply raw or minimally transformed evidence plus definitions. Let the reasoning layer select relevant methods, then measure whether its choices improve out-of-sample results.

## Evaluation before live use

Evaluate the complete pipeline, not persuasive sample outputs:

- Freeze prompts, model version, data schema, fees, slippage, and execution rules for each test.
- Use walk-forward or genuinely out-of-sample periods with strict timestamp integrity.
- Compare against simple baselines, the existing NOFX prompt, and ablations without the kernel.
- Measure return, drawdown, tail loss, turnover, fee sensitivity, stability across regimes, calibration, abstention quality, and invalidation behavior.
- Treat prompt changes as strategy changes that require revalidation.
- Prefer paper trading until the full decision and risk pipeline is stable.

The goal is not maximum trading activity. A valid improvement may appear as fewer unsupported trades, better-calibrated abstention, or faster recognition that a hypothesis has failed.
