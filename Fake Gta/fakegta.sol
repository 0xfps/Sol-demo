// SPDX-License-Identifier: MIT
pragma solidity >0.6.0;

/*
 * @title: Fake Gta, just a play around.
 * @author: Anthony (fps) https://github.com/fps8k .
 * @dev: 
*/


contract GTA
{

    enum State
    {
        online,
        offline
    }

    struct Info
    {
        address user_id;
        string username;
        uint8 health;
        string[] weapons;
        string current_weapon;
        string[] cars;
        string current_car;
        uint256 value;
        string[] artifacts;
        string current_artifact;
        State state;
    }


    mapping(address => mapping(string => uint256)) private artifact_sales;
    mapping(address => Info) private users;

    
    /*
    * Weapon to damage mapping.
    * @dev:
    * hand = 1.
    * knife = 3.
    * gun = 5.
    */

    mapping(string => uint8) private damage;


    /*
    * Weapon to price mapping.
    * @dev:
    * hand = free, undeletable.
    * knife = 50 gwei.
    * gun = 100 gwei.
    */

    mapping(string => uint32) private costs;
    
}