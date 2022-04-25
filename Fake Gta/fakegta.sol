// SPDX-License-Identifier: MIT
pragma solidity >0.6.0;
import "./Libraries/Strings.sol";

/*
 * @title: Fake Gta, just a play around.
 * @author: Anthony (fps) https://github.com/fps8k .
 *
 * @dev: Basic game imitation.
*/


contract GTA
{
    using Strings for string;


    // Player state.
    
    enum State
    {
        online,
        offline
    }


    // Basic player information.

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


    // Artifacts on sale.

    mapping(address => mapping(string => uint256)) private artifact_sales;


    // Users.

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


    /*
    * @dev:
    *
    * When players release their weapons, it appears here, and pepole can take it for free.
    *
    */

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




    function exists(address _address) private view returns(bool)
    {
        return(users[_address].user_id != address(0));

        //Returns true if the address is not a 0 address.
    }




    // Modifier ensuring that the sender is a valid address.

    modifier validSender()
    {
        require(msg.sender != address(0), "!Address");
        _;
    }




    // Returns true when an item is in an array.

    function isInArray(string memory _key, string[] memory _arr) private pure returns(bool)
    {
        for(uint8 i = 0; i < _arr.length; i++)

            if (_arr[i].equal(_key))

                return true;



        return false;
    }
    
    
    
    
    // Registers a new player

    function register(string memory _username) public validSender
    {
        require(!exists(msg.sender), "Already registered.");
        
        Info memory new_info = Info(
            msg.sender,
            _username,
            100,
            ["hand", "", ""],
            "hand",
            ["", "", ""],
            "",
            0,
            ["", "", ""],
            "",
            State.online
        );

        users[msg.sender] = new_info;
    }




    /*
    * @dev:
    *
    * Sets the `_weapon` as the current weapon.
    *
    * C O N D I T I O N S :
    *
    * The sender exists.
    * The current weapon isn't the `_weapon` passed.
    */

    function changeWeapon(string memory _weapon) public validSender
    {
        require(exists(msg.sender), "!Registered.");
        
        Info memory info = users[msg.sender];
        string[] memory existing_weapons = new string[](3);
        
        existing_weapons[0] = info.weapons[0];
        existing_weapons[1] = info.weapons[1];
        existing_weapons[2] = info.weapons[2];
        
        require(!_weapon.equal(info.current_weapon), "Current weapon");
        require(isInArray(_weapon, existing_weapons), "Item !in Kit");

        users[msg.sender].current_weapon = _weapon;
    }




    /*
    * @dev:
    *
    * Reduces health by the value of the current weapon used.
    * Victim and striker must exist.
    * Victim and strker are not empty addresses.
    * Victim health must be > 0.
    * If victim health <= 0, the victim is dead.
    */

    function strike(address _victim) public validSender
    {
        require(exists(msg.sender), "!Registered");
        require(_victim != address(0), "!Address");
        require(exists(_victim), "!Victim Registered");


        Info memory victim_info = users[_victim];
        uint8 _victim_health = victim_info.health;
        address _victim_id = victim_info.user_id;

        
        require(msg.sender != _victim_id, "!Hurt Yourself");
        require(_victim_health > 0, "Victim dead");


        Info memory striker_info =  users[msg.sender];
        uint8 striker_weapon_damage = damage[striker_info.current_weapon];

        if ((_victim_health - striker_weapon_damage) <= 0)
        {
            users[_victim].health = 0;
            users[_victim].weapons = ["hand", "", ""];
        }
        else
        {
            users[_victim].health -= striker_weapon_damage;
        }
    }




    /*
    *
    */

    function refill() public validSender payable
    {
        require(exists(msg.sender), "!Registered");
        require(msg.value >= 100000000 gwei, "Min == 0.5ETH");

        Info memory info = users[msg.sender];
        
        string[] memory existing_artifacts = new string[](3);
        
        existing_artifacts[0] = info.artifacts[0];
        existing_artifacts[1] = info.artifacts[1];
        existing_artifacts[2] = info.artifacts[2];

        if(isInArray("armour", existing_artifacts))
            users[msg.sender].health = 200;
        else
            users[msg.sender].health = 100;
    }

}