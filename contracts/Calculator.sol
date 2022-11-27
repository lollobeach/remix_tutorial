// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

contract Calculator {

    int256[] array;

    function sum(int256 a, int256 b) public {
        int256 c = a+b;
        array.push(c);
    }

    function dif(int256 a, int256 b) public {
        array.push(a-b);
    }

    function mol(int256 a, int256 b) public {
        array.push(a*b);
    }

    //  both 'revert' and 'require' allow us
    // to handle error
    function div(int256 a, int256 b) public {
//        if (b == 0)
//            revert ("Input not valid! It must be != 0");
        require (
            b != 0,
            "Input not valid! It must be != 0"
        );
        array.push(a/b);
    }

    function get(uint256 index) public view returns (int256) {
        return (array[index]);
    }
}