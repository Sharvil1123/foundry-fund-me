// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";

import {FundMe} from "./src/FundMe.sol";

contract FundMeTest is Test {
    // uint256 number = 1;
    FundMe fundMe; // declared new variable for contract.

    function setUp() external {
    //   us -->  FundMeTest --> FundMe
        fundMe = new FundMe(); // deploying a new contract
    //   type   variable      contract
        
        
        // number = 2;
    } // setup function runs first in the tests

    // function testDemo() public view {
    //     // console.log(number);
    //     // console.log("Hello world!");
    //     // assertEq(number, 2);
    // } 

    function testMinimumDollarIsFive() public view {
       assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        console.log(fundMe.i_owner());
        console.log(msg.sender);
        console.log(address(this));
        assertEq(fundMe.i_owner(),address(this)); // here the fundMe owner is checked whether it is equal to msg.sender;
    }// it is showing error because we are not the owner, the owner is fundMe contract. 
    // so to change that we can check the owner in that contract by using address(this) FundMeTest should be the owner!

    function testPriceFeedVersionIsCorrect() public view {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
         // this is not passing the test as the transcation is reverting.
         // the reason is because we are calling an contract address that doesn't exist
         // the anvil gets a new blank chain for the contract so the address won't match.
         // to overcome this problem, we need to pass the rpc url to specift the chain.abilities
         // foundry runs a new chain for new test phase and deletes after that test cases have finished.
    } 

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert(); // this cheatcode is used to revert the next line, that is it should fail.
        fundMe.fund(); // sends 0 and the transaction will fail and test will pass.
    }
}

// here further the modular testing or modular deployment is done where the values are not hard quoted, they are
// fetched from functions or global variables or env variables.