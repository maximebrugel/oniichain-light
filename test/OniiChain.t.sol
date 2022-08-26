// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {OniiChain} from "../src/OniiChain.sol";
import {OniiChainDescriptor} from "../src/OniiChainDescriptor.sol";

contract Tests is Test {
    uint256 public constant TEAM_SUPPLY = 100;

    OniiChain public oniiChain;
    OniiChainDescriptor public oniiChainDescriptor;

    address public deployer = address(uint160(uint256(keccak256("deployer"))));

    /* -------------------------------------------------------------------------- */
    /*                                    SETUP                                   */
    /* -------------------------------------------------------------------------- */

    function setUp() public {
        vm.startPrank(deployer);
        oniiChainDescriptor = new OniiChainDescriptor();
        oniiChain = new OniiChain(address(oniiChainDescriptor), TEAM_SUPPLY);
        vm.stopPrank();
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

    function testTokenUriNonExistent() public {
        vm.expectRevert("NOT_MINTED");
        oniiChain.tokenURI(101);
    }

    function testCannotAddLiquidityNotInit() public {
        vm.expectRevert("NOT_INITIALIZED");
        oniiChain.addLiquidity(1);
    }

    function testCannotAddLiquidityZero() public {
        vm.startPrank(deployer);
        oniiChain.initializeSudoPair(address(1));
        vm.stopPrank();

        vm.expectRevert("QTY_ZERO");
        oniiChain.addLiquidity(0);
    }

    function testCannotAddLiquidityLimit() public {
        vm.startPrank(deployer);
        oniiChain.initializeSudoPair(address(1));
        vm.stopPrank();

        vm.expectRevert("MINT_LIMIT");
        oniiChain.addLiquidity(10_000);
    }

    function testAddLiquidity() public {
        vm.startPrank(deployer);
        oniiChain.initializeSudoPair(address(1));
        vm.stopPrank();

        oniiChain.addLiquidity(2);

        assertEq(oniiChain.ownerOf(TEAM_SUPPLY + 1), address(1));
        assertEq(oniiChain.ownerOf(TEAM_SUPPLY + 2), address(1));

        assertEq(oniiChain.totalSupply(), TEAM_SUPPLY + 2);

        vm.expectRevert("NOT_MINTED");
        oniiChain.ownerOf(TEAM_SUPPLY + 3);
    }

    function testAfterDeploy() public {
        assertEq(oniiChain.totalSupply(), TEAM_SUPPLY);
    }
}
