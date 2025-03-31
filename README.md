# StacksNex 

## Overview
StacksNex is a smart contract platform built on the Stacks blockchain ecosystem. It provides a decentralized asset management and conversion system, allowing users to deposit, withdraw, and convert assets such as STX, sBTC, and BTC seamlessly. The contract also includes user settings customization, protocol fee management, and an asset whitelist feature.

## Features
- **Asset Management:** Deposit and withdraw whitelisted assets.
- **STX/sBTC/BTC Conversion:** Convert between supported assets with predefined conversion rates.
- **User Settings:** Configure auto-stacking preferences and preferred reward assets.
- **Protocol Fee Handling:** A configurable fee is applied to conversions.
- **Admin Controls:** Manage whitelisted assets, update conversion rates, and modify protocol fees.

## Supported Assets
- **STX (Stacks Token)**
- **sBTC (Synthetic Bitcoin on Stacks)**
- **BTC (Bitcoin)**

## Contract Constants
- **Contract Owner:** `tx-sender`
- **Errors:**
  - `err-owner-only (u100)`: Only the contract owner can execute.
  - `err-not-token-owner (u101)`: Caller does not own the token.
  - `err-insufficient-balance (u102)`: Not enough funds for the operation.
  - `err-asset-not-whitelisted (u103)`: Asset is not approved for operations.
  - `err-invalid-params (u104)`: Invalid function input.

## Data Structures
### 1. **Maps**
- `user-balances`: Tracks user balances per asset.
- `whitelisted-assets`: Stores assets that are allowed for transactions.
- `conversion-rates`: Defines conversion rates between assets.
- `user-settings`: Stores user preferences.

### 2. **Data Variables**
- `total-volume`: Tracks total converted volume.
- `total-users`: Counts unique users interacting with the contract.
- `protocol-fee-percent`: Defines the percentage fee for conversions (default 0.1%).

## Functions
### Read-Only Functions
- `get-balance(user, asset)`: Fetch user balance for a given asset.
- `is-asset-whitelisted(asset)`: Check if an asset is approved.
- `get-conversion-rate(from-asset, to-asset)`: Fetch the conversion rate.
- `calculate-conversion(from-asset, to-asset, amount)`: Compute the converted amount after applying the rate.
- `get-user-settings(user)`: Retrieve user preferences.

### Public Functions
- `deposit(asset, amount)`: Deposit funds into the contract.
- `withdraw(asset, amount)`: Withdraw funds from the contract.
- `convert(from-asset, to-asset, amount)`: Convert between supported assets.
- `update-settings(auto-stack, preferred-reward)`: Update user settings.

### Admin Functions
- `update-protocol-fee(new-fee-percent)`: Change the protocol fee.
- `update-conversion-rate(from-asset, to-asset, rate, decimals)`: Modify conversion rates.
- `add-whitelisted-asset(asset, decimals)`: Add a new asset to the whitelist.

## Deployment & Usage
### Prerequisites
- Stacks CLI
- Clarity development environment

### Deployment Steps
1. Compile the contract using Clarity tools.
2. Deploy the contract on the Stacks blockchain.
3. Interact using a Stacks-compatible wallet or blockchain explorer.

## Security Considerations
- **Ownership Control:** Only the contract owner can modify fees and whitelisted assets.
- **Balance Checks:** Transactions validate available balances before execution.
- **Conversion Accuracy:** All conversions use predefined decimals for precision.

## Future Enhancements
- Add support for additional wrapped assets.
- Introduce liquidity pool mechanisms for better conversion rates.
- Implement governance features for community-based decision-making.

## License
MIT License
