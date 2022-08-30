// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

/**
* @title TryCatch
* @author Anthony (fps) https://github.com/0xfps.
* @dev Lets try to catch.
*/
contract TryCatch {
    error Error(string memory reason);
    
    try IERC1155Receiver(to).onERC1155Received(operator, from, id, amount, data) returns (bytes4 response) {
        if (response != IERC1155Receiver.onERC1155Received.selector) {
            revert("ERC1155: ERC1155Receiver rejected tokens");
        }
    } catch Error(string memory reason) {
        revert(reason);
    } catch {
        revert("ERC1155: transfer to non ERC1155Receiver implementer");
    }
}
