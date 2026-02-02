QSOL — Mechanics Specification (v1.0)

Purpose

This document defines the mechanical rules governing QSOL fragments and their interactions.
=======
# QSOL — Mechanics Specification (v1.0)

## 1. Purpose
>>>>>>> 96c276e (Freeze QSOL mechanics and specifications)

This document defines the **mechanical rules** governing QSOL fragment existence and state transitions after activation.

These mechanics are strictly downstream of, and constrained by:

- SYSTEM-INVARIANTS.md
- QSOL-ACTIVATION-SPEC.md

No mechanic defined here may violate, weaken, or bypass any invariant or activation rule defined in those documents.

This specification describes **what the system does**, not what actors intend.

<<<<<<< HEAD
Preconditions
=======
---

## 2. Preconditions for Callability
>>>>>>> 96c276e (Freeze QSOL mechanics and specifications)

QSOL mechanics are callable if and only if:

GENESIS_ACTIVATED == true

<<<<<<< HEAD
If ALL_SOLD == false, all mechanics MUST revert.

There are no exceptions.
=======
If `GENESIS_ACTIVATED == false`, **all mechanics MUST revert**.

There are no exceptions, overrides, or administrative bypasses.

---

## 3. Universe Constants

The following constants are immutable and globally enforced:

- `TOTAL_FRAGMENTS = 1_000_000_000`
- `FRAGMENT_ID_RANGE = [1 … 1_000_000_000]`
- `HASH_FUNCTION = keccak256`
- `FRAGMENT_STATE_PREFIX = "QSOL"` (ASCII)
- `TREE_TYPE = Sparse Merkle Tree`
- `TREE_DEPTH = 64`
- `EMPTY_LEAF = 0x0000000000000000000000000000000000000000000000000000000000000000`

---

## 4. Fragment Definition

A **fragment** is a uniquely identified, indivisible unit of inert state.

### Properties

- Identified by a unique `FragmentID`
- `FragmentID` is immutable
- Fragments cannot be merged, split, or altered
- Fragments carry **no intrinsic authority**
- Fragments are **matter, not power**

Fragments exist independently of ownership, accounts, or actors.

---

## 5. Fragment State Derivation (Immutable)

For every fragment `N`:

state(N) := keccak256(abi.encodePacked(uint64_be(N), "QSOL"))

### Rules

- Each fragment occupies a unique leaf position
- Unset leaves resolve to `EMPTY_LEAF`
- Parent nodes are computed as:

H(left_child || right_child)

- The root is the **only consensus-relevant state**

All valid system states are descendants of the genesis root.

---

## 6. Commitment Root

The canonical system state is the Sparse Merkle Tree root computed over all fragment states.

---

## 7. Allowed State Transitions

Only the following transitions are permitted.

### 7.1 Mint

**Purpose:** Materialize a fragment as claimed.

**Preconditions:**
- `FragmentID` ∈ `FRAGMENT_ID_RANGE`
- Fragment not previously claimed
- Valid inclusion proof against the current root

**Effect:**
- Fragment marked as claimed
- Sparse Merkle Tree updated at `FragmentID` with `state(FragmentID)`

**Invariant:**
- Computed state **must equal** `state(FragmentID)`
- No other leaf may change

---

### 7.2 Transfer

**Purpose:** Change ownership metadata.

**Preconditions:**
- Fragment is claimed
- Valid authorization from current owner

**Effect:**
- Ownership record updated

**Invariant:**

> **Ownership does not participate in the commitment root and therefore does not affect consensus state.**

The Sparse Merkle Tree root remains unchanged.

---

### 7.3 Burn (Optional, If Enabled)

**Purpose:** Irreversibly nullify a fragment.

**Preconditions:**
- Fragment is claimed
- Burn is explicitly enabled by activation rules
- Valid authorization from owner

**Effect:**
- Fragment marked burned
- SMT leaf updated to a burn marker hash

**Invariant:**
- Burned fragments cannot be re-minted
- Total active fragments may decrease, never increase

---

### 7.4 No-Op

**Purpose:** Valid transaction with no state change.

**Effect:**
- No modification to any state
- Root remains identical

---

## 8. Forbidden Transitions

The following are strictly disallowed and MUST revert:

- Re-minting an existing fragment
- Modifying `state(N)` for any `N`
- Increasing total fragment count
- Differential treatment of founder vs public fragments
- Retroactive modification of any root
- Introducing entropy or randomness
- Any transition violating SYSTEM-INVARIANTS.md

---

## 9. Proof Obligations

At all times, the following must hold:

- Every claimed fragment has a valid inclusion proof
- All fragment states match `state(N)`
- Total claimed ≤ `TOTAL_FRAGMENTS`
- Roots advance monotonically (never rewind)
- Founder fragments are mechanically indistinguishable from all others

---

## 10. Mechanical Finality

All mechanics are:

- On-chain
- Deterministic
- Irreversible
- Non-discretionary

The system has no administrator, no override, and no undo.

---

## 11. Status

Specification frozen.
Implementation pending.

All future code MUST be a faithful execution of this document.
>>>>>>> 96c276e (Freeze QSOL mechanics and specifications)
