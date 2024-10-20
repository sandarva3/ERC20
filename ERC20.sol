pragma solidity ^0.8.28;

interface Token{
    function totalSupply() external view returns(uint256);
    function balanceOf(address _account) external  view returns(uint256);
    function allowance(address _owner, address _spender) external view returns(uint256); //To view how much token of owner is allowed for spender to use.

    function transfer(address _receiver, uint256 amount) external returns(bool);
    function approve(address _receiver, uint256 _amount) external returns(bool);
    function transferFrom(address _sender, uint256 _amount, address _receiver) external returns(bool);


    event Transfer(address indexed _sender, uint256 indexed _amount, address indexed _receiver);
    event Approve(address indexed _owner, uint256 indexed _amount, address indexed _spender);
}


contract myToken is Token{
    using SafeMath for uint256;

    string public name_;
    string public symbol_;
    uint8 public decimals_;
    uint256 public totalSuply_;

    mapping(address => uint256) balanceOf_;
    mapping(address => mapping(address => uint256)) allowed_;


    constructor(){
        name_ = "myToken1";
        symbol_ = "MY";
        decimals_ = 10;
        totalSupply_ = 30000000000; //It's total wei. total tokens supply = (totalSupply/10**decimals) = 1000;
        balanceOf_[msg.sender] = totalSupply_; //In constructor, 
    }


    function totalSupply() public override view returns(uint256){
        return totalSuply_;
    }

    function balanceOf(address account) public override view returns(uint256){
        return balanceOf_[account];
    }

}