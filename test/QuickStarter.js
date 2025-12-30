const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("QuickStarter Contract", function () {
  let QuickStarter;
  let quickStarter;
  let owner;
  let investor1;
  let investor2;

  beforeEach(async function () {
    [owner, investor1, investor2] = await ethers.getSigners();

    QuickStarter = await ethers.getContractFactory("QuickStarter");
    quickStarter = await QuickStarter.deploy();
    await quickStarter.deployed();
  });

  /* --------------------------------------------------
     DEPLOYMENT
  -------------------------------------------------- */

  it("Should deploy the contract successfully", async function () {
    expect(await quickStarter.projectCount()).to.equal(0);
  });

  /* --------------------------------------------------
     CREATE PROJECT
  -------------------------------------------------- */

  it("Should allow a user to create a project", async function () {
    await quickStarter.createProject(
      "AI Startup",
      ethers.utils.parseEther("1")
    );

    const project = await quickStarter.getProject(1);

    expect(project[0]).to.equal(owner.address);
    expect(project[1]).to.equal("AI Startup");
    expect(project[2]).to.equal(ethers.utils.parseEther("1"));
    expect(project[3]).to.equal(0);
    expect(project[4]).to.equal(true);
  });

  it("Should fail if project goal is zero", async function () {
    await expect(
      quickStarter.createProject("Invalid Project", 0)
    ).to.be.revertedWith("Goal must be greater than 0");
  });

  /* --------------------------------------------------
     INVESTMENT
  -------------------------------------------------- */

  it("Should allow investors to invest ETH", async function () {
    await quickStarter.createProject(
      "Blockchain App",
      ethers.utils.parseEther("1")
    );

    await quickStarter
      .connect(investor1)
      .invest(1, { value: ethers.utils.parseEther("0.2") });

    const project = await quickStarter.getProject(1);

    expect(project[3]).to.equal(ethers.utils.parseEther("0.2"));
  });

  it("Should track individual investor contributions", async function () {
    await quickStarter.createProject(
      "Web3 Platform",
      ethers.utils.parseEther("2")
    );

    await quickStarter
      .connect(investor1)
      .invest(1, { value: ethers.utils.parseEther("0.5") });

    await quickStarter
      .connect(investor2)
      .invest(1, { value: ethers.utils.parseEther("0.3") });

    const investment1 = await quickStarter.investments(
      1,
      investor1.address
    );

    const investment2 = await quickStarter.investments(
      1,
      investor2.address
    );

    expect(investment1).to.equal(ethers.utils.parseEther("0.5"));
    expect(investment2).to.equal(ethers.utils.parseEther("0.3"));
  });

  it("Should fail if investment amount is zero", async function () {
    await quickStarter.createProject(
      "Zero Invest Test",
      ethers.utils.parseEther("1")
    );

    await expect(
      quickStarter.connect(investor1).invest(1, { value: 0 })
    ).to.be.revertedWith("Investment must be > 0");
  });

  it("Should fail if project does not exist", async function () {
    await expect(
      quickStarter.connect(investor1).invest(99, {
        value: ethers.utils.parseEther("0.1"),
      })
    ).to.be.reverted;
  });
});
