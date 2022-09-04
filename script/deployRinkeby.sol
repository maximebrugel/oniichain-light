// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import {OniiChain} from "../src/OniiChain.sol";
import {IDetail} from "../src/interfaces/IDetail.sol";
import {OniiChainDescriptor} from "../src/OniiChainDescriptor.sol";
import {BodyDetail} from "../src/libraries/details/BodyDetail.sol";
import {HairDetail} from "../src/libraries/details/HairDetail.sol";
import {NoseDetail} from "../src/libraries/details/NoseDetail.sol";
import {EyesDetail} from "../src/libraries/details/EyesDetail.sol";
import {MarkDetail} from "../src/libraries/details/MarkDetail.sol";
import {MaskDetail} from "../src/libraries/details/MaskDetail.sol";
import {MouthDetail} from "../src/libraries/details/MouthDetail.sol";
import {EyebrowDetail} from "../src/libraries/details/EyebrowDetail.sol";
import {EarringsDetail} from "../src/libraries/details/EarringsDetail.sol";
import {AccessoryDetail} from "../src/libraries/details/AccessoryDetail.sol";
import {BackgroundDetail} from "../src/libraries/details/BackgroundDetail.sol";

contract DeployRinkeby is Script {
    function run() external {
        vm.startBroadcast();

        OniiChain oniiChain;
        OniiChainDescriptor oniiChainDescriptor;

        oniiChainDescriptor = new OniiChainDescriptor(
            IDetail(address(BodyDetail)),
            IDetail(address(HairDetail)),
            IDetail(address(NoseDetail)),
            IDetail(address(EyesDetail)),
            IDetail(address(MarkDetail)),
            IDetail(address(MaskDetail)),
            IDetail(address(MouthDetail)),
            IDetail(address(EyebrowDetail)),
            IDetail(address(EarringsDetail)),
            IDetail(address(AccessoryDetail)),
            IDetail(address(BackgroundDetail))
        );
        oniiChain = new OniiChain(address(oniiChainDescriptor), 1);

        vm.stopBroadcast();
    }
}
