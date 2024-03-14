//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {MultiSigWallet} from "../src/MultiSigWallet.sol";
import "forge-std/console.sol";

contract MultiSigWalletTests is Test {
    MultiSigWallet public multiSigWallet;
    address[] public addresses;

    function setUp() external {
        addresses = new address[](3);
        addresses[0] = address(1);
        addresses[1] = address(2);
        addresses[2] = address(3);
        multiSigWallet = new MultiSigWallet(addresses, 2);
    }

    function testDeposit() external {
        (bool success,) = address(multiSigWallet).call{value: 1 ether}("");
        uint256 balance = multiSigWallet.getBalance();
        assertEq(success, true);
        assertEq(balance, 1 ether);
    }

    function testSubmitTransaction() external {
        vm.startPrank(address(1));
        bytes memory data = abi.encodePacked("Transaction to me");
        multiSigWallet.submitTransaction(address(1), 1 ether, data);
        (address _to, uint256 _value, bytes memory _data, bool _executed, uint256 _numConfirmations) =
            multiSigWallet.getTransaction(0);
        assertEq(_to, address(1));
        assertEq(_value, 1 ether);
        assertEq(_data, abi.encodePacked("Transaction to me"));
        assertEq(_executed, false);
        assertEq(_numConfirmations, 0);
    }

    function testConfirmTransaction() external {
        vm.startPrank(address(1));
        bytes memory data = abi.encodePacked("Transaction to me");
        multiSigWallet.submitTransaction(address(1), 1 ether, data);
        multiSigWallet.confirmTransaction(0);
        (address _to, uint256 _value, bytes memory _data, bool _executed, uint256 _numConfirmations) =
            multiSigWallet.getTransaction(0);
        assertEq(_to, address(1));
        assertEq(_value, 1 ether);
        assertEq(_data, abi.encodePacked("Transaction to me"));
        assertEq(_executed, false);
        assertEq(_numConfirmations, 1);
    }

    function testExecuteTransaction() external {
        vm.startPrank(address(1));
        bytes memory data = abi.encodePacked("Transaction to me");
        multiSigWallet.submitTransaction(address(1), 1 ether, data);
        multiSigWallet.confirmTransaction(0);
        vm.stopPrank();
        vm.startPrank(address(2));
        multiSigWallet.confirmTransaction(0);
        bool succcess = multiSigWallet.executeTransaction(0);
        console.log("resultado----", succcess);
        assertEq(succcess, false);
    }

    function testRevokeConfirmation() external {
        vm.startPrank(address(1));
        bytes memory data = abi.encodePacked("Transaction to me");
        multiSigWallet.submitTransaction(address(1), 1 ether, data);
        multiSigWallet.confirmTransaction(0);
        multiSigWallet.revokeConfirmation(0);
        (address _to, uint256 _value, bytes memory _data, bool _executed, uint256 _numConfirmations) =
            multiSigWallet.getTransaction(0);
        assertEq(_to, address(1));
        assertEq(_value, 1 ether);
        assertEq(_data, abi.encodePacked("Transaction to me"));
        assertEq(_executed, false);
        assertEq(_numConfirmations, 0);
    }
}
