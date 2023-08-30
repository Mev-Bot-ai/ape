// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
pragma experimental ABIEncoderV2;


import "contracts/ERC20/IERC20.sol";

contract TestUniswapV3FlashCallback {
    address TOKEN_WETH  = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function uniswapV3FlashCallback(
        uint256,
        uint256,
        bytes calldata data
    ) external {
	uint[] memory amount = abi.decode(data,(uint256[]));
	IERC20(TOKEN_WETH).transfer(msg.sender, amount[0]);
    }

    function testFlash(address pool, uint amount, bool isToken0, bytes memory data) public { 
        uint256 tokenAmount = (amount != 0 && isToken0) ? amount : 0; // Replace the condition based on your needs
        IUniswapV3PoolActions(pool).flash(address(this), tokenAmount, tokenAmount, data);
    }
}

interface IUniswapV3PoolActions {
    function flash(
        address recipient,
        uint256 amount0,
        uint256 amount1,
        bytes calldata data
    ) external;
}
interface IERC20Token {
    function transfer(address _to, uint256 _value) external returns (bool success);
}
