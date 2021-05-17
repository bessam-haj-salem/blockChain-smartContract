//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm {
    // all codes here..
    string public name = "DApp Token Farm"; // state variable stored in the BC
     address public owner;
    DappToken public dappToken; //save them here so we can access the adress of smart contracts outside the constructor
    DaiToken public daiToken;
   

    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DappToken _dappToken, DaiToken _daiToken ) {
        dappToken = _dappToken;
        daiToken = _daiToken;
        owner = msg.sender;
    }

    // Stakes Tokens (Deposit)
    function stakeTokens(uint _amount) public { // uint: integer type
    // require amount greater than 0
    require(_amount > 0, "amount cannot be 0");
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
    //  Unstaking Tokens (Withdraw)
    function unstakeTokens() public {
        // fetch staking balance
        uint balance = stakingBalance[msg.sender];
        // require amount greater than 0
        require(balance > 0, "staking balance cannot be 0");
        // transfer Mock Dai tokens to this contract for staking
        daiToken.transfer(msg.sender, balance );

        // reset the staking balance
        stakingBalance[msg.sender] = 0;

        // update staking status
        isStaking[msg.sender] = false;
        
    }
    //  Issuing Tokens (earning interest)
        function issueTokens() public {
            // only owner can call this function
            require(msg.sender == owner,"caller must be the owner" );
            // Issue tokens to all stakers
            for(uint i=0; i<stakers.length;i++) {
               address recipient=  stakers[i];
               uint balance = stakingBalance[recipient];
               if(balance > 0) {
               dappToken.transfer(recipient,balance);
               }
            }
        }

    

    





}