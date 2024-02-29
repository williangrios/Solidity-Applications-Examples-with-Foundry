// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {EtherWallet} from "../src/EtherWallet.sol";

contract EtherWalletTests is Test {
    EtherWallet public etherWallet;

    function setUp() external {
        etherWallet = new EtherWallet();
    }

    function testDeposit() external {
        (bool success,) = address(etherWallet).call{value: 100}("");
        uint256 balance = etherWallet.getBalance();
        assertEq(success, true);
        assertEq(balance, 100);
    }

    function testSuccessfulWithdraw() external {
        (bool success, ) = address(etherWallet).call{value: 100}("");
        etherWallet.withdraw(50);
        uint256 balance = etherWallet.getBalance();
        assertEq(balance, 50);
    }

    function testGetBalance() external {
        uint256 balance = etherWallet.getBalance();
        assertEq(balance, 0);
    }
}
