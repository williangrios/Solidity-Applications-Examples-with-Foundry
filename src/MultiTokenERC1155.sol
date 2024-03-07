// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC1155} from "./ERC1155.sol";

contract MultiTokenERC1155 is ERC1155 {
    function mint(uint256 id, uint256 value, bytes memory data) external {
        _mint(msg.sender, id, value, data);
    }

    function batchMint(uint256[] calldata ids, uint256[] calldata values, bytes calldata data) external {
        _batchMint(msg.sender, ids, values, data);
    }

    function burn(uint256 id, uint256 value) external {
        _burn(msg.sender, id, value);
    }

    function batchBurn(uint256[] calldata ids, uint256[] calldata values) external {
        _batchBurn(msg.sender, ids, values);
    }
}