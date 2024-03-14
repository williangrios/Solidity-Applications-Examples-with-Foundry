// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {ERC20} from "../src/ERC20.sol";

contract ERC20Test is Test {
    ERC20 public erc20;

    function setUp() external {
        erc20 = new ERC20();
    }

    function testMint() external {
        vm.prank(address(1));
        erc20.mint(1000);
        uint256 balance = erc20.balanceOf(address(1));
        assertEq(balance, 1000);
    }

    function testBurn() external {
        vm.startPrank(address(1));
        erc20.mint(1000);
        erc20.burn(400);
        uint256 balance = erc20.balanceOf(address(1));
        assertEq(balance, 600);
    }

    function testApprove() external {
        vm.prank(address(1));
        erc20.approve(address(2), 1000);
        uint256 allowance = erc20.allowance(address(1), address(2));
        assertEq(allowance, 1000);
    }

    function testTransfer() external {
        vm.startPrank(address(1));
        erc20.mint(1000);
        erc20.transfer(address(2), 500);
        uint256 balanceOf1 = erc20.balanceOf(address(1));
        uint256 balanceOf2 = erc20.balanceOf(address(2));
        assertEq(balanceOf1, 500);
        assertEq(balanceOf2, 500);
    }

    function testTransferFrom() external {
        vm.startPrank(address(1));
        erc20.mint(1000);
        erc20.approve(address(2), 1000);
        vm.stopPrank();
        vm.startPrank(address(2));
        erc20.transferFrom(address(1), address(3), 800);
        uint256 balanceOf1 = erc20.balanceOf(address(1));
        uint256 balanceOf3 = erc20.balanceOf(address(3));
        assertEq(balanceOf1, 200);
        assertEq(balanceOf3, 800);
    }
}
