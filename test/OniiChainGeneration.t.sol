// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {OniiChain} from "../src/OniiChain.sol";
import {Strings} from "../src/libraries/Strings.sol";
import {NFTDescriptor} from "../src/libraries/NFTDescriptor.sol";
import {OniiChainDescriptor} from "../src/OniiChainDescriptor.sol";

contract Generation is Test {
    uint256 public constant TEAM_SUPPLY = 1;

    OniiChain public oniiChain;
    OniiChainDescriptor public oniiChainDescriptor;

    /* -------------------------------------------------------------------------- */
    /*                                    SETUP                                   */
    /* -------------------------------------------------------------------------- */

    function setUp() public {
        oniiChainDescriptor = new OniiChainDescriptor();
        oniiChain = new OniiChain(address(oniiChainDescriptor), TEAM_SUPPLY);
        oniiChain.initializeSudoPair(address(this));
        oniiChain.addLiquidity(uint96(oniiChain.MAX_SUPPLY() - TEAM_SUPPLY));
    }

    /* -------------------------------------------------------------------------- */
    /*                                    TESTS                                   */
    /* -------------------------------------------------------------------------- */

    function testMassPreview1() public {
        for (uint256 i = 1; i <= 1000; ++i) {
            vm.writeFile(
                string(
                    abi.encodePacked(
                        "generations/onii_",
                        Strings.toString(i),
                        ".svg"
                    )
                ),
                oniiChainDescriptor.getSVG(i)
            );
        }
    }

    function testMassPreview2() public {
        for (uint256 i = 1001; i <= 2000; ++i) {
            vm.writeFile(
                string(
                    abi.encodePacked(
                        "generations/onii_",
                        Strings.toString(i),
                        ".svg"
                    )
                ),
                oniiChainDescriptor.getSVG(i)
            );
        }
    }

    function testMassPreview3() public {
        for (uint256 i = 2001; i <= 3000; ++i) {
            vm.writeFile(
                string(
                    abi.encodePacked(
                        "generations/onii_",
                        Strings.toString(i),
                        ".svg"
                    )
                ),
                oniiChainDescriptor.getSVG(i)
            );
        }
    }

    function testMassPreview4() public {
        for (uint256 i = 3001; i <= 4000; ++i) {
            vm.writeFile(
                string(
                    abi.encodePacked(
                        "generations/onii_",
                        Strings.toString(i),
                        ".svg"
                    )
                ),
                oniiChainDescriptor.getSVG(i)
            );
        }
    }

    function testMassPreview5() public {
        for (uint256 i = 4001; i <= 5000; ++i) {
            vm.writeFile(
                string(
                    abi.encodePacked(
                        "generations/onii_",
                        Strings.toString(i),
                        ".svg"
                    )
                ),
                oniiChainDescriptor.getSVG(i)
            );
        }
    }

    function testMassPreview6() public {
        for (uint256 i = 5001; i <= 6000; ++i) {
            vm.writeFile(
                string(
                    abi.encodePacked(
                        "generations/onii_",
                        Strings.toString(i),
                        ".svg"
                    )
                ),
                oniiChainDescriptor.getSVG(i)
            );
        }
    }

    function testMassPreview7() public {
        for (uint256 i = 6001; i <= 7000; ++i) {
            vm.writeFile(
                string(
                    abi.encodePacked(
                        "generations/onii_",
                        Strings.toString(i),
                        ".svg"
                    )
                ),
                oniiChainDescriptor.getSVG(i)
            );
        }
    }

    function testMassPreview8() public {
        for (uint256 i = 7001; i <= 8000; ++i) {
            vm.writeFile(
                string(
                    abi.encodePacked(
                        "generations/onii_",
                        Strings.toString(i),
                        ".svg"
                    )
                ),
                oniiChainDescriptor.getSVG(i)
            );
        }
    }

    function testMassPreview9() public {
        for (uint256 i = 8001; i <= 9000; ++i) {
            vm.writeFile(
                string(
                    abi.encodePacked(
                        "generations/onii_",
                        Strings.toString(i),
                        ".svg"
                    )
                ),
                oniiChainDescriptor.getSVG(i)
            );
        }
    }

    function testMassPreview10() public {
        for (uint256 i = 9001; i <= 10000; ++i) {
            vm.writeFile(
                string(
                    abi.encodePacked(
                        "generations/onii_",
                        Strings.toString(i),
                        ".svg"
                    )
                ),
                oniiChainDescriptor.getSVG(i)
            );
        }
    }

    function testBackgroundReport() public {
        uint256 ordinary;
        uint256 unusual;
        uint256 surprising;
        uint256 impressive;
        uint256 extraordinary;
        uint256 phenomenal;
        uint256 artistic;
        uint256 unreal;

        for (uint256 i = 1; i <= 10000; ++i) {
            NFTDescriptor.SVGParams memory params = oniiChainDescriptor
                .getSVGParams(i);

            uint256 id = params.background;

            if (id == 1) {
                ordinary++;
            } else if (id == 2) {
                unusual++;
            } else if (id == 3) {
                surprising++;
            } else if (id == 4) {
                impressive++;
            } else if (id == 5) {
                extraordinary++;
            } else if (id == 6) {
                phenomenal++;
            } else if (id == 7) {
                artistic++;
            } else if (id == 8) {
                unreal++;
            }
        }

        string memory content = string(
            abi.encode(
                "Ordinary : ",
                Strings.toString(ordinary),
                "Unusual : ",
                Strings.toString(unusual),
                "Surprising : ",
                Strings.toString(surprising),
                "Impressive : ",
                Strings.toString(impressive),
                "Extraordinary : ",
                Strings.toString(extraordinary),
                "Phenomenal : ",
                Strings.toString(phenomenal),
                "Artistic : ",
                Strings.toString(artistic),
                "Unreal : ",
                Strings.toString(unreal)
            )
        );

        vm.writeLine(string("generations/background.txt"), content);
    }
}
