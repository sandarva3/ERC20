pragma solidity ^0.8.28;

interface Token{
    function totalSupply() external view returns(uint256);
    function balanceOf(address _account) external  view returns(uint256);
    function allowance(address _owner, address _spender) external view returns(uint256); //To view how much token of owner is allowed for spender to use.

    function transfer(address _receiver, uint256 amount) external returns(bool);
    function approve(address delegate, uint256 _amount) external returns(bool);
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

    function transfer(address receiver, uint256 amount) public override returns(bool){
        require(amount <= balanceOf_[msg.sender]);
        balanceOf_[msg.sender] = balanceOf_[msg.sender].sub(amount);
        balanceOf_[receiver] = balanceOf_[receiver].add(amount);
        emit Transfer(msg.sender, amount, receiver);
        return true;
    }

    function approve(address delegate, uint256 amount) public override{
        allowed_[msg.sender][delegate] = amount;
        emit Approve(msg.sender, amount, delegate);
    }

    function allowance(address owner, address spender) public override view returns(uint256){
        return allowed_[owner][spender];
    }

    function transferFrom(address sender, uint256 amount, uint256 receiver) public override returns(bool){
        require(msg.sender == receiver);
        require(balanceOf_[sender] >= amount);
        require(amount <= allowance(sender, receiver));

        balanceOf_[sender] = balanceOf_[sender].sub(amount);
        allowed_[sender][msg.sender] = allowed_[sender][msg.sender].sub(amount);
        balanceOf_[receiver] = balanceOf_[receiver].add(amount);
        
        emit Transfer(sender, amount, receiver);
        return true;
    }
}

library SafeMath { //No ether transfer by library
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
      assert(b <= a);
      return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
      uint256 c = a + b;
      assert(c >= a);
      return c;
    }
}
