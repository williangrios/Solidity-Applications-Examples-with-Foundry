// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.20;

// import {IERC1155} from "./interfaces/IERC1155.sol";
// import {IERC1155TokenReceiver} from "./interfaces/IERC1155TokenReceiver.sol";

// contract ERC1155 is IERC1155 {
//     event TransferSingle(address indexed operator, address indexed from, address indexed to, uint256 id, uint256 value);
//     event TransferBatch(
//         address indexed operator, address indexed from, address indexed to, uint256[] ids, uint256[] values
//     );
//     event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
//     event URI(string value, uint256 indexed id);

//     mapping(address => mapping(uint256 => uint256)) public balanceOf;
//     mapping(address => mapping(address => bool)) public isApprovedForAll;

//     function balanceofBatch(address[] calldata owners, uint256[] calldata ids) external view returns (uint256[] memory balances) {
//         require(owners.length == ids.length, "Owners length is different of ids length");
//         balances = new uint256[](owners.length);
//         unchecked {
//             for (uint256 i = 0; i < owners.length; i++) {
//                 balances[i] = balanceOf[owners[i]][ids[i]];
//             }
//         }
//     }

//     function setApprovalForAll(address operator, bool approved) external {
//         isApprovedForAll[msg.sender][operator] = approved;
//         emit ApprovalForAll(msg.sender, operator, approved);
//     }

//     function safeTransferFrom(address from, address to, uint256 id, uint256 value, bytes calldata data) external {
//         require(msg.sender == from || isApprovedForAll[from][msg.sender], "not approved");
//         require(to != address(0), "to can not be zero address");
//         balanceOf[from][id] -= value;
//         balanceOf[to][id] += value;
//         emit TransferSingle(msg.sender, from, to, id, value);
//         // is to a smart contract?
//         if (to.code.length > 0) {
//             require(IERC1155TokenReceiver(to).onERC1155Received(msg.sender, from, id, value, data) == IERC1155TokenReceiver.onERC1155Received.selector, "unsafe transfer");
//         }
//     }

//     function safeBatchTransferFrom(address from, address to, uint256[] calldata ids, uint256[] calldata values, bytes calldata data) external {
//         require(msg.sender == from || isApprovedForAll[from][msg.sender], "not approved");
//         require(ids.length == values.length, "ids length != values length");
//         for (uint256 i = 0; i < ids.length; i++) {
//             balanceOf[from][ids[i]] -= values[i];
//             balanceOf[to][ids[i]] += values[i];
//         }
//         emit TransferBatch(msg.sender, from, to, ids, values);
//         if (to.code.length > 0){
//             require(IERC1155TokenReceiver(to).onERC1155BatchReceived(msg.sender, from, ids, values, data) == IERC1155TokenReceiver.onERC1155BatchReceived.selector, "unsafe transfer");
//         }
//     }

//     function supportsInterface(bytes4 interfaceId) external view returns (bool){
//         return interfaceId == 0x01ffc9a7
//             || interfaceId == 0xd9b67a26
//             || interfaceId == 0x0e89341c;
//     }

//     function uri(uint256 id) public view virtual returns (string memory) {}

//     function _mint(address to, uint256 id, uint256 value, bytes memory data) internal {
//         require(to != address(0), "To cannot be zero address");
//         balanceOf[to][id] += value;
//         emit TransferSingle(msg.sender, address(0), to, id, value);

//         if (to.code.length > 0) {
//             require(IERC1155TokenReceiver(to).onERC1155Received(msg.sender, address(0), id, value, data) == IERC1155TokenReceiver.onERC1155Received.selector,"unsafe transfer");
//         }
//     }

//     function _batchMint(address to, uint256[] calldata ids, uint256[] calldata values, bytes calldata data) internal {
//         require(to != address(0), "To can not be zero address");
//         require(ids.length == values.length, "Ids length is different than values length");
//         for (uint256 i = 0; i < ids.length; i++){
//             balanceOf[to][ids[i]] += values[i];
//         }
//         emit TransferBatch(msg.sender, address(0), to, ids, values);
//         if (to.code.length > 0){
//             require(IERC1155TokenReceiver(to).onERC1155BatchReceived(msg.sender, address(0), ids, values, data) == IERC1155TokenReceiver.onERC1155BatchReceived.selector, "Unsafe transfer");
//         }
//     }

//     function _burn(address from, uint256 id, uint256 value) internal{
//         require(from != address(0), "From can not be zero address");
//         balanceOf[from][id] -= value;
//         emit TransferSingle(msg.sender, from, address(0), id, value);
//     }

//     function _batchBurn(address from, uint256[] calldata ids, uint256[] calldata values) internal{
//         require(from != address(0), "From can not be zero address");
//         require(ids.length == values.length,  "Ids length is different than values length");
//         for (uint256 i = 0; i < ids.length; i++){
//             balanceOf[from][ids[i]] -= values [i];
//         }
//         emit TransferBatch(msg.sender, from, address(0), ids, values);
//     }
// }
