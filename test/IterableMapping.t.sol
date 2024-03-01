//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {IterableMapping} from "../src/IterableMapping.sol";

contract TestIterableMapping is Test{
    using IterableMapping for IterableMapping.Map;

    IterableMapping.Map private map;

    function testIterableMap() external {
        map.set(address(1), 0);
        assertEq(IterableMapping.size(map), 1);
        map.set(address(2), 100);
        assertEq(IterableMapping.size(map), 2);
        address key = map.getKeyAtIndex(0);
        assertEq(key, address(1));
        map.set(address(3), 200);
        map.set(address(4), 300);
        map.set(address(5), 400);

        for(uint i = 0; i<map.size(); i++) {
            address _key = map.getKeyAtIndex(i);
            uint256 _value = map.get(_key);
            console.log("Iterating", i, _value);
        }

        map.remove(address(2));
        uint256 newSize = map.size();
        assertEq(newSize , 4);
        assertEq(map.getKeyAtIndex(0) , address(1));
        assertEq(map.getKeyAtIndex(1) , address(5));
        assertEq(map.getKeyAtIndex(2) , address(3));
    }
}