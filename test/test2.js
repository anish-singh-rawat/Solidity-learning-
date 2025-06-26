const { expect } = require("chai");

describe("Token deployment contract", function () {
  try {
    let Token;
    let hardhadToken;
    let owner, address1, address2, addresss;

    beforeEach(async function () {
      [owner, address1, address2, ...addresss] = await ethers.getSigners();
      Token = await ethers.getContractFactory("Token");
      hardhadToken = await Token.deploy();
    });

    it("should set the right owner", async function () {
      console.log("Owner address : ", owner.address);
      expect(await hardhadToken.owner()).to.equal(owner.address);
    });

    it("should assign the total supply of tokens to the owners", async function () {
      const balanceOfOwner = await hardhadToken.balanceOf(owner.address);
      expect(await hardhadToken.totalSupply()).to.equal(balanceOfOwner);
    });

    describe("Transaction function checker", () => {
      it("should tranfer token between one to another account", async function () {
        await hardhadToken.Transfer(address1.address, 5);
        expect(await hardhadToken.balanceOf(address1.address)).to.equal(5);

        await hardhadToken.connect(address1).Transfer(address2.address, 1);
        expect(await hardhadToken.balanceOf(address2.address)).to.equal(1);
      });
    });

    // it("should fail if sender doesn't have enough tokens", async function () {
    //   const initialBalance = await hardhadToken.balanceOf(owner.address);
    //   await expect(
    //     hardhadToken.connect(address1).Transfer(owner.address, 1)
    //   ).to.be.revertedWith("Not enough tokens");
    //   expect(await hardhadToken.balanceOf(owner.address)).to.equal(
    //     initialBalance
    //   );
    // });
  } catch (error) {
    console.log("Error in deployment : ", error);
  }
});
