// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {WRNFT} from "../src/WRNFT.sol";

contract WRNFTTest is Test {
    WRNFT public wrNft;

    function setUp() external {
        wrNft = new WRNFT();
    }

    function testMint() external {
        vm.prank(address(1));
        wrNft.mint(address(2), 1);
        uint256 balance = wrNft.balanceOf(address(2));
        assertEq(balance, 1);
    }

    function testBurn() external {
        vm.prank(address(1));
        wrNft.mint(address(2),1);
        vm.prank(address(2));
        wrNft.burn(1);
        uint256 balance = wrNft.balanceOf(address(2));
        assertEq(balance, 0);
    }
}