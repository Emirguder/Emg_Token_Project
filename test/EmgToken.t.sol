// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {EmgToken} from "../src/EmgToken.sol";

contract EmgTokenTest is Test {
    EmgToken public token;

    // Fake accounts for testing
    address public hacker = address(0xBAD);
    address public user = address(0x1337);
    address public user2 = address(0x222);

    function setUp() public {
        // We deploy the test contract as the owner
        token = new EmgToken();
    }

    // 1. STATE TEST: Has ıt been established correctly? (name, symbol)
    function test_NameAndSymbol() public view {
        assertEq(token.name(), "EmgToken");
        assertEq(token.symbol(), "EMG");
    }

    // 2. Logic TEST: Can people buy it at the right price?
    function test_BuyTokenSuccess() public {
        vm.deal(user, 1 ether); // Give the test user 1 ETH for free

        vm.prank(user); // Make the next transaction as a user
        token.buyToken{value: 0.1 ether}(); // Pay 0.1 ETH for the first token

        assertEq(token.ownerOf(0), user); // did the token with id 0 transfer to the user?
    }

    // 3. REVERT TEST: Does it give an error if insufficient ETH is sent?
    function test_RevertWhen_WrongEthAmount() public {
        vm.deal(user, 1 ether);

        // we expect a revert when we send the wrong amount of ETH
        vm.expectRevert("Yanlis ETH miktari gonderildi");

        vm.prank(user);
        token.buyToken{value: 0.05 ether}();
    }

    // 4. ACCESS CONTROL TEST: Can an unauthorized person mint tokens for free?
    function test_RevertWhen_NonOwnerMints() public {
        // OZ v5 Catching Custom Error : OwnableUnauthorizedAccount(address)
        vm.expectRevert(abi.encodeWithSignature("OwnableUnauthorizedAccount(address)", hacker));

        vm.prank(hacker);
        token.safeMint(hacker);
    }

    // 5. FUZZING TEST: Try safeMint function with random addresses (except 0x0 and contract addresses)
    function testFuzz_SafeMint(address randomUser) public {
        // Filter 0x0 adress and smart contract addresses
        vm.assume(randomUser != address(0));
        uint256 codeSize;
        assembly { codeSize := extcodesize(randomUser) }
        vm.assume(codeSize == 0);

        // we mint to an adress that is genarated randomly
        token.safeMint(randomUser);

        // Did the token reach this address corectly?
        assertEq(token.ownerOf(0), randomUser);
    }

    // 6. constant price test: Does the price remain constant at 0.1 ETH for each token?
    function test_BuyTokenFixedPrice() public {
        vm.deal(user1, 1 ether);
        vm.deal(user2, 1 ether);

        // 1. user buying (ID: 0)
        vm.prank(user1);
        token.buyToken{value: 0.1 ether}();
        assertEq(token.ownerOf(0), user1);

        // 2. user buying (ID: 1). Price remains constant, still 0.1 ETH!
        vm.prank(user2);
        token.buyToken{value: 0.1 ether}();
        assertEq(token.ownerOf(1), user2);
    }
}
