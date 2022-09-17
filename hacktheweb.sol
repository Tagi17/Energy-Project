// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract renewableEnergy is Ownable, ERC20 {

    constructor() ERC20("CarbonCredits", "CRBN") { }
    mapping(uint => claim) claimNumberToClaim;
    mapping(address => bool) isInspector;
        //counter needs to be reworked to be more safe 
        uint totalClaims;

    // if claimType is 0, it means solar
    // if claimType is 1, it means wind
    // if claimType is 2, it means water
    // if claimType is 3, it means geoThermal

    struct claim {
        address claimant;
        uint claimNumber;
        uint claimType;
        bool inspectorApproved;
        bool governmentApproved;
    }

    function createClaim(uint _claimType) public {
        //create instance for claimNumber 
        uint _claimNumber = totalClaims++;
        //make totalClaims the instance number 
        totalClaims = _claimNumber;
        //create instance of claim Struct 
        claim memory newClaim = claim(msg.sender,_claimNumber,_claimType,false,false);
        //assign claim to _claimNumber
        claimNumberToClaim[_claimNumber] = newClaim;
    }

    function setInspector (address _newInspector) public onlyOwner {
        isInspector[_newInspector] = true;
    }

    function setApproval (uint _claimNumber) public onlyInspector {
        claimNumberToClaim[_claimNumber].inspectorApproved = true;
    }
    
    function govApproval(uint _claimNumber) public onlyOwner{
        if (claimNumberToClaim[_claimNumber].inspectorApproved == true && claimNumberToClaim[_claimNumber].claimType == 0){
            _mint(claimNumberToClaim[_claimNumber].claimant, 100);
        }
        else if (claimNumberToClaim[_claimNumber].inspectorApproved == true && claimNumberToClaim[_claimNumber].claimType == 1){
            _mint(claimNumberToClaim[_claimNumber].claimant, 200);
        }
        else if (claimNumberToClaim[_claimNumber].inspectorApproved == true && claimNumberToClaim[_claimNumber].claimType == 2){
            _mint(claimNumberToClaim[_claimNumber].claimant, 300);
        }
        else if (claimNumberToClaim[_claimNumber].inspectorApproved == true && claimNumberToClaim[_claimNumber].claimType == 3){
            _mint(claimNumberToClaim[_claimNumber].claimant, 400);
        }
    }
    modifier onlyInspector() {
        require(isInspector[msg.sender] == true);
        _;
    }
}
    contract taxes{
        mapping(address => Person) addresstoPerson;

        struct Person{
            uint balance;
        }
        function createPerson () public {
            Person memory setTo1000 = Person(1000);
            addresstoPerson[msg.sender] = setTo1000;
        }
        function setBalance(address user, uint amount) internal {
            addresstoPerson[user].balance = amount; 
        } 
        function getBalance(address user) public view returns (uint) {
            return addresstoPerson[user].balance;
        }
        function redeemCredits () public {
            
        }
    }
    
