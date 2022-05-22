// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

/**
this allow us to deploy SimpleStorage SC
from this SC
'./' -> it means that the SC is in the same
directory
**/
import "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;

    // this function deploy the SimpleStorage and
    // save its in the array
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    // this function, instead, allow us to 
    // interact with SimpleStorage contract
    function sfStore(uint256 _simpleStorageIndex, uint256 _simplestorageNumber) public {
        // address
        // abi
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simplestorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
    }
}