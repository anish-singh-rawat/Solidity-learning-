const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("BuyCoffee - Comprehensive Tests", function () {
  let BuyCoffee;
  let buyCoffee;
  let owner;
  let user1;
  let user2;

  beforeEach(async function () {
    [owner, user1, user2] = await ethers.getSigners();
    BuyCoffee = await ethers.getContractFactory("BuyCoffee");
    buyCoffee = await BuyCoffee.deploy();
    await buyCoffee.deployed();
  });

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      expect(await buyCoffee.owner()).to.equal(owner.address);
    });

    it("Should set the correct coffee price", async function () {
      expect(await buyCoffee.coffeePrice()).to.equal(ethers.utils.parseEther("0.001"));
    });

    it("Should start with zero balance", async function () {
      expect(await buyCoffee.getContractBalance()).to.equal(0);
    });
  });

  describe("Buy Coffee", function () {
    it("Should allow users to buy coffee with correct payment", async function () {
      const price = await buyCoffee.coffeePrice();
      const quantity = 3;
      
      await expect(buyCoffee.connect(user1).buyCoffee(quantity, { value: price.mul(quantity) }))
        .to.emit(buyCoffee, "CoffeePurchased")
        .withArgs(user1.address, quantity, price.mul(quantity));
      
      expect(await buyCoffee.coffeesBought(user1.address)).to.equal(quantity);
      expect(await buyCoffee.getContractBalance()).to.equal(price.mul(quantity));
    });

    it("Should reject zero quantity", async function () {
      const price = await buyCoffee.coffeePrice();
      
      await expect(buyCoffee.connect(user1).buyCoffee(0, { value: price }))
        .to.be.revertedWith("Quantity must be greater than 0");
    });

    it("Should reject incorrect payment amount", async function () {
      const price = await buyCoffee.coffeePrice();
      const quantity = 2;
      const incorrectPayment = price.mul(quantity).sub(1); // 1 wei less
      
      await expect(buyCoffee.connect(user1).buyCoffee(quantity, { value: incorrectPayment }))
        .to.be.revertedWith("Incorrect ETH sent");
    });

    it("Should accumulate coffee purchases for same user", async function () {
      const price = await buyCoffee.coffeePrice();
      
      await buyCoffee.connect(user1).buyCoffee(2, { value: price.mul(2) });
      await buyCoffee.connect(user1).buyCoffee(3, { value: price.mul(3) });
      
      expect(await buyCoffee.coffeesBought(user1.address)).to.equal(5);
    });

    it("Should track purchases separately for different users", async function () {
      const price = await buyCoffee.coffeePrice();
      
      await buyCoffee.connect(user1).buyCoffee(2, { value: price.mul(2) });
      await buyCoffee.connect(user2).buyCoffee(3, { value: price.mul(3) });
      
      expect(await buyCoffee.coffeesBought(user1.address)).to.equal(2);
      expect(await buyCoffee.coffeesBought(user2.address)).to.equal(3);
    });
  });

  describe("Withdraw", function () {
    beforeEach(async function () {
      const price = await buyCoffee.coffeePrice();
      await buyCoffee.connect(user1).buyCoffee(2, { value: price.mul(2) });
    });

    it("Should allow owner to withdraw funds", async function () {
      const initialBalance = await ethers.provider.getBalance(owner.address);
      const contractBalance = await buyCoffee.getContractBalance();
      
      const tx = await buyCoffee.withdraw();
      const receipt = await tx.wait();
      const gasUsed = receipt.gasUsed.mul(receipt.effectiveGasPrice);
      
      const finalBalance = await ethers.provider.getBalance(owner.address);
      
      expect(finalBalance).to.equal(initialBalance.add(contractBalance).sub(gasUsed));
      expect(await buyCoffee.getContractBalance()).to.equal(0);
    });

    it("Should emit FundsWithdrawn event", async function () {
      const contractBalance = await buyCoffee.getContractBalance();
      
      await expect(buyCoffee.withdraw())
        .to.emit(buyCoffee, "FundsWithdrawn")
        .withArgs(owner.address, contractBalance);
    });

    it("Should reject withdrawal by non-owner", async function () {
      await expect(buyCoffee.connect(user1).withdraw())
        .to.be.revertedWith("Only owner allowed");
    });

    it("Should reject withdrawal when no funds available", async function () {
      await buyCoffee.withdraw(); // First withdrawal
      
      await expect(buyCoffee.withdraw())
        .to.be.revertedWith("No funds available");
    });
  });

  describe("View Functions", function () {
    it("Should return correct contract balance", async function () {
      const price = await buyCoffee.coffeePrice();
      const quantity = 5;
      
      await buyCoffee.connect(user1).buyCoffee(quantity, { value: price.mul(quantity) });
      
      expect(await buyCoffee.getContractBalance()).to.equal(price.mul(quantity));
    });
  });
});