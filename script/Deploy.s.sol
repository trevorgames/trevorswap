// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.12 <0.9.0;

import {WETH9} from "../src/mocks/WETH9.sol";
import {UniswapV2ERC20} from "../src/UniswapV2ERC20.sol";
import {UniswapV2Factory} from "../src/UniswapV2Factory.sol";
import {UniswapV2Router02} from "../src/UniswapV2Router02.sol";

import {BaseScript} from "./Base.s.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    UniswapV2Factory internal factory;
    UniswapV2Router02 internal router02;
    address internal WNATIVE_ADDRESS;

    function run() public broadcast returns (UniswapV2Factory, UniswapV2Router02) {
        factory = new UniswapV2Factory(broadcaster);

        uint256 chainId;
        assembly {
            chainId := chainid()
        }

        WNATIVE_ADDRESS = vm.envOr({name: "WNATIVE_ADDRESS", defaultValue: address(0)});
        if (chainId == 31337 || chainId == 1337) {
            WETH9 weth = new WETH9();
            WNATIVE_ADDRESS = address(weth);
        }
        if (WNATIVE_ADDRESS == address(0)) {
            revert("WNATIVE_ADDRESS not set");
        }

        router02 = new UniswapV2Router02(address(factory), WNATIVE_ADDRESS);

        return (factory, router02);
    }
}
