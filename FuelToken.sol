pragma solidity ^0.4.24;

import "./ERC223.sol";
import "./SafeMath.sol";

contract FuelToken is ERC223Token {
    using SafeMath for uint256;
    string public name = "Fuel Token";
    string public symbol = "FUEL";
    uint public decimals = 18; // any reason to use less?
    uint public totalSupply = 0;
    bytes32 public currentChallenge;
    uint public MINIMUM_TARGET = 2**16;
    uint public MAXIMUM_TARGET = 2**234;
    
    event Mint(address miner, uint reward);

    function mint(uint nonce) public {
        bytes memory empty; // used for Event emit
        uint256 n = uint256(keccak256(abi.encodePacked(nonce, currentChallenge)));
        // check that the minimum difficulty is met
        require(n >= MINIMUM_TARGET, "Minimum difficulty not met.");
        // reward the mining difficulty - the number of zeros on the PoW solution
        uint256 reward = MAXIMUM_TARGET.div(n);
        balances[msg.sender] += reward;
        totalSupply += reward;
        // update the challenge to prevent proof resubmission
        currentChallenge = keccak256(abi.encodePacked(nonce, currentChallenge, blockhash(block.number - 1)));
        
        // Event emmissions
        emit Transfer(0x0, msg.sender, reward);
        emit ERC223Transfer(0x0, msg.sender, reward, empty);
        emit Mint(msg.sender, reward);
    }
}
