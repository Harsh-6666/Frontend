// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract Assessment {
    address payable public owner;
    uint256 public Temperature;

    event Increase_temp(uint256 temp);
    event Decrease_temp(uint256 temp);

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        Temperature = initBalance;
    }

    function getBalance() public view returns(uint256){
        return Temperature;
    }

    function Increase_Temp(uint256 _temp) public payable {
        uint _Previoustemperature = Temperature;

        // make sure this is the owner
        require(msg.sender == owner, "You are not the owner of this account");

        // perform transaction
        Temperature += _temp;

        // assert transaction completed successfully
        assert(Temperature == _Previoustemperature + _temp);

        // emit the event
        emit Increase_temp(_temp);
    }

    // custom error
    error Invalid_temp(uint256 Temperature, uint256 Decreasetemperature);

    function Decrease_Temp(uint256 _Decreasetemperature) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint _Previoustemperature = Temperature;
        if (Temperature < _Decreasetemperature) {
            revert Invalid_temp({
                Temperature: Temperature,
                Decreasetemperature: _Decreasetemperature
            });
        }

        // Decrease_temp the given temp
        Temperature -= _Decreasetemperature;

        // assert the Temperature is correct
        assert(Temperature == (_Previoustemperature - _Decreasetemperature));

        // emit the event
        emit Decrease_temp(_Decreasetemperature);
    }
}
