// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Factory{
    function deploy(address _owner, uint256 _numberTest, bytes32 _salt)public payable returns(address){
        return address(new TestContract{salt: _salt}(_owner, _numberTest));
    }
}

contract TestContract{
    address public owner;
    uint256 public numberTest;

    constructor(address _owner, uint256 _numberTest) payable {
        owner = _owner;
        numberTest = _numberTest;
    }

    function getBalance() public view returns (uint256){
        return address(this).balance;
    }
}