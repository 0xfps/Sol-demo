// SPDX-License-Identifier: MIT
pragma solidity >0.6.0;

import "./Interfaces/IERC20.sol";
import "./Libraries/PureMath.sol";

/*
 * @title: Aguia 2.0 ($AGU) An re-write of the ERC-20 token, $AGU ref[].
 * @author: Anthony (fps) https://github.com/fps8k .
 * @dev: 
*/

// contract Aguia
abstract contract Aguia is IERC20
{
    using PureMath for uint256;


    // Token data.

    string private _name;                                                               // Aguia 2.
    string private _symbol;                                                             // $AGU.
    uint256 private _total_supply;                                                       // 1_000_000.
    uint8 private _decimals;                                                            // 18.


    // Owner address and a mapping of owners that can perform actions with the token.

    // address constant _owner = 0x5e078E6b545cF88aBD5BB58d27488eF8BE0D2593;            // My Ethereum wallet address for production.
    address constant _owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;               // My Fake Remix wallet address for development.
    
    mapping(address => bool) private _approved_owners;


    // Token holders and allowances.

    mapping(address => uint256) public _balances;                                       // Change to private on production.
    
    mapping(address => mapping(address => uint256)) private _allowances;




    // Constructor

    constructor()
    {
        _name = "Aguia 2.0";
        _symbol = "$AGU";
        _decimals = 18;
        _total_supply = 1e9 * (10 ** _decimals);


        // Give the owner all the token.

        _balances[_owner] = _total_supply;
        _approved_owners[_owner] = true;
    }




    function name() public view returns (string memory __name)
    {
        __name = _name;
    }




    function symbol() public view returns(string memory __symbol)
    {
        __symbol = _symbol;
    }




    function decimals() public view returns(uint8 __decimals)
    {
        __decimals = _decimals;
    }




    function totalSupply() public view override returns(uint256 __total_supply)
    {
        __total_supply = _total_supply;
    }




    function exists(address _account) private view returns(bool)
    {
        return _approved_owners[_account];
    }




    /*
    * @dev Returns the amount of tokens owned by `account`.
    */

    function balanceOf(address account) public view override returns(uint256)
    {
        require(msg.sender != address(0), "!Address");
        require(exists(account), "Account !Exists");

        uint256 _balance_of = _balances[account];
        return _balance_of;
    }





    /**
    * @dev Moves `amount` tokens from the caller's account to `to`.
    *
    * Returns a boolean value indicating whether the operation succeeded.
    *
    * Emits a {Transfer} event.
    */

    function transfer(address to, uint256 amount) public override returns(bool)
    {
        require(msg.sender != address(0), "!Address");                              // Sender's address is not 0 address.
        require(exists(msg.sender), "Account !Exists");                             // Sender exists in the records, even if he has 0 tokens.
        require(to != address(0), "Receiver !Address");                             // Receiver isn't 0 address.
        require(amount > 0, "Amount == 0");                                         // Can't send empty token.
        require(_balances[msg.sender] >= amount, "Wallet funds < amount");          // Sender has more than he can send.

        _balances[msg.sender] = _balances[msg.sender].sub(amount);                  // Subtract from sender.
        _balances[to] = _balances[to].add(amount);                                  // Add to receiver.

        emit Transfer(msg.sender, to, amount);

        return true;
    }




    /**
    * @dev Returns the remaining number of tokens that `spender` will be
    * allowed to spend on behalf of `owner` through {transferFrom}. This is
    * zero by default.
    *
    * This value changes when {approve} or {transferFrom} are called.
    */

    function allowance(address owner, address spender) public view override returns(uint256)
    {
        require(msg.sender != address(0), "!Address");
        require(owner != address(0), "!Owner");
        require(spender != address(0), "!Spender");
        require(exists(owner), "!Owner");
        require(exists(spender), "!Spender");
        require(msg.sender == spender, "Can't see allowance for this address");

        uint256 _allowance = _allowances[owner][spender];
        return _allowance;
    }
}