//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

interface IVerifier {
    function verifyProof(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[2] memory input
    ) external view returns (bool);
}

contract SingleCard {
    address public verifierCardAddr;

    constructor(address _verifierCardAddr) {
        verifierCardAddr = _verifierCardAddr;
    }

    function verifyProofCard(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[2] memory input
    ) public view returns (bool) {
        return IVerifier(verifierCardAddr).verifyProof(a, b, c, input);
    }

    function verifyCard(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[2] memory input
    ) public view returns (bool) {
        require(verifyProofCard(a, b, c, input), "Filed proof check");
        return true;
    }
}
