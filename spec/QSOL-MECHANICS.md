QSOL — Mechanics Specification (v1.0)
Purpose
This document defines the mechanical rules governing QSOL fragment interaction, synthesis, and authority emergence after activation.
These mechanics are downstream of:
SYSTEM-INVARIANTS.md
QSOL-ACTIVATION-SPEC.md
No mechanic defined here may violate those documents.
Preconditions
QSOL mechanics are callable if and only if:
Copy code

ALL_SOLD == true
If ALL_SOLD == false, all mechanics MUST revert.
There are no exceptions.
Core Entities
Fragment
A fragment is an ERC-721 token representing a unit of inert or activated state.
Properties:
Unique token ID
Immutable after mint
Cannot be burned, merged, or modified
Ownership alone conveys no authority
Fragments are matter, not power.
Pairwise Superposition (⊕)
Superposition is the fundamental interaction primitive.
Definition:
Two distinct fragments may be submitted together to the Verifier
Order is irrelevant: (A ⊕ B) ≡ (B ⊕ A)
A fragment may not superpose with itself
Superposition does not consume fragments.
Collapse & Determinism
Collapse
A collapse is an irreversible evaluation of a superposed fragment pair.
Properties:
Deterministic with respect to:
Fragment IDs
On-chain state at call time
Cannot be replayed for the same ordered pair
Cannot be undone
Each valid pair may collapse at most once.
Uniqueness Constraint (≡1)
For any unordered fragment pair {A, B}:
At most one collapse may ever occur
Subsequent attempts MUST revert
This enforces state monotonicity.
Authority Keys
Key Minting
A successful collapse may mint exactly one authority key.
Rules:
Key minting is verifier-controlled only
Keys are soulbound
Keys are non-transferable
Keys are burn-on-use
No collapse → no key.
No key → no authority.
Key Usage
When a key is used:
It is permanently burned
Its effect is immediately realized
It can never be re-minted or replaced
Authority is spent, not accumulated.
Entropy & Emergence
QSOL does not guarantee:
That any specific collapse yields a key
That synthesis converges
That an end state is reached
The system is allowed to:
Stall
Fragment
Remain unresolved forever
This is intentional.
Endgame Non-Guarantee (KΩ)
A terminal synthesis state (KΩ):
May exist
Is not promised
Cannot be forced
Cannot be admin-triggered
If reached, it is the result of emergent behavior only.
Forbidden Mechanics
The following are explicitly disallowed:
Fragment burning
Fragment merging
Admin-initiated collapse
Override keys
Emergency synthesis paths
Replayable collapses
Off-chain entropy injection
Any mechanic enabling these violates system invariants.
Mechanical Finality
All mechanical actions are:
On-chain
Deterministic
Irreversible
Non-discretionary
The system has no undo.
Status
Specification frozen.
Implementation pending.
If you want, the only valid next steps are:
Verifier pseudocode derived line-by-line from this spec
Key contract constraints (ERC-1155 soulbound formalism)
Invariant stress-testing (attack surface review)
