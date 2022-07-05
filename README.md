# -----

- My demo repository where all smartcontracts are hosted until finally tested and deployed.

##

**Includes:**

<br/>

> - **1. Auction**

**Overview of code:**

*Before Auction:*
- Seller of NFT deploys this contract.
- Auction lasts for 7 days.
- Participants can bid by depositing ETH greater than the current highest bidder.
- All bidders can withdraw their bid if it is not the current highest bid.


*After auction or on end of auction:*

- Highest bidder becomes the new owner of NFT.
- The seller receives the highest bid of ETH.

##

<br/>

> - **2. DutchAuction:**

**Overivew of code:**

- Seller of NFT deploys this contract setting a starting price for the NFT.
- Auction lasts for 7 days.
- Price of NFT decreases over time.
- Participants can buy by depositing ETH greater than the current price computed by the smart contract.
- Auction ends when a buyer buys the NFT.

##

<br/>

> - **3. CrowdFund:**

*In development 🤘🏾*

##

<br/>

> - **4. Aguia 2.0:**

A safer and more secure version of the old <a href="https://github.com/fps8k/my-solidity/tree/main/erc20%20-%20%24AGU">Aguia</a> token.

##

<br/>

> - **5. Faucet**

Rinkeby faucet that transfers 0.1 Ether to every address, without time limits.

##

<br/>

> - **6. ToDo**

A basic smart contract to do list.
