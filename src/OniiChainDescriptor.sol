// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {Base64} from "./libraries/Base64.sol";
import {DetailHelper} from "./libraries/DetailHelper.sol";
import {NFTDescriptor} from "./libraries/NFTDescriptor.sol";

contract OniiChainDescriptor {
    /* -------------------------------------------------------------------------- */
    /*                                  CONSTANTS                                 */
    /* -------------------------------------------------------------------------- */

    /// @dev Max value for defining probabilities
    uint256 internal constant MAX = 100000;

    bytes32 internal constant SEQ = "aojebva";

    /* -------------------------------------------------------------------------- */
    /*                                   STORAGE                                  */
    /* -------------------------------------------------------------------------- */

    uint256[] internal BACKGROUND_ITEMS = [
        4000,
        3400,
        3080,
        2750,
        2400,
        1900,
        1200,
        0
    ];
    uint256[] internal SKIN_ITEMS = [2000, 1000, 0];
    uint256[] internal NOSE_ITEMS = [10, 0];
    uint256[] internal MARK_ITEMS = [
        50000,
        40000,
        31550,
        24550,
        18550,
        13550,
        9050,
        5550,
        2550,
        550,
        50,
        10,
        0
    ];
    uint256[] internal EYEBROW_ITEMS = [65000, 40000, 20000, 10000, 4000, 0];
    uint256[] internal MASK_ITEMS = [
        20000,
        14000,
        10000,
        6000,
        2000,
        1000,
        100,
        0
    ];
    uint256[] internal EARRINGS_ITEMS = [
        50000,
        38000,
        28000,
        20000,
        13000,
        8000,
        5000,
        2900,
        1000,
        100,
        30,
        0
    ];
    uint256[] internal ACCESSORY_ITEMS = [
        50000,
        43000,
        36200,
        29700,
        23400,
        17400,
        11900,
        7900,
        4400,
        1400,
        400,
        200,
        11,
        1,
        0
    ];
    uint256[] internal MOUTH_ITEMS = [
        80000,
        63000,
        48000,
        36000,
        27000,
        19000,
        12000,
        7000,
        4000,
        2000,
        1000,
        500,
        50,
        0
    ];
    uint256[] internal HAIR_ITEMS = [
        97000,
        94000,
        91000,
        88000,
        85000,
        82000,
        79000,
        76000,
        73000,
        70000,
        67000,
        64000,
        61000,
        58000,
        55000,
        52000,
        49000,
        46000,
        43000,
        40000,
        37000,
        34000,
        31000,
        28000,
        25000,
        22000,
        19000,
        16000,
        13000,
        10000,
        3000,
        1000,
        0
    ];
    uint256[] internal EYE_ITEMS = [
        98000,
        96000,
        94000,
        92000,
        90000,
        88000,
        86000,
        84000,
        82000,
        80000,
        78000,
        76000,
        74000,
        72000,
        70000,
        68000,
        60800,
        53700,
        46700,
        39900,
        33400,
        27200,
        21200,
        15300,
        10600,
        6600,
        3600,
        2600,
        1700,
        1000,
        500,
        100,
        10,
        0
    ];

    /* -------------------------------------------------------------------------- */
    /*                             EXTERNAL FUNCTIONS                             */
    /* -------------------------------------------------------------------------- */

    /// @notice Generate full SVG for a given tokenId
    /// @param tokenId The Onii tokenID
    /// @param owner Onii owner address
    /// @return The full SVG (image, name, description,...)
    function tokenURI(uint256 tokenId, address owner)
        external
        view
        returns (string memory)
    {
        // Get SVGParams based on tokenID
        NFTDescriptor.SVGParams memory params = getSVGParams(tokenId);

        // Compute background id based on items probabilities
        params.background = getBackgroundId(params);

        // Generate SVG Image
        string memory image = Base64.encode(
            bytes(NFTDescriptor.generateSVGImage(params))
        );

        string memory name = NFTDescriptor.generateName(params, tokenId);
        string memory description = NFTDescriptor.generateDescription(owner);
        string memory attributes = NFTDescriptor.generateAttributes(params);

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name,
                                '", "description":"',
                                description,
                                '", "attributes":',
                                attributes,
                                ', "image": "',
                                "data:image/svg+xml;base64,",
                                image,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function getSVG(uint256 tokenId) external view returns (string memory) {
        // Get SVGParams based on tokenID
        NFTDescriptor.SVGParams memory params = getSVGParams(tokenId);

        // Compute background id based on items probabilities
        params.background = getBackgroundId(params);

        return NFTDescriptor.generateSVGImage(params);
    }

    /* -------------------------------------------------------------------------- */
    /*                              PRIVATE FUNCTIONS                             */
    /* -------------------------------------------------------------------------- */

    /// @dev Get SVGParams struct from the tokenID
    /// @param tokenId The Onii TokenID
    /// @return The NFTDescription.SVGParams struct
    function getSVGParams(uint256 tokenId)
        private
        view
        returns (NFTDescriptor.SVGParams memory)
    {
        return
            NFTDescriptor.SVGParams({
                hair: generateHairId(
                    tokenId,
                    uint256(keccak256(abi.encode("onii.hair", SEQ)))
                ),
                eye: generateEyeId(
                    tokenId,
                    uint256(keccak256(abi.encode("onii.eye", SEQ)))
                ),
                eyebrow: generateEyebrowId(
                    tokenId,
                    uint256(keccak256(abi.encode("onii.eyebrown", SEQ)))
                ),
                nose: generateNoseId(
                    tokenId,
                    uint256(keccak256(abi.encode("onii.nose", SEQ)))
                ),
                mouth: generateMouthId(
                    tokenId,
                    uint256(keccak256(abi.encode("onii.mouth", SEQ)))
                ),
                mark: generateMarkId(
                    tokenId,
                    uint256(keccak256(abi.encode("onii.mark", SEQ)))
                ),
                earring: generateEarringsId(
                    tokenId,
                    uint256(keccak256(abi.encode("onii.earrings", SEQ)))
                ),
                accessory: generateAccessoryId(
                    tokenId,
                    uint256(keccak256(abi.encode("onii.accessory", SEQ)))
                ),
                mask: generateMaskId(
                    tokenId,
                    uint256(keccak256(abi.encode("onii.mask", SEQ)))
                ),
                skin: generateSkinId(
                    tokenId,
                    uint256(keccak256(abi.encode("onii.skin", SEQ)))
                ),
                background: 0
            });
    }

    function generateHairId(uint256 tokenId, uint256 seed)
        private
        view
        returns (uint8)
    {
        return DetailHelper.generate(MAX, seed, HAIR_ITEMS, tokenId);
    }

    function generateEyeId(uint256 tokenId, uint256 seed)
        private
        view
        returns (uint8)
    {
        return DetailHelper.generate(MAX, seed, EYE_ITEMS, tokenId);
    }

    function generateEyebrowId(uint256 tokenId, uint256 seed)
        private
        view
        returns (uint8)
    {
        return DetailHelper.generate(MAX, seed, EYEBROW_ITEMS, tokenId);
    }

    function generateNoseId(uint256 tokenId, uint256 seed)
        private
        view
        returns (uint8)
    {
        return DetailHelper.generate(MAX, seed, NOSE_ITEMS, tokenId);
    }

    function generateMouthId(uint256 tokenId, uint256 seed)
        private
        view
        returns (uint8)
    {
        return DetailHelper.generate(MAX, seed, MOUTH_ITEMS, tokenId);
    }

    function generateMarkId(uint256 tokenId, uint256 seed)
        private
        view
        returns (uint8)
    {
        return DetailHelper.generate(MAX, seed, MARK_ITEMS, tokenId);
    }

    function generateEarringsId(uint256 tokenId, uint256 seed)
        private
        view
        returns (uint8)
    {
        return DetailHelper.generate(MAX, seed, EARRINGS_ITEMS, tokenId);
    }

    function generateAccessoryId(uint256 tokenId, uint256 seed)
        private
        view
        returns (uint8)
    {
        return DetailHelper.generate(MAX, seed, ACCESSORY_ITEMS, tokenId);
    }

    function generateMaskId(uint256 tokenId, uint256 seed)
        private
        view
        returns (uint8)
    {
        return DetailHelper.generate(MAX, seed, MASK_ITEMS, tokenId);
    }

    function generateSkinId(uint256 tokenId, uint256 seed)
        private
        view
        returns (uint8)
    {
        return DetailHelper.generate(MAX, seed, SKIN_ITEMS, tokenId);
    }

    /// @dev Compute background id based on the params probabilities
    function getBackgroundId(NFTDescriptor.SVGParams memory params)
        private
        view
        returns (uint8)
    {
        uint256 score = itemScorePosition(params.hair, HAIR_ITEMS) +
            itemScoreProba(params.accessory, ACCESSORY_ITEMS) +
            itemScoreProba(params.earring, EARRINGS_ITEMS) +
            itemScoreProba(params.mask, MASK_ITEMS) +
            itemScorePosition(params.mouth, MOUTH_ITEMS) +
            (itemScoreProba(params.skin, SKIN_ITEMS) / 2) +
            itemScoreProba(params.skin, SKIN_ITEMS) +
            itemScoreProba(params.nose, NOSE_ITEMS) +
            itemScoreProba(params.mark, MARK_ITEMS) +
            itemScorePosition(params.eye, EYE_ITEMS) +
            itemScoreProba(params.eyebrow, EYEBROW_ITEMS);
        return DetailHelper.pickItems(score, BACKGROUND_ITEMS);
    }

    /// @dev Get item score based on his probability
    function itemScoreProba(uint8 item, uint256[] memory ITEMS)
        private
        pure
        returns (uint256)
    {
        uint256 raw = ((item == 1 ? MAX : ITEMS[item - 2]) - ITEMS[item - 1]);
        return ((raw >= 1000) ? raw * 6 : raw) / 1000;
    }

    /// @dev Get item score based on his index
    function itemScorePosition(uint8 item, uint256[] memory ITEMS)
        private
        pure
        returns (uint256)
    {
        uint256 raw = ITEMS[item - 1];
        return ((raw >= 1000) ? raw * 6 : raw) / 1000;
    }
}
