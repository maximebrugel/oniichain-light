// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {OniiChain} from "../src/OniiChain.sol";
import {OniiChainDescriptor} from "../src/OniiChainDescriptor.sol";

contract Tests is Test {
    uint256 public constant TEAM_SUPPLY = 100;

    OniiChain public oniiChain;
    OniiChainDescriptor public oniiChainDescriptor;

    /* -------------------------------------------------------------------------- */
    /*                                    SETUP                                   */
    /* -------------------------------------------------------------------------- */

    function setUp() public {
        oniiChainDescriptor = new OniiChainDescriptor();
        oniiChain = new OniiChain(address(oniiChainDescriptor), TEAM_SUPPLY);
    }

    /* -------------------------------------------------------------------------- */
    /*                                    TESTS                                   */
    /* -------------------------------------------------------------------------- */
    function testCannotDeployZeroFund() public {
        oniiChainDescriptor = new OniiChainDescriptor();
        vm.expectRevert("ZERO_FUND_SIZE");
        oniiChain = new OniiChain(address(oniiChainDescriptor), 0);
    }

    function testCannotDeployMaxSupply() public {
        oniiChainDescriptor = new OniiChainDescriptor();
        vm.expectRevert("MAX_SUPPLY_FUND_SIZE");
        oniiChain = new OniiChain(address(oniiChainDescriptor), 10_001);
    }

    function testAfterDeploy() public {
        assertEq(oniiChain.totalSupply(), TEAM_SUPPLY);
    }
}
