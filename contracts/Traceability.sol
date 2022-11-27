// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

contract Traceability {

    struct Product {
        bytes8 name;
        uint8 latitude;
        uint8 longitude;
        uint timestamp;
    }

    uint256 private length;

    mapping(bytes8 => Product) private product;

    event Track(bytes8 _name, uint8 _latitude, uint8 _longitude, uint timestamp);

    event Length(uint _length);

    event GetProduct(bytes8 _name, uint8 _latitude, uint8 _longitude, uint timestamp);

    function trackProduct(bytes8 _name, uint8 _latitude, uint8 _longitude, uint8 _timestamp) public {
        require (product[_name].latitude != _latitude && product[_name].longitude != _longitude);
        product[_name] = Product ({ name: _name, latitude: _latitude, longitude: _longitude, timestamp: _timestamp});
        emit Track(_name, _latitude, _longitude, _timestamp);
        length += 1;
    }

    function getLength() public {
        emit Length(length);
    }

    function getProduct(bytes8 _name) public {
        Product memory p = product[_name];
        emit GetProduct(p.name, p.latitude, p.longitude, p.timestamp);
    }
}