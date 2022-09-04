// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {OniiChain} from "../src/OniiChain.sol";
import {IDetail} from "../src/interfaces/IDetail.sol";
import {OniiChainDescriptor} from "../src/OniiChainDescriptor.sol";

contract DeployMainnet is Script {
    function run() external {
        vm.startBroadcast();

        OniiChain oniiChain;
        OniiChainDescriptor oniiChainDescriptor;

        oniiChainDescriptor = new OniiChainDescriptor(
            IDetail(address(0x1195625BDF82b53bc66bEe1Fb3634e00b8E8dee5)),
            IDetail(address(0xD3c3A896e0A40cC9E19Bc69B4B1dDE996B13d8B1)),
            IDetail(address(0xB9AadeEd8247488739F32698289360Ad4B37eE93)),
            IDetail(address(0xCb0932f30152eBE52CeDD7cE0172fA190358a33f)),
            IDetail(address(0x62293a77f76c9749e338d40eA87555fE3cd2652D)),
            IDetail(address(0x50Ed8C7b71bBB07265Da43C21B79EAA51F813Ac6)),
            IDetail(address(0x9e9751c841196314355A04fdD0fCDa5293fb1ee7)),
            IDetail(address(0xC1C78967D5C0916D190f09A994B1B89BA6652A47)),
            IDetail(address(0xfEDc04397A9cd49f48815DF2D3b991C0c6398A96)),
            IDetail(address(0xF02C92CE40062e6dFF359143aEdB9CE6961Dd5fA)),
            IDetail(address(0x72a85B0Ca7327579B21a5415389A39171d0d85c8))
        );
        oniiChain = new OniiChain(address(oniiChainDescriptor), 1);

        vm.stopBroadcast();
    }
}
