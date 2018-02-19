pragma solidity 0.4.20;
import "./voter.sol";

contract election {
    address registryAddress;
    bytes32 electionTitle;
    
    address[] haveVoted;
    mapping(address => bool) hasVoted;
    
    bytes32[] candidates;
    struct candidateStruct{
        bytes32 name;
        uint numberOfVotes;
    }
    mapping(uint => candidateStruct) candidateInfo;
    
    voter v;
    
    function election(bytes32 _title) public {
        registryAddress = msg.sender;
        electionTitle = _title;
    }
    
    modifier onlyRegistry(){
        if (msg.sender != registryAddress){
            revert();
        }
        _;
    }
    
    function addCandidate(bytes32 _name)  onlyRegistry public{
        uint ID = (candidates.push(_name) - 1);
        candidateInfo[ID].name = _name;
        candidateInfo[ID].numberOfVotes = 0;
    }
    
    function vote(uint candidateID) public{
        v = voter(msg.sender);
        bool eligble = v.checkStatus();
        if (eligble){
            if (hasVoted[msg.sender] == false){
                haveVoted.push(msg.sender);
                candidateInfo[candidateID].numberOfVotes += 1;
                hasVoted[msg.sender] = true;
           }
        }
    }
    
    function numVotes(uint candidateID) view public returns(uint){
        return(candidateInfo[candidateID].numberOfVotes);
    }
    
    function getRegistryAddress() view public returns(address){
        return registryAddress;
    }

}
    