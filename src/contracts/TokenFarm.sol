//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm {
    // all codes here..
    string public name = "DApp Token Farm"; // state variable stored in the BC
    DappToken public dappToken; //save them here so we can access the adress of smart contracts outside the constructor
    DaiToken public daiToken;

    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DappToken _dappToken, DaiToken _daiToken ) {
        dappToken = _dappToken;
        daiToken = _daiToken;
    }

    // 1. Stakes Tokens (Deposit)
    function stakeTokens(uint _amount) public { // uint: integer type

        //transfer Mock Dai tokens to this contract for shaking
        daiToken.transferFrom(msg.sender, address(this), _amount);

        // update staking balance:
        stakingBalance[msg.sender] += _amount;

        // Add user to stakers array *only* if they haven't staked already
        if(!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        // update staking status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] =true;
    }

    // 2. Unstaking Tokens (Withdraw)

    // 3. Issuing Tokens (earning interest)





}