async function main() {
  const MockChainlink = await ethers.getContractFactory("contracts/MockChainlinkOracle.sol:MockChainlinkOracle");
  const chainlinkOracle = await MockChainlink.deploy();
  await chainlinkOracle.deployed();
  console.log("Mock Chainlink Oracle:", chainlinkOracle.address);

  const ChainlinkConsumer = await ethers.getContractFactory("contracts/ChainlinkPriceConsumer.sol:ChainlinkPriceConsumer");
  const consumer = await ChainlinkConsumer.deploy(chainlinkOracle.address);
  await consumer.deployed();
  console.log("consumer addres : ",consumer.address)
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

// async function main() {
//   const ChainlinkConsumer = await ethers.getContractFactory("ChainlinkPriceConsumer");

//   const chainlink = await ChainlinkConsumer.deploy("0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419");

//   await chainlink.deployed();
//   console.log("Chainlink consumer:", chainlink.address);
// }

// main().catch(console.error);
