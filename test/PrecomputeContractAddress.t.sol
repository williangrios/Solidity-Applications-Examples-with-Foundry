// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Factory, TestContract} from "../src/PrecomputeContractAddress.sol";
import "forge-std/console.sol";

contract TestPrecomputeContractAddress is Test {
    Factory public factory;
    TestContract public testContract;
    address public previewAddress;

    function setUp() external {
        factory = new Factory();
        testContract = new TestContract(address(1), 123);
    }

    function testDeploy() external {
        bytes32  _salt = bytes32("Transaction to me");
        previewAddress = factory.deploy(address(1), 123, _salt);
        assertEq(previewAddress, address(testContract));
    }
}