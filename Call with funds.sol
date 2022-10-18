// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract A {
    uint256 a;

    function setA(uint _a) public payable {
        require(msg.value != 0);
        a = _a;
    }

    function getA() public view returns(uint256) {
        return a;
    }
}


contract B {
    A public a;
    uint public ans;

    constructor() {
        a = new A();
    }

    receive() external payable{}

    /// @dev    Use this when you know the address and the function to call, 
    ///         but no contract source code imported.
    function set(uint _a) public {
        (bool sent, ) = address(a).call{value: 1}(
            abi.encodeWithSignature(
                "setA(uint256)",
                _a
            )
        );

        sent;
    }

    /// @dev Use this when you have the contract deployed by you and the source code imported.
    function set2(uint _a) public {
        a.setA{value: 1}(_a);
    }

    /// @dev Use this when the contract is deployed somewhere else but you have the source code.
    function set3(address _A, uint _a) public {
        A(_A).setA{value: 1}(_a);
    }

    function get() public {
        (bool sent, bytes memory data) = address(a).call(
            abi.encodeWithSignature(
                "getA()"
            )
        );

        require(sent);

        ans = abi.decode(data, (uint256));
    }
}
