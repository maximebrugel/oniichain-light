// SPDX-License-Identifier: Unlicence
pragma solidity ^0.8.13;

import {Strings} from "./Strings.sol";
import {DetailHelper} from "./DetailHelper.sol";
import {BodyDetail} from "./details/BodyDetail.sol";
import {HairDetail} from "./details/HairDetail.sol";
import {NoseDetail} from "./details/NoseDetail.sol";
import {EyesDetail} from "./details/EyesDetail.sol";
import {MarkDetail} from "./details/MarkDetail.sol";
import {MaskDetail} from "./details/MaskDetail.sol";
import {MouthDetail} from "./details/MouthDetail.sol";
import {EyebrowDetail} from "./details/EyebrowDetail.sol";
import {EarringsDetail} from "./details/EarringsDetail.sol";
import {AccessoryDetail} from "./details/AccessoryDetail.sol";
import {BackgroundDetail} from "./details/BackgroundDetail.sol";

/// @notice Helper to generate SVGs
library NFTDescriptor {
    struct SVGParams {
        uint8 hair;
        uint8 eye;
        uint8 eyebrow;
        uint8 nose;
        uint8 mouth;
        uint8 mark;
        uint8 earring;
        uint8 accessory;
        uint8 mask;
        uint8 background;
        uint8 skin;
    }

    /// @dev Combine all the SVGs to generate the final image
    function generateSVGImage(SVGParams memory params)
        internal
        view
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    generateSVGHead(),
                    DetailHelper.getDetailSVG(
                        address(BackgroundDetail),
                        params.background
                    ),
                    generateSVGFace(params),
                    DetailHelper.getDetailSVG(
                        address(EarringsDetail),
                        params.earring
                    ),
                    DetailHelper.getDetailSVG(address(HairDetail), params.hair),
                    DetailHelper.getDetailSVG(address(MaskDetail), params.mask),
                    DetailHelper.getDetailSVG(
                        address(AccessoryDetail),
                        params.accessory
                    ),
                    "</svg>"
                )
            );
    }

    /// @dev Combine face items
    function generateSVGFace(SVGParams memory params)
        private
        view
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    DetailHelper.getDetailSVG(address(BodyDetail), params.skin),
                    DetailHelper.getDetailSVG(address(MarkDetail), params.mark),
                    DetailHelper.getDetailSVG(
                        address(MouthDetail),
                        params.mouth
                    ),
                    DetailHelper.getDetailSVG(address(NoseDetail), params.nose),
                    DetailHelper.getDetailSVG(address(EyesDetail), params.eye),
                    DetailHelper.getDetailSVG(
                        address(EyebrowDetail),
                        params.eyebrow
                    )
                )
            );
    }

    /// @dev generate Json Metadata name
    function generateName(SVGParams memory params, uint256 tokenId)
        internal
        pure
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    BackgroundDetail.getItemNameById(params.background),
                    " Onii ",
                    Strings.toString(tokenId)
                )
            );
    }

    /// @dev generate Json Metadata description
    function generateDescription(address owner)
        internal
        pure
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "Owned by ",
                    Strings.toHexString(uint256(uint160(owner)))
                )
            );
    }

    /// @dev generate SVG header
    function generateSVGHead() private pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px"',
                    ' viewBox="0 0 420 420" style="enable-background:new 0 0 420 420;" xml:space="preserve">'
                )
            );
    }

    /// @dev generate Json Metadata attributes
    function generateAttributes(SVGParams memory params)
        internal
        pure
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "[",
                    getJsonAttribute(
                        "Body",
                        BodyDetail.getItemNameById(params.skin),
                        false
                    ),
                    getJsonAttribute(
                        "Hair",
                        HairDetail.getItemNameById(params.hair),
                        false
                    ),
                    getJsonAttribute(
                        "Mouth",
                        MouthDetail.getItemNameById(params.mouth),
                        false
                    ),
                    getJsonAttribute(
                        "Nose",
                        NoseDetail.getItemNameById(params.nose),
                        false
                    ),
                    getJsonAttribute(
                        "Eyes",
                        EyesDetail.getItemNameById(params.eye),
                        false
                    ),
                    getJsonAttribute(
                        "Eyebrow",
                        EyebrowDetail.getItemNameById(params.eyebrow),
                        false
                    ),
                    abi.encodePacked(
                        getJsonAttribute(
                            "Mark",
                            MarkDetail.getItemNameById(params.mark),
                            false
                        ),
                        getJsonAttribute(
                            "Accessory",
                            AccessoryDetail.getItemNameById(params.accessory),
                            false
                        ),
                        getJsonAttribute(
                            "Earrings",
                            EarringsDetail.getItemNameById(params.earring),
                            false
                        ),
                        getJsonAttribute(
                            "Mask",
                            MaskDetail.getItemNameById(params.mask),
                            false
                        ),
                        getJsonAttribute(
                            "Background",
                            BackgroundDetail.getItemNameById(params.background),
                            false
                        ),
                        "]"
                    )
                )
            );
    }

    /// @dev Get the json attribute as
    ///    {
    ///      "trait_type": "Skin",
    ///      "value": "Human"
    ///    }
    function getJsonAttribute(
        string memory trait,
        string memory value,
        bool end
    ) private pure returns (string memory json) {
        return
            string(
                abi.encodePacked(
                    '{ "trait_type" : "',
                    trait,
                    '", "value" : "',
                    value,
                    '" }',
                    end ? "" : ","
                )
            );
    }
}
