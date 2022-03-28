//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

interface IVerifierCard {
    function verifyProof(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[2] memory input
    ) external view returns (bool);
}

interface IVerifierAnotherCard {
    function verifyProof(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[3] memory input
    ) external view returns (bool);
}

contract AnotherCard {
    address public verifierCardAddr;
    address public verifierAnotherCardAddr;

    constructor(address _verifierCardAddr, address _verifierAnotherCardAddr) {
        verifierCardAddr = _verifierCardAddr;
        verifierAnotherCardAddr = _verifierAnotherCardAddr;
    }

    function verifyProofCard(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[2] memory input
    ) public view returns (bool) {
        return IVerifierCard(verifierCardAddr).verifyProof(a, b, c, input);
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

    function verifyProofAnotherCard(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[3] memory input
    ) public view returns (bool) {
        return
            IVerifierAnotherCard(verifierAnotherCardAddr).verifyProof(
                a,
                b,
                c,
                input
            );
    }

    function verifyAnotherCard(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[3] memory input
    ) public view returns (bool) {
        require(verifyProofAnotherCard(a, b, c, input), "Filed proof check");
        return true;
    }
}
