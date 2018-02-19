pragma solidity 0.4.20;
import "./election.sol";
import "./voter.sol";

contract electionRegistry {
    
    address registryOwner;
    
    address[] registeredVoters;
    mapping(address => bool) public isRegistered;
    
    address[] electionList;
    mapping(uint => address) public getContract;
    
    function electionRegistry() public{
        registryOwner  = msg.sender;
    }
    
    modifier onlyRegistryOwner(){
        if (msg.sender != registryOwner){
            revert();
        }
        _;
    }
    
    function newElection(bytes32 _title) onlyRegistryOwner public{
        address nElection = new election(_title);
        if (nElection == 0x0){revert();}
        uint ID = (electionList.push(nElection) - 1);
        getContract[ID] = nElection;
    }
    
    function getELectionContract(uint ID) view public returns(address){
        return (getContract[ID]);
    }
    
    function addVoter(address _voterAddress) onlyRegistryOwner public{
        if (isRegistered[_voterAddress] == false){
            registeredVoters.push(_voterAddress);
            isRegistered[_voterAddress] = true;
        }
    }
    
    function newVoter(bytes32 _name, bytes32 _dob, bytes32 _residence) onlyRegistryOwner public{
        address nVoter = new voter(_name, _dob, _residence);
        registeredVoters.push(nVoter);
        isRegistered[nVoter] = true;
    }
        
    
}