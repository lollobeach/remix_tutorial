// SPDX-License-Identifier: MIT
//protect from problems with copyright

//pragma solidity >=x.y.z <=a.b.c --> versions that go from x.y.z to a.b.c
//pragma solidity x.y.z --> only this version
//pragma solidity ^0.x.0 --> each version from 0.x.0 to 0.x.9
pragma solidity ^0.6.0;

contract SimpleStorage {

    //uint --> unsigned integer
    //unit256 --> unsigned integer of size 256 bits
    //bool favoriteBool = false;
    //string favoriteString = "String"; --> array of bytes and we can choose if store it in memory o in storage
    //int256 favoriteInt = -5;
    //address favoriteAddress = 0x32Afc9E0Bf5Eee0e8EF35fF7848452F076E2B873; --> address for Rinkeby test network
    //bytes32 favoriteBytes = "cat";
    //uint256 favoriteNumber = 5;

// this will get initialized to 0
    //the keyword 'public' allow us to see this number
    //'internal' is the default state
    //global scope
    //it is view
    uint256 favoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    //it is a dynamic array because it can change the size
    People[] public people;
    mapping(string => uint256) public nameToFavoriteNumber;

    //in solidity there are two ways to store information: in memory or in storage
    //memory -> the information will only be stored during th execution time
    //storage -> the data will persist even after the function
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People({favoriteNumber: _favoriteNumber, name: _name}));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    //People[1] public people; --> its size is fixed

    //People public person = People({favoriteNumber: 2, name: "Patrick"});

    //write a function
    //the keyword 'public' allow us to add an input
    //this function, instead, change the state of the blockchain
    function store(uint256 _favoriteNumber) public {
        //store scope
        favoriteNumber = _favoriteNumber;
    }

    //view, pure -> we want to read some state of the blockchain, so it isn't a transaction
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

}