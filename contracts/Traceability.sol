// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

contract Traceability {

    struct Product {
        string latitude;
        string longitude;
        string altitude;
        string timestamp;
        string device;
    }

    uint8 private trackNumber = 0;

    mapping(string => Product) private product;
    Product[] private track;

    event Track(string _latitude, string _longitude, string _altitude, string _timestamp, string _device);

    event Length(uint8 _trackNumber);

    event GetDeviceTrack(string _latitude, string _longitude, string _altitude, string _timestamp, string _device);


    function trackProduct(string memory _latitude, string memory _longitude, string memory _altitude, string memory _timestamp, string memory _device) public {
        string memory _device_ = string(bytes(_device));
        product[_device_] = Product ({ latitude: _latitude, longitude: _longitude, altitude: _altitude, timestamp: _timestamp, device: _device });
        track.push(product[_device_]);
        emit Track(_latitude, _longitude, _altitude, _timestamp, _device);
        trackNumber += 1;
    }

    function getLength() public {
        emit Length(uint8 (track.length));
    }

    function getDeviceTrack(string memory _device) public {
        Product memory p = product[_device];
        require(keccak256(abi.encodePacked(p.timestamp)) != keccak256(abi.encodePacked("")), "Device not present");
        emit GetDeviceTrack(p.latitude, p.longitude, p.altitude, p.timestamp, p.device);
    }

    function getProductTraceability() public {
        require(track.length > 0, "Untraced product");
        for (uint i = 0; i < track.length; i++) {
            emit GetDeviceTrack(track[i].latitude, track[i].longitude, track[i].altitude, track[i].timestamp, track[i].device);
        }
    }
}