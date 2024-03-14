// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC721} from "./interfaces/IERC721.sol";
import {IERC165} from "./interfaces/IERC165.sol";
import {IERC721Receiver} from "./interfaces/IERC721Receiver.sol";

contract ERC721 is IERC721 {
    event Transfer(address indexed from, address indexed to, uint256 indexed id);
    event Approval(address indexed owner, address indexed spender, uint256 indexed id);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    mapping(uint256 => address) internal _ownerOf;
    mapping(address => uint256) internal _balanceOf;
    mapping(uint256 => address) internal _approvals;
    mapping(address => mapping(address => bool)) public isApprovedForAll;

    function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
        return interfaceId == type(IERC721).interfaceId || interfaceId == type(IERC165).interfaceId;
    }

    function ownerOf(uint256 id) external view returns (address owner) {
        owner = _ownerOf[id];
        require(owner != address(0), "Token does not exist");
    }

    function balanceOf(address owner) external view returns (uint256) {
        require(owner != address(0), "Owner can not be zero address");
        return _balanceOf[owner];
    }

    function setApprovalForAll(address operator, bool approved) external {
        isApprovedForAll[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function getApproved(uint256 id) external view returns (address) {
        require(_ownerOf[id] != address(0), "token doesn't exist");
        return _approvals[id];
    }

    function approve(address spender, uint256 tokenId) external {
        address owner = _ownerOf[tokenId];
        require(owner == msg.sender || isApprovedForAll[owner][msg.sender], "You are not the owner");
        _approvals[tokenId] = spender;
        emit Approval(msg.sender, spender, tokenId);
    }

    function _isApprovedOrOwner(address owner, address spender, uint256 id) internal view returns (bool) {
        return (spender == owner || isApprovedForAll[owner][spender] || spender == _approvals[id]);
    }

    function transferFrom(address from, address to, uint256 id) public {
        require(from == _ownerOf[id], "from is not the owner");
        require(to != address(0), "you can not transfer to zero address");
        require(_isApprovedOrOwner(from, msg.sender, id), "not authorized");
        _balanceOf[from]--;
        _balanceOf[to]++;
        _ownerOf[id] = to;
        delete _approvals[id];
        emit Transfer(from, to, id);
    }

    function safeTransferFrom(address from, address to, uint256 id) public {
        transferFrom(from, to, id);
        require(
            to.code.length == 0
                || IERC721Receiver(to).onERC721Received(msg.sender, from, id, "")
                    == IERC721Receiver.onERC721Received.selector,
            "unsafe recipient"
        );
    }

    function safeTransferFrom(address from, address to, uint256 id, bytes calldata data) external {
        transferFrom(from, to, id);
        require(
            to.code.length == 0
                || IERC721Receiver(to).onERC721Received(msg.sender, from, id, data)
                    == IERC721Receiver.onERC721Received.selector,
            "unsafe recipient"
        );
    }

    function _mint(address to, uint256 id) internal {
        require(to != address(0), "mint to zero address");
        require(_ownerOf[id] == address(0), "already minted");

        _balanceOf[to]++;
        _ownerOf[id] = to;

        emit Transfer(address(0), to, id);
    }

    function _burn(uint256 id) internal {
        address owner = _ownerOf[id];
        require(owner != address(0), "not minted");

        _balanceOf[owner] -= 1;

        delete _ownerOf[id];
        delete _approvals[id];

        emit Transfer(owner, address(0), id);
    }
}
