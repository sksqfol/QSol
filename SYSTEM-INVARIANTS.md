# QSOL — System Invariants v1.0

This document defines constraints that the QSOL system will never violate.
All contracts, mints, mechanics, and launch steps are downstream of these rules.
If any implementation conflicts with this document, the implementation is invalid.

---

## 1. Fixed Total Supply

QSOL has a single, immutable total supply of fragments.

- The total fragment count is fixed at deploy time.
- The total supply can never be increased or decreased.
- No secondary minting paths exist.

If total supply is mutable, authority is meaningless.

---

## 2. Genesis Allocation (Authorship Only)

A small, explicit Genesis allocation exists to attest authorship.

- Genesis fragments are minted at contract deployment.
- The quantity and token IDs (or fixed range) are immutable.
- Genesis allocation occurs before any public mint.
- Genesis fragments confer no special permissions.

Genesis allocation does not bypass entropy, collapse rules, or authority mechanics.

---

## 3. Public Mint Finality

All non-genesis fragments are minted through a public process.

- No fragments may be minted after public mint concludes.
- No fragments may be withheld, reserved, or admin-minted later.
- Fragment ownership is transferable unless otherwise constrained by mechanics.

Once distribution ends, scarcity is complete forever.

---

## 4. ALL_SOLD Global Lock

Fragment synthesis and collapse are globally disabled until all fragments are minted.

- ALL_SOLD is defined strictly as: totalMinted == MAX_SUPPLY.
- No time-based, admin-based, or partial unlocks exist.
- ALL_SOLD is irreversible once reached.

Before ALL_SOLD, fragments are inert.

---

## 5. Authority Source

Authority in QSOL is never assigned.

- Authority emerges only through keys.
- Keys are minted only by verifier logic.
- Keys require irreversible actions (burns or collapses).
- Keys do not exist before ALL_SOLD.

Deployment, authorship, or ownership alone grant no authority.

---

## 6. No Administrative Overrides

QSOL contains no privileged control paths.

- No owner-only collapse or synthesis.
- No emergency unlocks.
- No override keys.
- No multisig backdoors.

If a rule can be bypassed, it is not a rule.

---

## 7. Irreversibility

All meaningful state transitions in QSOL are irreversible.

- Collapses cannot be undone.
- Burned fragments and keys cannot be restored.
- Authority cannot be revoked except through system-defined mechanics.

State progresses forward only.

---

## 8. Endgame Non-Guarantee

QSOL may contain a terminal end state (KΩ).

- Reaching the end state is possible but not guaranteed.
- The system may stall permanently without violating invariants.
- No mechanism forces completion.

Uncertainty is preserved by design.

---

## 9. Invariant Supremacy

These invariants supersede all other documents and code.

- Specifications interpret these rules.
- Contracts encode these rules.
- No future version may weaken them.

Any fork that violates these invariants is not QSOL.

---

## Declaration

These invariants are declared final as of v1.0.

They are binding on:
- The system creator
- All future contributors
- All deployed implementations

Computation is ephemeral.
Attestation is permanent.
=======
# QSOL System Invariants (v1.0)

## 1. Purpose

This document defines the absolute, immutable invariants governing the QSOL system.

All specifications, contracts, circuits, scripts, and deployments MUST comply
with these invariants. No lower-level document or implementation may violate
or weaken any invariant defined herein.

These invariants are upstream of:
- QSOL-MECHANICS.md
- QSOL-ACTIVATION-SPEC.md
- All smart contracts and verifier circuits

---

## 2. Scope

System invariants define constraints on what the system **is allowed to do**,
not how it is implemented.

If any invariant is violated, the system is considered invalid.

---

## 3. Activation Boundary

All invariants apply strictly after system activation.

Before activation:
- No collapse mechanics are callable
- No authority may emerge

After activation:
- All invariants are enforced permanently
- No upgrade path may bypass them

---

## 4. Absolute Invariants

### 4.1 Fragment Set Invariant
The set of valid Fragment NFTs is finite, immutable, and publicly verifiable.
No fragment may be created, destroyed, duplicated, or altered after system activation.

### 4.2 Deterministic Evaluation Invariant
The result of a collapse evaluation for any fragment pair (A, B) is a pure,
deterministic function of the pair’s immutable state commitments. The evaluation
admits no randomness, oracle input, external state, or mutable parameters.

### 4.3 Pair Consumption Invariant
Each unordered fragment pair {A, B} may be submitted to the collapse function
at most once. Any subsequent attempt to evaluate an already-consumed pair MUST
fail and produce no state change.

### 4.4 Authority Emergence Invariant
An authority key may be minted if and only if a zero-knowledge proof verifies
the following statement:

“The immutable state commitments of fragments A and B satisfy the equation  
(333 × (stateA + stateB)) mod FIELD = 1.”

No other condition, signal, or privilege may cause authority emergence.

### 4.5 Key Property Invariant
Authority keys are non-transferable attestations. They MAY NOT be transferred,
delegated, or reassigned. Authority keys MUST be destroyed upon any use and
confer no rights beyond those explicitly defined by system mechanics.

### 4.6 Temporal Finality Invariant
All state transitions within the system are irreversible. No mechanism may undo,
roll back, replay, or invalidate a fragment mint, pair consumption, authority key
issuance, or authority key destruction.

---

## 5. Interpretive Prohibition

No authority, contract upgrade, governance process, or external actor may:

- Reinterpret these invariants
- Extend these invariants
- Override these invariants
- Introduce exceptions to these invariants

Only literal execution is permitted.

---

## Status

Draft — pending cross-check against mechanics and activation specifications.
>>>>>>> ed5d58c (Freeze QSOL system invariants v1.0)
