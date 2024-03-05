// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TrevorToken is ERC20, Ownable {
    constructor() public ERC20("Trevor Token", "TRV") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
