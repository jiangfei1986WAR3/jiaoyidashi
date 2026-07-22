# Output Schema

Use the Markdown format in `SKILL.md` for normal user-facing work. Use this JSON contract for machine handoff, evaluation, or prompt integration.

## Canonical JSON

```json
{
  "schema_version": "1.0",
  "analysis_id": "unique-id",
  "question": "The exact question being analyzed",
  "scope": "Included and excluded scope",
  "as_of": "ISO-8601 timestamp or explicit information cutoff",
  "horizon": "Relevant decision or forecast horizon",
  "status": "SUPPORTED | LEANING | UNRESOLVED | INSUFFICIENT_EVIDENCE",
  "conclusion": "Concise evidence-bounded conclusion",
  "data_quality": {
    "completeness": "high | medium | low",
    "timeliness": "high | medium | low",
    "reliability": "high | medium | low",
    "leakage_checked": true,
    "limitations": []
  },
  "evidence": [
    {
      "id": "E1",
      "type": "observation | derived | external_claim | assumption",
      "claim": "Atomic evidence statement",
      "source": "Source, artifact, or calculation",
      "observed_at": "Timestamp or null",
      "reliability": "high | medium | low",
      "relevance": "Why it matters",
      "limitations": []
    }
  ],
  "unknowns": [
    {
      "id": "U1",
      "item": "Missing decision-relevant fact",
      "impact": "How it limits the conclusion"
    }
  ],
  "relationships": [
    {
      "from": "E1",
      "to": "E2 or hypothesis ID",
      "type": "association | temporal | predictive | proposed_causal | verified_causal",
      "rationale": "Compact auditable explanation"
    }
  ],
  "hypotheses": [
    {
      "id": "H1",
      "statement": "Distinct explanatory hypothesis",
      "mechanism": "How it would produce the observations",
      "supporting_evidence": ["E1"],
      "contradicting_evidence": ["E2"],
      "differentiating_predictions": [],
      "invalidation_conditions": [],
      "weight": "leading | plausible | weak"
    }
  ],
  "scenarios": [
    {
      "id": "S1",
      "name": "Scenario name",
      "likelihood": "high | medium | low | probability range",
      "conditions": [],
      "drivers": [],
      "signposts": [],
      "implications": [],
      "invalidation_conditions": []
    }
  ],
  "adversarial_checks": [
    {
      "check": "Alternative cause, base rate, leakage, confounding, or other test",
      "result": "What the check found",
      "effect_on_conclusion": "none | lowers | changes | overturns"
    }
  ],
  "highest_information_next_observations": [],
  "confidence": {
    "score": 0,
    "basis": "Why this score is justified",
    "limitations": []
  },
  "handoff": {
    "recommended_skill": "domain skill name or null",
    "permitted_use": "What the next layer may do",
    "prohibited_use": "What must not be inferred or executed"
  }
}
```

## Validation Rules

- Keep evidence statements atomic enough that hypotheses can cite them precisely.
- Use stable evidence IDs across downstream transformations.
- Do not include `unknown` items in `evidence`; keep them in `unknowns`.
- Do not assign numeric probabilities unless the method supports them.
- If scenario probabilities are numeric, document the estimation basis and make the set coherent.
- Keep `confidence.score` between 0 and 100 and always include limitations.
- Set `status` to `INSUFFICIENT_EVIDENCE` when missing or invalid evidence blocks discrimination.
- Keep compact rationales, checks, and evidence links. Do not serialize private chain-of-thought.
- Preserve `as_of`, evidence IDs, unknowns, and invalidation conditions in every downstream handoff.

## Minimal Handoff

When a downstream consumer cannot accept the full object, preserve at least:

```json
{
  "as_of": "information cutoff",
  "status": "LEANING",
  "conclusion": "bounded conclusion",
  "evidence_ids": ["E1", "E3"],
  "leading_hypothesis": "H1",
  "live_alternatives": ["H2"],
  "unknowns": ["U1"],
  "invalidation_conditions": [],
  "confidence": 55
}
```
