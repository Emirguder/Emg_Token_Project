#  EmgToken (EMG) - Smart Contract Project

## 🌍 Live Network Deployment

This smart contract has been successfully deployed and verified on the Sepolia Testnet. You can interact with the contract and view the NFT collection via the links below:

- **Contract Address:** `0xd3383EC1694c899ce6175Cdab4e44b35EA882912`
- **Sepolia Etherscan:** [View Verified Code](https://sepolia.etherscan.io/address/0xd3383EC1694c899ce6175Cdab4e44b35EA882912#code)
- **OpenSea Testnet:** [View Collection](https://testnets.opensea.io/collection/emgtoken)

This repository contains the smart contract code, comprehensive test suite, and deployment scripts for EmgToken (EMG), an ERC-721 Non-Fungible Token. 

Built completely with **Foundry** and **OpenZeppelin v5** to demonstrate modern, secure, and gas-efficient Web3 development practices.

##  Features
- **ERC-721 Standard:** Fully compliant NFT contract.
- **Dynamic Pricing:** The `buyToken` function implements a linear pricing curve `(tokenId + 1) 0.1 ether`
- **Access Control:** `safeMint` is protected by OpenZeppelin's `Ownable` pattern.
- **Zero-JavaScript Testing:** 100% Solidity-based tests including State Assertions, Access Control validation, Revert checking, and **Property-Based Fuzzing**.

## Tech Stack
- **Solidity ^0.8.24**
- **Foundry (Forge, Cast, Anvil)**

## 🧪 How to Run Tests
Clone the repo and run the Foundry test suite:
```bash
forge install
forge build
forge test -vv
