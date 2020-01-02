# FuelToken
Fuel token is an experimental token that rewards hash power to miner of the block chain proportional to the difficulty of the block. 
This is interesting, as the difficulty is proportional to the number of hashes that went into finding a block, and the number of hashes is proportional to the energy spent by the miner with their devices especially with ASIC compatible hashing functions. Each token thereby is proportional to energy and money spent into acquiring the token. This has much different economics from the main token reward for securing the block chain which stays constant as the difficulty of the network increases. 

Bitcoin, Ethereum, Ethereum classic all have an economic incentive that rewards miners very unevely based on when they turn hash power aka energy in Joules aka Money into hash rate, which is then used to dispense monetary rewards and secure the network by making old transactions more expensive and energy intensive to revert. However, within a given year, the hashrate of the network can vary wildly and a miner can expect a very different number of coins that they receive for a given amount of computational power. 

With Fuel token, miners will be rewarded over time with a fixed amount of coins per hash power they provide to the network. This means that they can expect a consistent amount of Fuel tokens over time. This means that this token has special properties that make it a new category.

1. The token is a quasi stable coin in that it is pinned to a specific real world good. Each token can statistically be correlated with  a specific amount of hash power over a specific amount of time. This correlates to Energy usage, albiet with a computational efficiency factor. And the the graph below shows the correlation between energy and cost over decades.

![Retail Energy Costs over decades](https://i.imgur.com/Yy7b9Cv.png)

2. Miners can have easily predictable schedules of being awarded Fuel token over a future time frame and therefore can use Fuel token in DeFi to borrow from lenders in a very predictable way.

Fuel token also has properties that other tokens have like 

1. Use decentralized block chain to open up the token to a liquidy market where miners who produce the supply can interact with traders, speculators and lenders who are looking to earn fees or store value.


The code is very simple and is attached below:

```pragma solidity ^0.4.24;

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

```
