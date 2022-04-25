// SPDX-License-Identifier: MIT
pragma solidity >0.6.0;
import "./Libraries/Strings.sol";

/*
 * @title: Fake Gta, just a play around.
 * @author: Anthony (fps) https://github.com/fps8k .
 * @dev: 
*/


contract GTA
{
    using Strings for string;

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
        string[3] weapons;
        string current_weapon;
        string[3] cars;
        string current_car;
        uint256 value;
        string[3] artifacts;
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

    mapping(string => uint64) private weapon_costs;

    mapping(string => uint64) private free_weapons;



    /*
    * Artifacts mapping. ONLY 3 ARTIFACTS.
    */

    mapping(string => uint64) private artifact_costs;


    /*
    * Car to cost.
    * @dev:
    * Aston Martin = 200 gwei.
    * Lamborghini = 300 gwei.
    * Ferrari = 500 gwei.
    */

    mapping(string => uint64) private car_costs;




    constructor()
    {
        damage["hand"] = 1;
        damage["knife"] = 3;
        damage["gun"] = 5;

        
        weapon_costs["hand"] = 0 gwei;
        weapon_costs["knife"] = 50 gwei;
        weapon_costs["gun"] = 100 gwei;


        artifact_costs["helmet"] = 4 gwei;
        artifact_costs["boots"] = 7 gwei;
        artifact_costs["armour"] = 10 gwei;


        
        car_costs["aston martin"] = 200 gwei;
        car_costs["lamborghini"] = 300 gwei;
        car_costs["ferrari"] = 500 gwei;
    }
    
}