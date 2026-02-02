QSOL — Mechanics Specification (v1.0)

Purpose

This document defines the mechanical rules governing QSOL fragments and their interactions.

These mechanics are downstream of:
- SYSTEM-INVARIANTS.md
- QSOL-ACTIVATION-SPEC.md

No mechanic defined here may violate those documents.

Preconditions

QSOL mechanics are callable if and only if:

ALL_SOLD == true

If ALL_SOLD == false, all mechanics MUST revert.

There are no exceptions.
