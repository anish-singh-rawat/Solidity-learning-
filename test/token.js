const { expect } = require("chai");

describe("Token", function () {
  try {
    it("Deployment testing balanceOf function", async function () {
      const [owner] = await ethers.getSigners();
      console.log("Owner address : ", owner.address)
      const Tokens = await ethers.getContractFactory("Token");
      const hardhadToken = await Tokens.deploy();
      const OwnerBalance = await hardhadToken.balanceOf(owner.address);
      console.log("OwnerBalance  : ",OwnerBalance);
      expect(await hardhadToken.totalSupply()).to.equal(OwnerBalance);
    });
  } catch (error) {
    console.log("error : ", error);
  }

  try {
     it("Transfer function testing", async function () {
      const [owner, address1, address2] = await ethers.getSigners();
      const Tokens = await ethers.getContractFactory("Token");
      const hardhadToken = await Tokens.deploy();
      await hardhadToken.Transfer(address1.address, 10);
      expect(await hardhadToken.balanceOf(address1.address)).to.equal(10);
      
      //transfer tokens from owner1 to address2 
      await hardhadToken.connect(address1).Transfer(address2.address, 5);
      expect(await hardhadToken.balanceOf(address2.address)).to.equal(5);
    });
  } catch (error) {
    console.log("Error ", error)
  }
});
