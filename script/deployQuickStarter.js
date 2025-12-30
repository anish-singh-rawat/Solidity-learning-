async function main() {
  const QuickStarter = await ethers.getContractFactory("QuickStarter");
  const quickStarter = await QuickStarter.deploy();

  await quickStarter.deployed();

  console.log("quickStarter deployed to:", quickStarter.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
