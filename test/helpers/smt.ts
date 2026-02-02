import { keccak256, solidityPacked } from "ethers";

/**
 * Canonical SMT helpers for QSOL verifier tests.
 * Test-only. Deterministic. No shortcuts.
 */

export function hashLeaf(value: bigint): string {
  return keccak256(
    solidityPacked(["uint256"], [value])
  );
}

export function hashNode(left: string, right: string): string {
  return keccak256(
    solidityPacked(["bytes32", "bytes32"], [left, right])
  );
}

/**
 * Fold a Merkle path from leaf → root.
 * `path[i]` is the sibling at depth i.
 * `index` bit determines left/right.
 */
export function computeRoot(
  leaf: string,
  path: string[],
  index: bigint
): string {
  let node = leaf;
  let idx = index;

  for (let i = 0; i < path.length; i++) {
    const sibling = path[i];

    if (idx & 1n) {
      node = hashNode(sibling, node);
    } else {
      node = hashNode(node, sibling);
    }

    idx >>= 1n;
  }

  return node;
}

/**
 * Build an EMPTY proof (leaf = 0) for a fragment index.
 * Caller supplies depth-consistent sibling path.
 */
export function buildEmptyProof(
  fragmentId: bigint,
  path: string[]
) {
  const leaf = hashLeaf(0n);
  const root = computeRoot(leaf, path, fragmentId);

  return { leaf, root };
}

/**
 * Build a mint transition result.
 * value = fragmentId (canonical).
 */
export function buildMintProof(
  fragmentId: bigint,
  path: string[]
) {
  const leaf = hashLeaf(fragmentId);
  const root = computeRoot(leaf, path, fragmentId);

  return { leaf, root };
}
