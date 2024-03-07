// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {EtherWallet} from "../src/EtherWallet.sol";

contract EtherWalletScript is Script {
    EtherWallet etherWallet;

    function setUp() public {}

    function run() public {
        // private key below
        vm.broadcast();
        etherWallet = new EtherWallet();
        console2.log("Address:", address(etherWallet));
        console2.log("Initial balance:", etherWallet.getBalance());
    }
}
