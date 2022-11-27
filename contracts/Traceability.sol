// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

contract Traceability {

    struct Product {
        bytes8 latitude;
        bytes8 longitude;
        bytes8 altitude;
        bytes8 timestamp;
        bytes8 device;
    }

    uint8 private trackNumber = 0;

    mapping(bytes8 => Product) private product;
    Product[] private track;

    event Track(bytes8 _latitude, bytes8 _longitude, bytes8 _altitude, bytes8 _timestamp, bytes8 _device);

    event Length(uint8 _trackNumber);

    event GetDeviceTrack(bytes8 _latitude, bytes8 _longitude, bytes8 _altitude, bytes8 _timestamp, bytes8 _device);


    function trackProduct(string memory _latitude, string memory _longitude, string memory _altitude, string memory _timestamp, string memory _device) public {
        bytes8 _device_ = bytes8(bytes(_device));
        product[_device_] = Product ({ latitude: bytes8(bytes(_latitude)), longitude: bytes8(bytes(_longitude)), altitude: bytes8(bytes(_altitude)), timestamp: bytes8(bytes(_timestamp)), device: bytes8(bytes(_device)) });
        track.push(product[_device_]);
        emit Track(bytes8(bytes(_latitude)), bytes8(bytes(_longitude)), bytes8(bytes(_altitude)), bytes8(bytes(_timestamp)), bytes8(bytes(_device)));
        trackNumber += 1;
    }

    function getLength() public {
        emit Length(uint8 (track.length));
    }

    function getDeviceTrack(string memory _device) public {
        Product memory p = product[bytes8(bytes(_device))];
        require(p.timestamp != 0, "Device not present");
        emit GetDeviceTrack(p.latitude, p.longitude, p.altitude, p.timestamp, p.device);
    }

    function getProductTraceability() public {
        require(track.length > 0, "Untraced product");
        for (uint i = 0; i < track.length; i++) {
            emit GetDeviceTrack(track[i].latitude, track[i].longitude, track[i].altitude, track[i].timestamp, track[i].device);
        }
    }
}