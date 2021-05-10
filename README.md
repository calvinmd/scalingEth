# Scaling Ethereum Hackathon: Parimutuel on MATIC

## Introduction
Parimutuel is a system where all bets for different outcomes of an event put into a single pool, and the winning bettors split the pool pro-rata after deducting the fees paid to the "house" (operator).

Common games include sports betting, politics, horse racing, and other forms of prediction markets.

## On-chain solution
I've created the on-chain smart contract to enable parimutuel game plays, with the following configurations
- house/operator: the wallet that launches the smart contract
- initial pool is created, with a preset of 2 maximum outcomes (called "buckets", can be overwritten by operator)
- a percentage fee (default at 10%)
- the ERC20 currency accepted as wagers is hardcoded, can be replaced by other standard ERC20 tokens

Users can interact with only one method
- `enter` allows user to specify which pool and which outcome (called bucket) and at what amount to enter
- user needs to first approve the smart contract on the selected token in order to call the `enter` method

Operator functions include
- re-configurating some of the params
- create a new pool
- lock the pool
- set up to 4 metadata on each pool
- most importantly, settle the pool with the winning outcome and trigger the payout and fee deduction

## Why do we need scaling solution?
- more transparency and fairness when executed on-chain
- while parimutuel can support high rollers, most gamers are playing it for fun with small bets, the high gas fee on Ethereum would prohibit the game from launching on-chain
- the time it takes to finalize blocks would render it impossible for short timeframe games or last second entries

## Why did I choose MATIC?
MATIC has a few crucial features that enables Parimutuel on-chain:
1. MATIC is EVM- and Solidity-compatible, so I can use the same smart contract on Ethereum for implementation
2. MATIC has a fast and reliable asset bridge (I selected the PoS bridge) to enable playing with Ethereum assets
3. MATIC's fee is low and block time is fast

## How was it implemented?
- the asset bridge I simply used the MATIC tutorial which provided an asset bridge using PoS: https://github.com/maticnetwork/pos-plasma-tutorial
- launched the Parimutuel Solidity smart contract on MATIC
- I used a standard ERC20 token implementation from [the APIS project](http://docs.theapis.io/) for easy `approve()` access, but should be able to use the transferred asset from the MATIC bridge, too

## What was not implemented?
- I have done a partial widget-style UI but did not have time to finish within the hackathon time limit. The missing parts include a real data feed or oracle integration that brings in the outcome, and the approval interface for custom tokens. The wallet was connected and the methods of the Parimutuel smart contract can also be invoked but there is no meaningful presentation without some kind of real world data

## What is next?
- the Parimutuel smart contract is truly versatile and configurable for a lot of different types of prediction markets. It is way simpler compared to other prediction market implementations such as Augur or Polymarket, using only one single smart contract (**only 161 lines of code** with the standard contract and interfaces removed). The simplicity allows any operator to launch it with confidence without relying on an engineering team
- I hope to implement some of the interesting Parimutuel games such as [Moon-Rekt](https://live.hxro.io/), sports betting in general, and integrate real data feed and configuration and UI for the next steps.

## Mumbai testnet contracts
- Parimutuel: [0xc4faB13CC051C334607d8DB61c58a017aDb13e30](https://explorer-mumbai.maticvigil.com/address/0xc4faB13CC051C334607d8DB61c58a017aDb13e30/transactions)
- Dummy token: [0x94082fe34E939EDd3FDE466Ea4a58cD5bFCF3048](https://explorer-mumbai.maticvigil.com/address/0x94082fe34E939EDd3FDE466Ea4a58cD5bFCF3048/transactions)

The source codes are in this repo. If you need test tokens or approval for your testnet address, please feel free to [PM me on twitter](https://twitter.com/ICscript), or feel free to relaunch with your own tweaks on Mumbai testnet! (Here's the instruction on how to launch the smart contracts using Remix: https://docs.matic.network/docs/develop/remix)
