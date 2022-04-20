// SPDX-License-Identifier: MIT
pragma solidity >0.6.0;

import "./Interfaces/IERC20.sol";
import "./Libraries/PureMath.sol";

/*
 * @title: Aguia 2.0 ($AGU) An re-write of the ERC-20 token, $AGU ref[].
 * @author: Anthony (fps) https://github.com/fps8k .
 * @dev: 
*/

abstract contract Aguia is IERC20
{
    using PureMath for uint256;


    // Token data.

    string private _name;                   // Aguia 2.
    string private _symbol;                 // $AGU.
    uint256 private _totalSupply;           // 1_000_000.
    uint8 private decimals;                 // 18.


    // Owner address and a mapping of owners that can perform actions with the token.

    address constant _owner = 0x5e078E6b545cF88aBD5BB58d27488eF8BE0D2593;        // My Ethereum wallet address.
    
    mapping(address => bool) private approved_owner;


    // Token holders and allowances.

    mapping(address => uint256) private _balances;
    
    mapping(address => mapping(address => uint256)) private _allowances;




    // Constructor

    constructor()
    {
        _balances[_owner] = 20e18;
    }
}