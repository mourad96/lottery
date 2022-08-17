// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract lottery is Ownable{
    using SafeMath for uint;
    event ev_deposit_token(uint _token_value);

    address public  myTokenAddress;
    address winner_address;
    uint value;
    uint number_of_players;
    uint number_of_depositors;
    struct player{
        address player_address;
        uint deposit_amount;
    }
    player[] public players;
    mapping(address => uint) address_to_deposit_amount;

    constructor (address _myTokenAddress){
        require(_myTokenAddress != address(0), "invalid address");
        myTokenAddress = _myTokenAddress;
        number_of_players = 2;
    }
    function setMyTokenAddress(address _myTokenAddress) public onlyOwner {
        myTokenAddress = _myTokenAddress;
    }
    //sets the number of players that will enter the lottery
    function set_number_of_players(uint _number_of_players)public onlyOwner{
        require(_number_of_players > 1);
        number_of_players = _number_of_players;
    }

    function deposit_token(uint _token_value)public{
        require(_token_value > 0, "deposit amount should be greater than zero");
        (bool success,) = myTokenAddress.call(abi.encodeWithSignature("approve(address, uint256)",address(this),_token_value));
        require(success,"approve Token failed");
        (success,) = myTokenAddress.call(abi.encodeWithSignature("transferFrom(address, address, uint256)",msg.sender,address(this),_token_value));
        require(success,"transfer Token failed");
        //I should add a mutex here
        address_to_deposit_amount[msg.sender]= address_to_deposit_amount[msg.sender].add(_token_value);
        number_of_depositors = number_of_depositors.add(1);
        emit ev_deposit_token(_token_value);
    }

    function excute()public{
        //verify number of players 
        require(number_of_depositors == number_of_players, "not enough player has deposited tokens" );
        //choose random address
        //transfer all token to the winner
        // init all account to zero
    }
}