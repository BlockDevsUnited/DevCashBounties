var ethers = require('ethers');
var web3 = require('web3');


var privkey = "0x3701d708b2133f8f3913b9b6a578697ae02c0fc3eaaac33a1cdcd8374bfc5c9b"
let provider = ethers.getDefaultProvider();

let wallet = new ethers.Wallet(privkey,provider);

let transaction = {
    nonce: 31,
    gasLimit: 21000,
    gasPrice: ethers.utils.bigNumberify("100000000000"),

    to: "0x88a5C2d9919e46F883EB62F7b8Dd9d0CC45bc290",
    // ... or supports ENS names
    // to: "ricmoo.firefly.eth",

    value: ethers.utils.parseEther("0.00000000000000001"),
    data: "0x",

    // This ensures the transaction cannot be replayed on different networks
    chainId: ethers.utils.getNetwork('homestead').chainId
}

let signPromise = wallet.sign(transaction)

signPromise.then((signedTransaction) => {

    console.log(signedTransaction);
    // "0xf86c808504a817c8008252089488a5c2d9919e46f883eb62f7b8dd9d0cc45bc2
    //    90880de0b6b3a76400008025a05e766fa4bbb395108dc250ec66c2f88355d240
    //    acdc47ab5dfaad46bcf63f2a34a05b2cb6290fd8ff801d07f6767df63c1c3da7
    //    a7b83b53cd6cea3d3075ef9597d5"

    // This can now be sent to the Ethereum network
    let provider = ethers.getDefaultProvider()
    provider.sendTransaction(signedTransaction).then((tx) => {

        console.log(tx);
        // {
        //    // These will match the above values (excluded properties are zero)
        //    "nonce", "gasLimit", "gasPrice", "to", "value", "data", "chainId"
        //
        //    // These will now be present
        //    "from", "hash", "r", "s", "v"
        //  }
        // Hash:
    });
})
