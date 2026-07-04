// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/**
 * @title RouterHintRegistry
 * @dev On-chain storage target index providing key visibility mappings to off-chain routers.
 */
contract RouterHintRegistry {

    mapping(bytes4 => bool) public executionWriteSelectors;
    address public contractManager;

    event SelectorRegistered(bytes4 indexed sig, bool isWriteState);

    constructor() {
        contractManager = msg.sender;
    }

    /**
     * @notice Registers a contract function selector's mutable properties.
     */
    function registerFunctionTelemetry(bytes4 selector, bool isWriteState) external {
        require(msg.sender == contractManager, "AuthError: Caller is not the verified system administrator");
        executionWriteSelectors[selector] = isWriteState;
        
        emit SelectorRegistered(selector, isWriteState);
    }
}
