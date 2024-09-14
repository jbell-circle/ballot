// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Ballot} from "../src/Ballot.sol";

contract BallotTest is Test {
    Ballot public ballot;

    function setUp() public {
        bytes32[] memory proposals = new bytes32[](3);
        proposals[0] = bytes32("prop0");
        proposals[1] = bytes32("prop1");

        ballot = new Ballot(proposals);
    }

    function test_Vote() public {
        ballot.vote(0);
        assertEq(ballot.getVoteCount(0), 1);
    }

    function test_NoRightToVote_RevertVote() public {
        // Given...
        //  the voter hasn't been given the right to vote
        address voter = address(2);
        vm.startPrank(voter);

        // Expect...
        vm.expectRevert("sender does not have right to vote");

        // When...
        //  the voter tries to vote
        ballot.vote(1);

        vm.stopPrank();
    }

    function test_AlreadyVoted_RevertVote() public {
        // Given...
        //  the voter has the right to vote
        address voter = address(1);
        ballot.giveRightToVote(voter);

        //  the voter has already voted
        vm.startPrank(voter);
        ballot.vote(0);

        // Expect...
        vm.expectRevert("sender has already voted");

        // When...
        //  the voter tries to vote again
        ballot.vote(1);

        vm.stopPrank();
    }
}
