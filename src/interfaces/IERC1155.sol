// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC1155 {
    function transferFrom(address from, address to, uint256 id, uint256 value, bytes calldata data) external;
    function safeBatchTransferFromm(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external;
    function balanceOf(address owner, uint256 id) external view returns (uint256);
    function balanceofBatch(address[] calldata owners, uint256[] calldata ids)
        external
        view
        returns (uint256[] memory);
    function setApprovalForAll(address operator, bool approved) external;
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}
