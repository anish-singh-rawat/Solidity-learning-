const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("BuyCoffee", function () {
  it("allows user to buy coffee and owner to withdraw", async function () {
    const [owner, user] = await ethers.getSigners();

    const BuyCoffee = await ethers.getContractFactory("BuyCoffee");
    const contract = await BuyCoffee.deploy();
    await contract.deployed();

    const price = await contract.coffeePrice();
    await contract.connect(user).buyCoffee(2, { value: price.mul(2) });
    expect(await contract.coffeesBought(user.address)).to.equal(2);
   
 await contract.withdraw();

    expect(await ethers.provider.getBalance(contract.address)).to.equal(0);
  });
});
