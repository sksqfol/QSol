QSOL — Launch Sequence (v1.0)
Purpose
This document defines the only valid sequence for deploying and activating the QSOL system.
Any deviation from this order invalidates the system’s legitimacy.
This sequence is downstream of:
SYSTEM-INVARIANTS.md
QSOL-ACTIVATION-SPEC.md
QSOL-MECHANICS.md
Phase 0 — Genesis Preparation (Off-Chain)
Status: Required
Reversible: Yes (until deployment)
Actions:
Finalize and freeze all canonical documents:
SYSTEM-INVARIANTS.md
QSOL-ACTIVATION-SPEC.md
QSOL-MECHANICS.md
LAUNCH-SEQUENCE.md
Publish repository publicly
Verify commit hashes for all documents
No contracts deployed
No fragments minted
Constraints:
No addresses are privileged
No authority exists
No on-chain state exists
Phase 1 — Contract Deployment (Genesis Seal)
Status: One-time
Reversible: No
Actions (single transaction or atomic sequence):
Deploy Fragment (ERC-721) contract
Deploy Verifier contract
Deploy Authority Key contract
Link contracts immutably
Mint Genesis fragments (if any) as defined in SYSTEM-INVARIANTS.md
Constraints:
Genesis allocation is fixed and public
No collapses enabled
No keys may exist
ALL_SOLD must be false
No admin-only mechanics permitted
Result:
System exists
System is inert
Phase 2 — Public Fragment Mint
Status: Open
Reversible: No
Actions:
Public minting enabled
Fragments minted until MAX_SUPPLY is reached
Constraints:
No synthesis
No collapses
No keys
No authority
Supply cap strictly enforced
Invariant:
No synthesis before scarcity is complete.
Phase 3 — Activation (ALL_SOLD)
Status: Automatic
Reversible: Impossible
Trigger:
Copy code

totalMinted == MAX_SUPPLY
Effects (same block):
ALL_SOLD flips to true
Verifier collapse functions unlock
Key minting becomes possible
Constraints:
No admin calls
No delay
No confirmation step
No partial activation
Activation is global, immediate, and final.
Phase 4 — Post-Activation Emergence
Status: Ongoing
Reversible: No
Actions:
Participants may attempt superposition and collapse
Keys may be minted through successful collapses
Authority may emerge through key usage
Constraints:
Keys are soulbound
Keys are burn-on-use
Collapses are irreversible
Authority cannot be assigned or transferred
The system is now alive.
Phase 5 — Open End State
Status: Undefined
Reversible: No
Properties:
System may converge, stall, or fragment
Terminal state (KΩ) may or may not be reached
No party is guaranteed authority
Constraints:
No resets
No upgrades that violate invariants
No retroactive privilege
QSOL is allowed to exist indefinitely without resolution.
Invalid Launch Patterns
The following invalidate the system:
Activating before ALL_SOLD
Time-based unlocks
Admin-triggered activation
Emergency bypasses
Post-deployment rule changes
Reordered phases
Finality
Once Phase 1 begins:
All subsequent phases are enforced by code
No human discretion remains
Legitimacy derives solely from adherence to this sequence
Status
Sequence frozen.
Execution pending.
