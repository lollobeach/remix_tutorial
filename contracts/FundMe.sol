// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

// implementation data feeds of chainlink
// import the function of chainlink npm package
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
// this contract doesn't allow for that overflow to occur
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe {

    // 'using' keyword is used for including a
    // library within a contract in solidity
    using SafeMathChainlink for uint256;

    mapping(address => uint256) public addressToAmountFounded;
    address[] public funders;
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    // the keyword 'payable' defines 
    // a function that accept payments
    function fund() public payable {
        // set a threshold
        uint256 minimumUSD = 50 * 10 ** 18;
        // it is used instead of 'if'
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!");
        // 'msg.sender' and 'msg.value' are keywords in
        // every contract call and every transaction
        // msg.sender is the sender of the function call and
        // msg.value is how much they sent
        addressToAmountFounded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        // the argument passed is the address price feed of ETH/USD in
        // the Rinkeby chain (https://docs.chain.link/docs/ethereum-addresses/)
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    // this function return the price in wei (1 eth = 1 * 10^18 wei)
    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer * 10000000000); // wei
    }

    // if you pass the argument in wei the result
    // must be divided by 10^18, but if you pass it
    // int gwei it must be divided by 10^9
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }

    // is used to change the behavior
    // of a function in a delcarative way
    modifier onlyOwner {
        // if the semicolon is here 
        // first you execute the other
        // instruction, then you go to
        // this one
        require(msg.sender == owner);
        // this semicolon means that after the
        // execution of the first insturction
        // can execute the successive code
        _;
    }

    function withdraw() payable onlyOwner public {
        // transfer -> is a function that we can call on any address
        // to send eht from one address to another
        // require msg.sender = owner
        msg.sender.transfer(address(this).balance);
        for (uint256 funderIndex=0; funderIndex < funders.lenght; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFounded[funder] = 0;
        }
        funders = new address[](0);
    }

}