pragma solidity ^0.5.0;

contract ERC20Basic {
  function totalSupply() public view returns (uint256);
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}

contract ERC20 is ERC20Basic {
  function allowance(address owner, address spender) public view returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract DevCashBountyCreator{
    address DCASH = 0x0fca8Fdb0FB115A33BAadEc6e7A141FFC1bC7d5a;

    function newSingleBounty(uint _amount) public{
        SingleBounty S = new SingleBounty();
        ERC20(DCASH).transferFrom(msg.sender,address(S),_amount);
    }
}

contract SingleBounty{
    address BountyHunter;
    address Issuer;
    string submission;
    address DCASH = 0x0fca8Fdb0FB115A33BAadEc6e7A141FFC1bC7d5a;

    constructor() public {
        Issuer = tx.origin;
    }

    function approve() public{
        require(msg.sender==Issuer);
        uint balance = ERC20(DCASH).balanceOf(address(this));
        ERC20(DCASH).transfer(BountyHunter,balance);
    }

    function claim(string memory _submission) public {
        require(msg.sender == BountyHunter);
        submission = _submission;
    }
}

/*
contract MultiBounty{
    mapping(address=>string) public BountyHunters;
    address[] public BountyHunterList;
    address Issuer;
    address DCASH = 0x0fca8Fdb0FB115A33BAadEc6e7A141FFC1bC7d5a;
    uint numBounties;

    constructor() public {
        Issuer = tx.origin;
    }

    function approve(address BountyHunter) public{
        require(msg.sender==Issuer);
        uint balance = ERC20(DCASH).balanceOf(address(this));
        ERC20(DCASH).transfer(BountyHunter,balance);
    }

     function claim(string memory _response) public {
        //require(responses[msg.sender]=="");
        BountyHunterList.push(msg.sender);
    }
}*/
