pragma solidity 0.4.20;

contract voter{
    
    bytes32 name;
    bytes32 dob;
    bytes32 residence;
    address registryAddress;
    bool canVote;
    
    
    function voter(bytes32 _name, bytes32 _dob, bytes32 _residence) public{
        name = _name;
        dob = _dob;
        residence = _residence;
        canVote = false;
        registryAddress = msg.sender;
        
    }
    
    modifier onlyRegistry(){
        if (msg.sender != registryAddress){
            revert();
        }
        _;
    }
    
    function newResidence(bytes32 _newResidence) onlyRegistry public{
        residence = _newResidence;
    }
    
    function changeVotingStatus() onlyRegistry public{
        if (canVote){
            canVote = false;
        }else{
            canVote = true;
        }
    }
    
    function checkStatus() view public returns(bool){
        return canVote;
    }
}