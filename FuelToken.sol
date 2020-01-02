pragma solidity ^0.4.24;

import "./ERC223.sol";
import "./SafeMath.sol";

contract FuelToken is ERC223Token {
    using SafeMath for uint256;
    string public name = "Fuel Token";
    string public symbol = "FUEL";
    uint public decimals = 18; // any reason to use less?
    uint public totalSupply = 0;
    
    event Mint(address miner, uint reward);
    
    function mint(){
        bytes memory empty; // used for Event emit

        require(block.coinbase == msg.sender);// only valid if the address minting this specific block calls this method which they can do for free
        uint256 reward = block.difficulty;
        balances[msg.sender] += reward;
        totalSupply += reward;
        
        emit Transfer(0x0, msg.sender, reward);
        emit ERC223Transfer(0x0, msg.sender, reward, empty);
        emit Mint(msg.sender, reward);
        // following https://www.saturn.network/blog/how-to-create-a-token-and-ico-on-ethereum-classic-tutorial/ for contract style and format
    }
}

  

