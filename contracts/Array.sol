// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

contract Array {

    string[] letters;

    function add(string memory word) public {
        letters.push(word);
    }

    function getLenght() public view returns (uint) {
        return letters.length;
    }

}