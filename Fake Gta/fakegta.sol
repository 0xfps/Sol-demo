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
        string[2] weapons;
        string current_weapon;
        State state;
    }


    // Artifacts on sale.

    mapping(address => mapping(string => uint256)) private artifact_sales;


    // Users.

    mapping(address => Info) public users;

    
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




    constructor()
    {
        damage["hand"] = 1;
        damage["knife"] = 3;
        damage["gun"] = 5;


        weapon_costs["knife"] = 50 gwei;
        weapon_costs["gun"] = 100 gwei;
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

    function register(string memory __username) public validSender
    {
        require(!exists(msg.sender), "Already registered.");
        string memory _username = __username.lower();
        
        Info memory new_info = Info(
            msg.sender,
            _username,
            100,
            ["hand", ""],
            "hand",
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

    function changeWeapon(string memory __weapon) public validSender
    {
        require(exists(msg.sender), "!Registered.");
        require(users[msg.sender].state == State.online, "Offline");
        
        string memory _weapon = __weapon.lower();

        Info memory info = users[msg.sender];
        string[] memory existing_weapons = new string[](3);
        
        existing_weapons[0] = info.weapons[0];
        existing_weapons[1] = info.weapons[1];
        
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
        require(users[msg.sender].state == State.online, "Offline");
        require(users[_victim].state == State.online, "Victim Offline");


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
            users[_victim].weapons = ["hand", ""];
        }
        else
        {
            users[_victim].health -= striker_weapon_damage;
        }
    }




    /*
    * refill() to fill up your health with some eth.
    */

    function refill() public validSender payable
    {
        require(exists(msg.sender), "!Registered");
        require(users[msg.sender].state == State.online, "Offline");
        require(msg.value >= 500 gwei, "Min == 500 gwei");

        users[msg.sender].health = 100;
    }




    /*
    * toggle() toggles between off and online
    */

    function toggle() public validSender
    {
        require(exists(msg.sender), "!Registered");   
        
        if (users[msg.sender].state == State.offline)
            users[msg.sender].state = State.online;
        else
            users[msg.sender].state = State.offline;
    }




    /*
    *
    */

    function buyWeapon(string memory __weapon) public payable validSender
    {
        require(exists(msg.sender), "!Registered");
        require(users[msg.sender].state == State.online, "Offline");

        string memory _weapon = __weapon.lower();

        Info memory info = users[msg.sender];
        string[] memory existing_weapons = new string[](3);
        
        existing_weapons[0] = info.weapons[0];
        existing_weapons[1] = info.weapons[1];

        require(!isInArray(_weapon, existing_weapons), "Already in weapons");

        require(weapon_costs[_weapon] > 0, "!Weapon");
        require(msg.value >= weapon_costs[_weapon], "Knife:: 50 gwei, Gun:: 100gwei");

        users[msg.sender].weapons[1] = _weapon;
        users[msg.sender].current_weapon = _weapon;
    }
}