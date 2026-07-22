# Analysis Contract

Use this contract to preserve broad analytical freedom without sacrificing auditability.

## 1. Frame the problem

Record:

- The precise question or decision being supported.
- Scope, horizon, and `as_of` timestamp.
- What would count as a useful answer.
- Which conclusions are outside scope.

If the request embeds a conclusion, restate it as a testable question. Do not accept loaded premises without examination.

## 2. Build an evidence ledger

Assign an ID to each material evidence item and classify it:

- `observation`: directly present in the supplied or verified data.
- `derived`: calculated from observations with a reproducible transformation.
- `external_claim`: reported by a source but not independently observed here.
- `assumption`: temporarily accepted to continue analysis.
- `unknown`: decision-relevant information not available.

For each item, retain source or provenance, observation time, reliability, relevance, and limitations. Treat missingness as information only when the data-generation process supports that interpretation.

## 3. Protect temporal integrity

- Freeze the information set at `as_of` for retrospective tests.
- Reject future observations, revised labels, post-event summaries, and indicators calculated with future bars.
- Distinguish event time, publication time, ingestion time, and analysis time when delays matter.
- State when a source may have survivorship, selection, revision, or look-ahead bias.

## 4. Choose methods after inspecting evidence

Choose the minimum set of methods that can separate plausible explanations. Examples include quantitative comparison, causal diagrams, base rates, time-series analysis, anomaly detection, mechanism analysis, historical analogy, or qualitative source criticism.

Do not require a familiar framework merely because it is available. Named methods are tools, not conclusions.

## 5. Maintain competing hypotheses

When the problem is ambiguous:

1. Create two to four materially distinct hypotheses.
2. Include a baseline, random, measurement-error, or no-change hypothesis when plausible.
3. State the mechanism each hypothesis requires.
4. Link supporting and contradicting evidence by ID.
5. List predictions that differ between hypotheses.
6. Define observable weakening or falsification conditions.

Avoid fake alternatives that differ only in wording. Preserve a lower-weight hypothesis if it uniquely explains important contradictory evidence.

## 6. Distinguish relationships

Label important relationships as one of:

- descriptive association
- temporal precedence
- predictive relationship
- proposed causal mechanism
- verified causal effect

Do not promote correlation to causation without identification logic. Check reverse causality, confounders, common causes, and selection effects.

## 7. Construct scenarios

Scenarios are conditional branches, not promises. Each scenario should contain:

- required conditions and main drivers
- early signposts
- expected consequences
- invalidation condition
- likelihood as an ordinal label or probability range

Use numeric probabilities only when calibration, base rates, or an explicit estimation procedure make them defensible. If probabilities are used, make scenario definitions mutually exclusive enough for the values to be meaningful and ensure they sum coherently.

## 8. Adversarial review

Ask:

- What evidence would I emphasize if I preferred the opposite conclusion?
- Does the conclusion survive the strongest alternative mechanism?
- Is a base rate more informative than the case narrative?
- Could measurement, sampling, survivorship, or leakage create this pattern?
- Am I treating absence of evidence as evidence of absence?
- Did model consensus arise from shared prompts, training data, or assumptions rather than independent evidence?
- What result would make the current conclusion embarrassing in hindsight?

Revise the conclusion when the adversarial pass exposes a material weakness.

## 9. Calibrate confidence

Confidence measures how well the current evidence distinguishes the live hypotheses for this question. It is not a measure of intelligence or effort.

Use these anchors when a numeric score is requested:

- `0-20`: evidence is sparse, unreliable, or non-discriminating.
- `21-40`: a weak leaning with major unresolved alternatives.
- `41-60`: a meaningful leaning, but important failure modes remain.
- `61-80`: convergent evidence with limited serious alternatives.
- `81-95`: unusually strong, independently supported, and well-tested evidence.
- `96-100`: reserve for logical, definitional, or directly verified certainty; rarely appropriate for forecasts.

Always state confidence limitations. For forecasts, separate confidence in the analytical model from confidence in the outcome.

## 10. Stop conditions

Return `INSUFFICIENT_EVIDENCE` rather than forcing a judgment when:

- Key observations are unavailable or temporally invalid.
- Competing hypotheses make the same observable predictions.
- Source reliability is too low for the requested precision.
- The claimed effect is smaller than measurement uncertainty.
- The answer depends primarily on an unstated assumption.

Identify the highest-information next observation: the feasible piece of evidence most likely to separate the leading hypotheses.

## Prohibited shortcuts

- Do not invent missing values or sources.
- Do not hide contradictory evidence in a footnote.
- Do not use verbosity as a substitute for evidence.
- Do not request or reveal private chain-of-thought.
- Do not turn an analytical implication into an execution instruction without the relevant downstream skill and controls.
