const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Chainlink Oracle Integration", function () {
  let oracle, consumer;

  beforeEach(async function () {
    const MockOracle = await ethers.getContractFactory("MockChainlinkOracle");
    oracle = await MockOracle.deploy();
    await oracle.deployed();

    const Consumer = await ethers.getContractFactory("ChainlinkPriceConsumer");
    consumer = await Consumer.deploy(oracle.address);
    await consumer.deployed();
  });

  it("Should return correct price", async function () {
    await oracle.setPrice(2000e8);
    const price = await consumer.getLatestPrice();
    expect(price).to.equal(2000e8);
  });

  it("Should revert on invalid price", async function () {
    await oracle.setPrice(0);
    await expect(consumer.getLatestPrice()).to.be.revertedWith("Invalid price");
  });
});
