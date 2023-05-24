pragma solidity ^0.8.7;

contract TimeLockedContract{
     address  payable public beneficiary;
     uint public amount;
     uint public releaseTime;

     constructor(address payable _beneficiary , uint _releaseTime){
         beneficiary = _beneficiary;
         releaseTime = _releaseTime;
     }

     function deposit() external payable{
         require(msg.value > 0 , "Invalid amount");
         amount += msg.value;
     }

     function withdraw() external payable{
         require(msg.sender == beneficiary , "Unauthorized");
         require(block.timestamp >=releaseTime , "Funds are locked");

         uint balance = address(this).balance;
         require(balance>0 , "No funds available");

        // Entire balance is transferred to the beneficiary and the amount is reset to 0.
         amount =0;
         beneficiary.transfer(balance);
     }

     function getBalance() external view returns(uint){
         return address(this).balance;
     }
     
}