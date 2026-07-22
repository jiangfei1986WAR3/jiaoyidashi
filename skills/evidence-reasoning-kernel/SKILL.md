---
name: evidence-reasoning-kernel
description: Perform domain-neutral, evidence-grounded analysis with high freedom of method while enforcing temporal integrity, observation-inference separation, competing hypotheses, falsification, scenario analysis, and calibrated uncertainty. Use for complex or ambiguous research, diagnosis, forecasting, decision support, contradictory evidence, or as an upstream reasoning layer before trading-analysis and other domain-specific skills. Trigger when the user asks for deep analysis, independent judgment, alternative explanations, evidence auditing, scenario probabilities, or protection against confirmation bias and overconfident conclusions.
---

# Evidence Reasoning Kernel

Produce the strongest defensible analysis the available evidence supports. Keep method selection open; constrain only epistemic integrity and downstream authority.

## Core Contract

1. Define the exact question, scope, decision horizon, and `as_of` time.
2. Inventory the available evidence before interpreting it. Label each material item as observation, derived fact, external claim, assumption, or unknown.
3. Check provenance, timestamp, completeness, measurement quality, selection bias, and possible leakage. Never use information that would not have been available at `as_of`.
4. Select analytical methods suited to the evidence. Do not force a named theory, indicator set, or predetermined conclusion.
5. Construct at least two plausible competing hypotheses when ambiguity exists. Include a baseline or null explanation where useful.
6. Evaluate each hypothesis against both supporting and contradicting evidence. State what observable result would weaken or falsify it.
7. Build conditional scenarios rather than presenting one future as certain. Identify drivers, signposts, consequences, and invalidation conditions.
8. Run an adversarial review for alternative causes, base-rate neglect, confounding, circular reasoning, false precision, and motivated interpretation.
9. Give the conclusion only at the resolution justified by the evidence. Return `INSUFFICIENT_EVIDENCE` when the evidence cannot distinguish the important hypotheses.
10. Report calibrated confidence and its limitations. Do not equate eloquence, model agreement, or analytical detail with predictive validity.

Read `references/analysis-contract.md` when performing a complex analysis, resolving contradictory evidence, or designing a prompt around this kernel.

## Output

Default to a concise, auditable Markdown report:

```text
Question and as-of time:
Bottom line:
Evidence status:
Observations and derived facts:
Unknowns and assumptions:
Competing hypotheses:
Scenario map:
Disconfirming evidence and invalidation:
Highest-information next observations:
Confidence and limitations:
```

Make the bottom line one of:

- `SUPPORTED`: one explanation is materially better supported.
- `LEANING`: evidence favors one explanation but important uncertainty remains.
- `UNRESOLVED`: live hypotheses remain difficult to separate.
- `INSUFFICIENT_EVIDENCE`: the requested conclusion exceeds the evidence.

Use `references/output-schema.md` when the result will be consumed by software, another skill, an evaluation harness, or NOFX. Do not expose private chain-of-thought. Provide evidence IDs, compact rationales, checks performed, and decision-relevant conclusions instead.

## Analytical Freedom

- Use quantitative, causal, statistical, historical, structural, adversarial, or qualitative methods as appropriate.
- Generate novel hypotheses when the evidence warrants them.
- Use tools to verify current facts, timestamps, calculations, and source claims when available.
- Change methods when new evidence makes the current frame unproductive.
- Preserve minority hypotheses that explain meaningful contradictory evidence.

Analytical freedom does not permit invented data, hidden hindsight, unsupported causal claims, or certainty beyond the evidence.

## Domain Handoff

Keep this skill upstream and domain-neutral. It may describe implications and scenarios, but it must not silently acquire downstream authority.

For trading tasks, read `references/trading-adapter.md`, then hand the evidence record to `trading-analysis`. Let `trade-execution-planner` define entries, stops, targets, and cancellation conditions; let `risk-manager` determine sizing and leverage risk. Never place orders or determine position size in this skill.

For other domains, hand off to the relevant domain skill after producing the evidence record. Preserve uncertainty and evidence IDs across the handoff.

## Quality Gate

Before finalizing, verify:

- Every major conclusion points to evidence or is labeled as an inference.
- No post-`as_of` information influenced the result.
- A serious alternative explanation was evaluated rather than mentioned ceremonially.
- Contradicting evidence and missing information remain visible.
- Scenario conditions and invalidations are observable.
- Confidence reflects discrimination between hypotheses, not writing quality.
- The output does not contain an action that belongs to a downstream execution or risk-control layer.
