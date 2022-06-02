/**
 *Submitted for verification at Etherscan.io on 2016-03-24
*/

contract Government {

    // Last person paid maybe.
    uint32 public lastCreditorPayedOut;
    // Last time the contract received ether?
    uint public lastTimeOfNewCredit;
    // Profit from cash.
    uint public profitFromCrash;
    // Address of everyone who has paid some ether into this contract.
    address[] public creditorAddresses;
    // Array of all the amount that the creditors paid in to the contract.
    uint[] public creditorAmounts;
    // The owner of the contract.
    address public corruptElite;
    // All who have paid to the contract and the amount they have paid to the contract.
    mapping (address => uint) buddies;
    // 12 Hours to seconds.
    uint constant TWELVE_HOURS = 43200;
    // Random number?
    uint8 public round;

    function Government() {
        // The corrupt elite establishes a new government
        // this is the commitment of the corrupt Elite - everything that can not be saved from a crash


        // Profit from cash?
        profitFromCrash = msg.value;
        // Contract owner.
        corruptElite = msg.sender;
        // Last time of new credit.
        lastTimeOfNewCredit = block.timestamp;
    }
    
    

    // This function isn't payable, wtf??
    function lendGovernmentMoney(address buddy) returns (bool) {
        uint amount = msg.value;
        // check if the system already broke down. If for 12h no new creditor gives new credit to the system it will brake down.
        // 12h are on average = 60*60*12/12.5 = 3456

        // If the last time of credit is past 12 hours, the contract will:
        if (lastTimeOfNewCredit + TWELVE_HOURS < block.timestamp) {
            // Return money to sender
            msg.sender.send(amount);
            // Sends all contract money to the last creditor
            creditorAddresses[creditorAddresses.length - 1].send(profitFromCrash);
            // Send all contract balance to the owner.
            corruptElite.send(this.balance);
            // Reset contract state
            lastCreditorPayedOut = 0;
            lastTimeOfNewCredit = block.timestamp;
            profitFromCrash = 0;
            creditorAddresses = new address[](0);
            creditorAmounts = new uint[](0);
            round += 1;
            return false;
        }
        else {
            // the system needs to collect at least 1% of the profit from a crash to stay alive
            // The system takes in 1 ether and more.
            if (amount >= 10 ** 18) {
                // the System has received fresh money, it will survive at leat 12h more
                // Update the last time of credit.
                lastTimeOfNewCredit = block.timestamp;
                // register the new creditor and his amount with 10% interest rate
                // Add the sender to the creditor address array.
                creditorAddresses.push(msg.sender);
                // Add 110 of the money to the creditors array.
                creditorAmounts.push(amount * 110 / 100);
                // now the money is distributed
                // first the corrupt elite grabs 5% - thieves!

                // Give the owner 5% of the total donated.
                corruptElite.send(amount * 5/100);
                // 5% are going into the economy (they will increase the value for the person seeing the crash comming)
                // Add another 5% to the profit from crash.
                if (profitFromCrash < 10000 * 10**18) {
                    profitFromCrash += amount * 5/100;
                }
                // if you have a buddy in the government (and he is in the creditor list) he can get 5% of your credits.
                // Make a deal with him.
                // If the buddy has the amount or more allocated to him, he can also get 5% of the money you sent.
                if(buddies[buddy] >= amount) {
                    buddy.send(amount * 5/100);
                }
                // Add 110% of the money you sent to the buddy you added.
                buddies[msg.sender] += amount * 110 / 100;
                // 90% of the money will be used to pay out old creditors

                // Some gibberish.
                if (creditorAmounts[lastCreditorPayedOut] <= address(this).balance - profitFromCrash) {
                    creditorAddresses[lastCreditorPayedOut].send(creditorAmounts[lastCreditorPayedOut]);
                    buddies[creditorAddresses[lastCreditorPayedOut]] -= creditorAmounts[lastCreditorPayedOut];
                    lastCreditorPayedOut += 1;
                }
                return true;
            }
            else {
                msg.sender.send(amount);
                return false;
            }
        }
    }

    // fallback function
    function() {
        lendGovernmentMoney(0);
    }

    function totalDebt() returns (uint debt) {
        for(uint i=lastCreditorPayedOut; i<creditorAmounts.length; i++){
            debt += creditorAmounts[i];
        }
    }

    function totalPayedOut() returns (uint payout) {
        for(uint i=0; i<lastCreditorPayedOut; i++){
            payout += creditorAmounts[i];
        }
    }

    // better don't do it (unless you are the corrupt elite and you want to establish trust in the system)
    function investInTheSystem() {
        profitFromCrash += msg.value;
    }

    // From time to time the corrupt elite inherits it's power to the next generation
    function inheritToNextGeneration(address nextGeneration) {
        if (msg.sender == corruptElite) {
            corruptElite = nextGeneration;
        }
    }

    function getCreditorAddresses() returns (address[]) {
        return creditorAddresses;
    }

    function getCreditorAmounts() returns (uint[]) {
        return creditorAmounts;
    }
}
