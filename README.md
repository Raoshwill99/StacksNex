
# StacksNex

## Overview

**StacksNex** is a decentralized smart contract platform built on the **Stacks blockchain**. This platform is designed to facilitate the development and deployment of secure, scalable, and efficient smart contracts for various blockchain applications. **Phase 2** of the StacksNex upgrade introduces several new features aimed at improving contract security, performance, and flexibility, while also preparing the platform for future cross-chain interoperability.

### Key Features in Phase 2:
- **Role-Based Access Control (RBAC)**: Allows fine-grained control over user permissions.
- **Multi-Signature Support**: Critical functions require multi-signature approval to ensure security.
- **Reentrancy Protection**: Prevents reentrancy attacks in smart contract functions.
- **Optimized Conversion Logic**: Efficient handling of asset conversions with minimized gas costs.
- **Batch Processing**: Process multiple asset conversions in a single transaction.
- **Event Emissions**: Emit contract events for external applications to listen to.
- **Cross-Chain Asset Swaps**: Placeholder for future cross-chain swaps.
- **Auto-Staking Rewards**: Automatically stake assets and receive rewards.
- **Dynamic Fee Structures**: Enable dynamic adjustment of platform fees.
- **Governance Proposals**: Allows users to propose changes and upgrades to the platform.

## Installation

Follow these steps to install and set up **StacksNex** on your local machine.

### Steps:
1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/StacksNex.git
   cd StacksNex
   ```

2. **Install Dependencies**:
   Ensure you have **Clarity CLI** installed for compiling and deploying the smart contract. You can find the installation instructions [here](https://github.com/blockstack/clarity-cli).

3. **Compile the contract**:
   Run the following command to compile the contract into a deployable format:
   ```bash
   clarity compile contracts/StacksNex.clar
   ```

4. **Deploy the contract**:
   Deploy the compiled contract to the Stacks blockchain. You can deploy via the **Stacks CLI** or the **Stacks Explorer**.
   
   To deploy via **Stacks CLI**:
   ```bash
   stacks-cli deploy-contract -c contracts/StacksNex.clar
   ```

5. **Interaction**:
   After deployment, interact with the contract using **Xverse** or other compatible Stacks wallets.

## Features

### 1. Role-Based Access Control (RBAC)
The platform uses **Role-Based Access Control (RBAC)** to assign different roles to users. The contract owner can assign or revoke admin roles, enabling fine control over permissions. Only users with the correct roles can perform sensitive operations like contract updates or asset whitelisting.

- **Assign Role**: Assign an admin role to a user.
  ```clarity
  assign-admin-role(user, role)
  ```
- **Revoke Role**: Revoke an admin role from a user.
  ```clarity
  revoke-admin-role(user)
  ```

### 2. Multi-Signature Support
Critical functions require approval from multiple signatures (multi-signature) to ensure that administrative actions are authorized by multiple parties.

- **Approve Admin Action**: Approve an admin function with multi-signature.
  ```clarity
  approve-admin-action(function-name, approver)
  ```

### 3. Reentrancy Protection
This feature prevents reentrancy attacks by locking the contract during certain operations, ensuring that only one transaction can be processed at a time.

- **Lock Transaction**: Lock the contract to prevent reentrancy.
  ```clarity
  lock-transaction()
  ```

- **Unlock Transaction**: Unlock the contract to allow further transactions.
  ```clarity
  unlock-transaction()
  ```

### 4. Optimized Conversion Logic
**StacksNex** includes an optimized method for asset conversion, reducing the gas costs and improving the performance of the platform.

- **Batch Convert**: Allows users to process multiple conversions in a single transaction.
  ```clarity
  batch-convert(conversions)
  ```

### 5. Event Emissions
The platform supports emitting events to notify external systems when important contract activities occur. This feature is useful for front-end applications or other smart contracts that need to listen for specific events.

- **Emit Event**: Emit a custom event.
  ```clarity
  emit-event(event-type, details)
  ```

### 6. Cross-Chain Asset Swaps (Preparatory Work)
While this feature is in the planning stages, the contract includes a placeholder for cross-chain asset swaps. This will allow users to swap assets between different blockchains in the future.

- **Initiate Cross-Chain Swap**: Initiate a cross-chain asset swap.
  ```clarity
  initiate-cross-chain-swap(destination-chain, amount)
  ```

### 7. Auto-Staking Rewards
Users can opt-in for automatic staking of their assets. When enabled, users will receive rewards based on the staking of their assets.

- **Enable Staking**: Enable staking for a specific asset.
  ```clarity
  enable-staking(reward-asset)
  ```

- **Disable Staking**: Disable staking for a user.
  ```clarity
  disable-staking()
  ```

### 8. Dynamic Fee Structure
The platform supports dynamic adjustments to the protocol fee. The contract owner can update the fee percentage.

- **Update Fee**: Update the protocol fee percentage.
  ```clarity
  update-dynamic-fee(new-fee-percent)
  ```

### 9. Governance Proposal Submissions
This feature allows users to propose changes and upgrades to the platform through a governance system.

- **Propose Governance Change**: Submit a governance proposal.
  ```clarity
  propose-governance-change(proposal)
  ```

## Contract Structure

### Constants:
- **contract-owner**: The principal that owns the contract.
- **Error Constants**: Various error constants to handle specific contract-related issues (e.g., `err-owner-only`, `err-transaction-in-progress`).

### Data Structures:
- **admin-approvals**: A map that stores multi-signature approvals for critical functions.
- **admin-roles**: A map that manages the admin roles for users.
- **transaction-lock**: A boolean flag for multi-signature transaction lock.
- **user-staking**: A map that tracks user staking preferences.
- **whitelisted-assets**: A map that tracks allowed assets for staking.

### Public Functions:
- **approve-admin-action**: Approve an admin action with multi-signature.
- **assign-admin-role**: Assign an admin role to a user.
- **revoke-admin-role**: Revoke an admin role from a user.
- **lock-transaction/unlock-transaction**: Reentrancy protection.
- **batch-convert**: Batch process asset conversions.
- **update-dynamic-fee**: Update platform fees.
- **emit-event**: Emit contract events for external systems.
- **initiate-cross-chain-swap**: Placeholder for cross-chain swaps.
- **propose-governance-change**: Submit governance proposals.

## Deployment

Deploy the contract to the Stacks blockchain using the **Stacks CLI** or **Stacks Explorer**.

### Deploying via Stacks CLI:
1. Compile the contract:
   ```bash
   clarity compile contracts/StacksNex.clar
   ```

2. Deploy the contract:
   ```bash
   stacks-cli deploy-contract -c contracts/StacksNex.clar
   ```

## Usage

### Interacting with the Contract
Once deployed, the contract can be interacted with via the **Stacks Wallet** (e.g., **Xverse**). To call a public function, you can either:

- Use the Stacks CLI to interact with the contract functions.
- Use a front-end application to trigger contract functions.

## Testing

### Contract Testing
Before deploying to the live network, ensure that the contract behaves as expected. The **Stacks CLI** allows you to interact with the deployed contract in a test environment.

1. Test **role-based access control** by attempting to assign and revoke roles.
2. Test **multi-signature** functionality by approving critical functions.
3. Test **reentrancy protection** by attempting to invoke multiple transactions at once.
4. Test **batch processing** with multiple conversions in one transaction.

### Debugging
Use the `debug-check` function in the contract to print debugging messages and check the status of critical operations.

```clarity
debug-check()
```

## License

This project is licensed under the MIT License
