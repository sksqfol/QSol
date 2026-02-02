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
