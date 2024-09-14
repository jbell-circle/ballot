// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Ballot} from "../src/Ballot.sol";

contract BallotScript is Script {
    Ballot public ballot;

    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("BALLOT_DEPLOYER_PRIVATEKEY");
        vm.startBroadcast(deployerPrivateKey);

        bytes32[] memory proposals = new bytes32[](3);
        proposals[0] = bytes32("prop0");
        proposals[1] = bytes32("prop1");

        ballot = new Ballot(proposals);

        vm.stopBroadcast();
    }
}
