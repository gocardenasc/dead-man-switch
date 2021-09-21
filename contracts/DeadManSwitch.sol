// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title DeadManSwitch
 * @dev Implements inheritance process
 */
contract DeadManSwitch {
    
    address deadMan;
    uint256 dayOfTheDead;
    address payable beneficiary;
    
    
    /** 
     * @dev Set beneficiary, benefactor and initila expiration date.
     * @param initialBeneficiary address of the first beneficiary
     */
    constructor(address initialBeneficiary) payable {
        deadMan = msg.sender;
        dayOfTheDead = block.timestamp + 365 days;
        beneficiary = payable(initialBeneficiary);
    }
    
    function deposit() public payable{}
    
    /** 
     * @dev extents expiration time 1 year.
     */
    function postponeDeath () external{
        require (deadMan == msg.sender);
        dayOfTheDead += 365 days; 
    } 
    
    /** 
     * @dev Update the beneficiary's address.
     * @param newBeneficiary address of the new beneficiary
     */
    function changeBeneficiary(address newBeneficiary) external{
        require (deadMan == msg.sender);
        beneficiary = payable(newBeneficiary);
    }
    
    /** 
     * @dev Allows to transfer the balance to the beneficiary account if the contract has expired.
     */
    function claimInheritance () external {
        require (block.timestamp >= dayOfTheDead, "I'm not dead yet");
        selfdestruct(beneficiary);
    }
    
    /** 
     * @dev Shows if the contract hasn't expired
     */
    function isAlive () external view returns (bool){
        return block.timestamp < dayOfTheDead;
    }
    
    /** 
     * @dev Shows if the caller is beneficiary
     */
    function isBeneficiary () external view returns (bool){
        return beneficiary == msg.sender;
    }
    
    function getBalance() external view returns (uint256){
        return address(this).balance;
    }
}