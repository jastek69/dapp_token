// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../node_modules/hardhat/console.sol";

contract Token {
    string public name;
    string public symbol;
    uint256 public decimals = 18; // Hardcoded to 18 Decimals. Not set as Contructor and being kept as a Universal Standard
    uint256 public totalSupply;

    // Track balances
    mapping(address => uint256) public balanceOf; // Mapping creating Key Value Pair of Address and how many Tokens it has
    mapping(address => mapping(address => uint256)) public allowance;  // Nested mapping when placing addres of spender gives another mapping back
                                                                       // returns all the potential spenders AND how many tokens they are approved for
    
    // Send tokens
    event Transfer(     // Transfer Event ERC-20 requirement: https://ethereum.org/en/developers/docs/standards/tokens/erc-20/#events
        address indexed from,
        address indexed to,
        uint256 value
    );
    
    event Approval(     //Approval Event requirement
        address indexed owner,
        address indexed spender,
        uint256 value
    ); 


    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply
    ) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply* (10**decimals); // 1,000,000 x 10^18;
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value)
        public 
        returns (bool success) 
    {
        // Require that sender has enough tokens to spend - ERC20 requirement
        require(balanceOf[msg.sender] >= _value);
        require(_to != address(0));

        // Deduct tokens from spender
        balanceOf[msg.sender] = balanceOf[msg.sender] - _value;

        // Credit tokens to receiver
        balanceOf[_to] = balanceOf[_to] + _value;
        
        //Emit transfer event
        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    function approve(address _spender, uint256 _value) 
        public
        returns(bool success) 
    {
        require(_spender != address(0));

        allowance[msg.sender][_spender] = _value;
        
        emit Approval(msg.sender, _spender, _value);
        return true;  // ERC20 Requirement to return True
    }


}
