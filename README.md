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
