// const { expect } = require("chai");

// describe("Token", function () {
//   try {
//     it("Deployment testing balanceOf function", async function () {
//       const [owner] = await ethers.getSigners();
//       console.log("Owner address : ", owner.address)
//       const Tokens = await ethers.getContractFactory("Token");
//       const hardhadToken = await Tokens.deploy();
//       const OwnerBalance = await hardhadToken.balanceOf(owner.address);
//       console.log("OwnerBalance  : ",OwnerBalance);
//       expect(await hardhadToken.totalSupply()).to.equal(OwnerBalance);
//     });
//   } catch (error) {
//     console.log("error : ", error);
//   }

//   try {
//      it("Transfer function testing", async function () {
//       const [owner, address1, address2] = await ethers.getSigners();
//       const Tokens = await ethers.getContractFactory("Token");
//       const hardhadToken = await Tokens.deploy();
//       await hardhadToken.Transfer(address1.address, 10);
//       expect(await hardhadToken.balanceOf(address1.address)).to.equal(10);

//       //transfer tokens from owner1 to address2
//       await hardhadToken.connect(address1).Transfer(address2.address, 5);
//       expect(await hardhadToken.balanceOf(address2.address)).to.equal(5);
//     });
//   } catch (error) {
//     console.log("Error ", error)
//   }
// });

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
        const address1Balance = await hardhadToken.balanceOf(address1.address);
        expect(address1Balance).to.equal(5);
        await hardhadToken.connect(address1).Transfer(address2.address, 5);
        const address2Balance = await hardhadToken.balanceOf(address2.address);
        expect(address2Balance).to.equal(5);
      });

      it("should fail if sender doesn't have enough tokens", async function () {
        const initialBalance = await hardhadToken.balanceOf(owner.address);
        console.log("initialBalance : ", initialBalance.toString());
        await expect(
          hardhadToken.connect(address2).Transfer(owner.address, 5)
        ).to.be.revertedWith("Not ebough tokens");
        expect(await hardhadToken.balanceOf(owner.address)).to.equal(
          initialBalance
        );
      });

      it("should update balances after transfer", async function () {
        const initialownerBalance = await hardhadToken.balanceOf(owner.address);
        await hardhadToken.Transfer(address1.address, 10);
        await hardhadToken.Transfer(address2.address, 10);
        const finalOwnerBalance = await hardhadToken.balanceOf(owner.address);

        expect(finalOwnerBalance).to.equal(initialownerBalance - 20);

         const address1Balance = await hardhadToken.balanceOf(address1.address);
         expect(address1Balance).to.equal(10);

         const address2Balance = await hardhadToken.balanceOf(address2.address);
          expect(address2Balance).to.equal(10);
      });
    });

  } catch (error) {
    console.log("Error in deployment : ", error);
  }
});
