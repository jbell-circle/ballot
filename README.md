# Ballot

## The Contract

The Ballot contract showcases many Solidity features.
It implements a voting contract.
It creates one contract per ballot, providing a short name for each option.
The creator of the contract - the chairperson - gives the right to vote to each address individually.
The persons behind the addresses can then choose to either vote themselves or to delegate their vote to someone else.
winningProposal() returns the proposal with the largest number of votes.

The source code for the contract is found at ./src/Ballot.sol

## Requirements

### Foundry

Install foundry by running the following command and following the instructions.

```sh
curl -L https://foundry.paradigm.xyz | bash
```

Foundry is a toolkit for Ethereum application development written in Rust.
It consists of several tools but we'll focus on **forge**: an ethereum build and testing framework (like Truffle or Hardhat).

Read https://book.getfoundry.sh/ to learn more.

## Intro

The following command will build and run the tests for your smart contracts.

```
forge test
```

### Challenge

1. Write tests for the delegate function.
2. Write a Ballot function that allows the chairperson to give multiple addresses the right to vote.

## Experimenting

Foundry also comes with a local testnet node, **anvil**.
The following command will start the node, expose an rpc endpoint on `127.0.0.1:8545`, and initialize 10 accounts with some ETH balance.

```sh
anvil --acccounts 10
```

You can then use the provided ./script/Ballot.s.sol to deploy a Ballot with two proposals.

The `BALLOT_DEPLOYER_PRIVATEKEY` envvar is referenced in the script.
By default, anvil creates the private key with the value presented below.

```sh
export BALLOT_RPCURL=127.0.0.1:8545
export BALLOT_DEPLOYER_PRIVATEKEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
forge script script/Ballot.s.sol:BallotScript --rpc-url $BALLOT_RPCURL --broadcast
```

The output above will include the contract address.
Copy this to an environment variable for further use.

```
export BALLOT_CONTRACTADDRESS=<CONTRACT_ADDRESS>
```

**cast** is Foundry’s command-line tool for Ethereum RPC calls.
The following sends a vote from the deployer address.

```sh
cast send --private-key $BALLOT_DEPLOYER_PRIVATEKEY \
    $BALLOT_CONTRACTADDRESS "vote(uint256)" 1 \
    --rpc-url $BALLOT_RPCURL
```

Read-only commands don't require a private key.

```sh
cast call $BALLOT_CONTRACTADDRESS "getVoteCount(uint256)" 1 \
    --rpc-url $BALLOT_RPCURL
```

### Challenge

1. Give another address the right to vote and use that address.
2. Get the winning proposal name. This will be in bytes32 so use `cast parse-bytes32-string` to convert it to a string [link](https://book.getfoundry.sh/reference/cast/cast-parse-bytes32-string)
