QSOL is a closed on-chain system governed by immutable invariants.

This repository intentionally prioritizes **rules and specifications**
before implementation. All contracts, mechanics, and launch steps
are downstream of constraints defined here.

QSOL encodes authority as **earned, irreversible state** — not assignment.

---

## Repository Structure

This repository is structured to separate **invariants**, **specification**,
and **implementation**, in that order.

- `SYSTEM-INVARIANTS.md`  
  Canonical constraints the system will never violate.

- `/spec/`  
  Formal specifications that translate invariants into executable logic.
  - `QSOL-MECHANICS.md` — fragment interaction and synthesis rules (to be defined)

- `/docs/`  
  Human-readable but precise deployment and launch sequencing.
  - `LAUNCH-SEQUENCE.md` — genesis → public mint → activation (to be defined)

- `/contracts/`  
  Solidity implementations (intentionally empty at this stage).
  - `nft/` — fragment ERC-721
  - `verifier/` — synthesis + activation logic
  - `keys/` — soulbound authority keys

---

## Design Principle

> Computation is ephemeral.  
> Attestation is permanent.

QSOL is designed so that:
- Authority cannot be assigned
- State cannot be rolled back
- Power only emerges through irreversible action

---

## Status

- No contracts deployed
- No fragments minted
- No keys exist
- No authority exists

Implementation will begin **only after** all invariants and activation
conditions are frozen.

---

## Contribution Policy

This repository is public for transparency and auditability.

Design decisions are intentional and constraint-driven.
Pull requests and issues may not be accepted.

Witnesses > contributors.
