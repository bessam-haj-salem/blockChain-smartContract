//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm {
    // all codes here..
    string public name = "Dapp Token Farm"; // state variable stored in the BC
    DappToken public dappToken; //save them here so we can access the adress of smart contracts outside the constructor
    DaiToken public daiToken;

    constructor(DappToken _dappToken, DaiToken _daiToken ) {
        dappToken = _dappToken;
        daiToken = _daiToken;
    }





}