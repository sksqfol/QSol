QSOL — Activation Specification (v1.0)
Purpose
This document defines the sole activation condition for the QSOL system.
Before activation, QSOL fragments exist only as inert on-chain state.
After activation, synthesis becomes permanently possible.
Activation is global, automatic, irreversible, and non-discretionary.
No other activation mechanism exists.
Definitions
MAX_SUPPLY
The immutable total number of QSOL fragments that can ever exist.
Defined at contract deployment
Cannot be increased, decreased, or overridden
Identical across all implementations claiming to be QSOL
totalMinted
The number of QSOL fragments successfully minted on-chain.
Increments only on successful mint
Cannot decrement
Cannot exceed MAX_SUPPLY
ALL_SOLD
A boolean condition defined strictly as:
Copy code

totalMinted == MAX_SUPPLY
No tolerance, no approximation, no alternative interpretation.
Activation Rule
QSOL activates if and only if ALL_SOLD == true.
There are:
No time-based unlocks
No admin triggers
No multisig confirmations
No governance votes
No emergency switches
No staged or partial activation states
Activation is purely state-derived.
Pre-Activation State
(ALL_SOLD == false)
While the system is not activated:
Fragment superposition is disabled
Verifier collapse functions MUST revert
No synthesis operations are callable
No keys may be minted
No keys may exist
No authority can emerge
Fragments are inert matter only.
Ownership conveys no power.
Activation Moment
The activation moment is the block in which:
Copy code

totalMinted reaches MAX_SUPPLY
At that exact moment:
Pairwise superposition becomes callable
Key minting becomes possible
Authority may begin to emerge
No additional transactions, confirmations, or signals are required.
Activation is automatic and immediate.
Post-Activation State
(ALL_SOLD == true)
Once activated:
Activation can never be reversed
ALL_SOLD can never return to false
No new fragments can ever be minted
Synthesis remains permanently enabled
The state space may only move forward
There is no “shutdown” path.
Forbidden Conditions
The following conditions are explicitly disallowed:
Activating before ALL_SOLD
Delaying activation after ALL_SOLD
Partial, phased, or region-based activation
Admin-controlled activation
External oracle activation
Time-based activation
Any discretionary intervention
Any implementation permitting these violates QSOL system invariants.
Design Rationale
This activation rule ensures:
Absolute fairness
No insider advantage
No early authority capture
No discretionary power
Cultural legitimacy of synthesis
QSOL becomes solvable for everyone at the same moment.
Finality
This specification is immutable once implementation begins.
Any future system claiming to be QSOL
MUST obey this activation rule exactly.
Status
Specification frozen.
Implementation pending.
If you want, next options are strictly limited (by design):
Proceed to QSOL-MECHANICS.md
Formal verifier invariants
Solidity pseudocode derived only from this spec
