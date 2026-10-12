// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console2} from "forge-std/Script.sol";
import {EmgToken} from "../src/EmgToken.sol";

contract DeployEmgToken is Script {
    function run() external {
        // We never write private keys in the code. Instead, we use environment variables to store them securely.
        vm.startBroadcast();

        EmgToken token = new EmgToken();
        console2.log("EmgToken basariyla deploy edildi. Adres:", address(token));

        vm.stopBroadcast();
    }
}
