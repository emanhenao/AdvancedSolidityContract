pragma solidity ^0.5.5;
import "./Puppercoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

contract PupperCoinCrowdSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {
    constructor(
        uint rate,            
        address payable wallet, 
        PupperCoin token,
        uint goal,
        uint cap,            
        uint openingTime,     
        uint closingTime
    )
        Crowdsale(rate, wallet, token)
        CappedCrowdsale(cap)
        TimedCrowdsale(openingTime, closingTime)
        RefundableCrowdsale(goal)
        public
    {
        
    }
}
contract GoldCoinSaleDeployer {

    address public token_sale_address;
    address public token_address;
    uint goal = 700;
    uint cap = 7000;
  
    constructor(string memory name, string memory symbol, address payable wallet) public {

        PupperCoin token = new PupperCoin(name, symbol, 0);
        token_address = address(token);

        PupperCoinCrowdSale gold_coin = new PupperCoinCrowdSale(1, wallet, token, goal, cap, now, now + 7 minutes);
        token_sale_address = address(gold_coin);
        
        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
}