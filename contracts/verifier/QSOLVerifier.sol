// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
    QSOL Verifier — Canonical Stateless Oracle (v1.0)

    This contract is a pure verifier for frozen QSOL mechanics.
    It holds NO storage, emits NO events, and performs NO state mutation.

    Every rule enforced here is downstream of:
    - SYSTEM-INVARIANTS.md
    - QSOL-ACTIVATION-SPEC.md
    - QSOL-MECHANICS.md

    Any divergence from those documents is invalid by definition.
*/

library QSOLVerifier {
    /*//////////////////////////////////////////////////////////////
                                CONSTANTS
    //////////////////////////////////////////////////////////////*/

    bytes32 internal constant EMPTY_LEAF = bytes32(0);
    uint256 internal constant TREE_DEPTH = 64;

    // "QSOL" ASCII, left-aligned, zero-padded
    bytes32 internal constant STATE_PREFIX =
        0x51534f4c00000000000000000000000000000000000000000000000000000000;

    bytes internal constant BURN_PREFIX = "BURNED";

    /*//////////////////////////////////////////////////////////////
                                ERRORS
    //////////////////////////////////////////////////////////////*/

    error ErrGenesisNotActivated();
    error ErrFragmentIdOutOfRange();
    error ErrInvalidProofDepth();
    error ErrRootMismatch();
    error ErrMintNoRootAdvance();
    error ErrTransferRootChanged();
    error ErrBurnDisabled();
    error ErrBurnNoRootAdvance();
    error ErrNoopRootChanged();
    error ErrUnknownTransition();

    /*//////////////////////////////////////////////////////////////
                        FRAGMENT STATE DERIVATION
    //////////////////////////////////////////////////////////////*/

    // state(N) = keccak256(uint64_be(N) || "QSOL")
    function deriveState(uint64 fragmentId) internal pure returns (bytes32) {
        if (fragmentId < 1 || fragmentId > 1_000_000_000) {
            revert ErrFragmentIdOutOfRange();
        }

        bytes memory n_be = new bytes(8);
        assembly {
            mstore(add(n_be, 0x20), fragmentId)
            mstore(n_be, 0x20)
        }

        return keccak256(abi.encodePacked(n_be, STATE_PREFIX));
    }

    // burn_marker(N) = keccak256("BURNED" || uint64_be(N))
    function burnMarker(uint64 fragmentId) internal pure returns (bytes32) {
        bytes memory n_be = new bytes(8);
        assembly {
            mstore(add(n_be, 0x20), fragmentId)
            mstore(n_be, 0x20)
        }

        return keccak256(abi.encodePacked(BURN_PREFIX, n_be));
    }

    /*//////////////////////////////////////////////////////////////
                    SPARSE MERKLE TREE VERIFICATION
    //////////////////////////////////////////////////////////////*/

    function verifySmtInclusion(
        bytes32 leaf,
        uint256 index,
        bytes32[] calldata siblings,
        bytes32 expectedRoot
    ) internal pure {
        if (siblings.length != TREE_DEPTH) {
            revert ErrInvalidProofDepth();
        }

        bytes32 node = leaf;
        uint256 idx = index;

        for (uint256 i = 0; i < TREE_DEPTH; ++i) {
            bytes32 sibling = siblings[i];
            bytes32 left;
            bytes32 right;

            if (idx & 1 == 0) {
                left = node;
                right = sibling;
            } else {
                left = sibling;
                right = node;
            }

            assembly {
                mstore(0x00, left)
                mstore(0x20, right)
                node := keccak256(0x00, 0x40)
            }

            idx >>= 1;
        }

        if (node != expectedRoot) {
            revert ErrRootMismatch();
        }
    }

    /*//////////////////////////////////////////////////////////////
                        TRANSITION VERIFIERS
    //////////////////////////////////////////////////////////////*/

    // Mint: EMPTY_LEAF → state(N)
    function verifyMint(
        uint64 fragmentId,
        bytes32 prevRoot,
        bytes32 newRoot,
        bytes32[] calldata emptyPath,
        bytes32[] calldata newPath
    ) internal pure {
        verifySmtInclusion(EMPTY_LEAF, fragmentId, emptyPath, prevRoot);

        bytes32 newState = deriveState(fragmentId);
        verifySmtInclusion(newState, fragmentId, newPath, newRoot);

        if (newRoot == prevRoot) {
            revert ErrMintNoRootAdvance();
        }
    }

    // Transfer: metadata only, root must not change
    function verifyTransfer(bytes32 prevRoot, bytes32 newRoot) internal pure {
        if (newRoot != prevRoot) {
            revert ErrTransferRootChanged();
        }
    }

    // Burn: state(N) → burn_marker(N)
    function verifyBurn(
        uint64 fragmentId,
        bytes32 prevRoot,
        bytes32 newRoot,
        bytes32[] calldata prevPath,
        bytes32[] calldata newPath,
        bool burnEnabled
    ) internal pure {
        if (!burnEnabled) {
            revert ErrBurnDisabled();
        }

        verifySmtInclusion(
            deriveState(fragmentId),
            fragmentId,
            prevPath,
            prevRoot
        );

        verifySmtInclusion(
            burnMarker(fragmentId),
            fragmentId,
            newPath,
            newRoot
        );

        if (newRoot == prevRoot) {
            revert ErrBurnNoRootAdvance();
        }
    }

    // No-op: read-only, root invariant
    function verifyNoop(bytes32 prevRoot, bytes32 newRoot) internal pure {
        if (newRoot != prevRoot) {
            revert ErrNoopRootChanged();
        }
    }

    /*//////////////////////////////////////////////////////////////
                        UNIFIED ORACLE ENTRY
    //////////////////////////////////////////////////////////////*/

    /*
        transition ∈ {"mint", "transfer", "burn", "noop"}
        params ABI-encoded per transition
    */
    function qsolVerify(
        string calldata transition,
        bytes32 prevRoot,
        bytes32 newRoot,
        bytes calldata params,
        bool genesisActivated,
        bool burnEnabled
    ) external pure {
        if (!genesisActivated) {
            revert ErrGenesisNotActivated();
        }

        bytes32 t = keccak256(abi.encodePacked(transition));

        if (t == keccak256("mint")) {
            (
                uint64 fragmentId,
                bytes32[] memory emptyPath,
                bytes32[] memory newPath
            ) = abi.decode(params, (uint64, bytes32[], bytes32[]));

            verifyMint(fragmentId, prevRoot, newRoot, emptyPath, newPath);

        } else if (t == keccak256("transfer")) {
            verifyTransfer(prevRoot, newRoot);

        } else if (t == keccak256("burn")) {
            (
                uint64 fragmentId,
                bytes32[] memory prevPath,
                bytes32[] memory newPath
            ) = abi.decode(params, (uint64, bytes32[], bytes32[]));

            verifyBurn(
                fragmentId,
                prevRoot,
                newRoot,
                prevPath,
                newPath,
                burnEnabled
            );

        } else if (t == keccak256("noop")) {
            verifyNoop(prevRoot, newRoot);

        } else {
            revert ErrUnknownTransition();
        }
    }
}
