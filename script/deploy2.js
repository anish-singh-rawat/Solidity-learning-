async function main() {
  const BuyCoffee = await ethers.getContractFactory("BuyCoffee");
  const buyCoffee = await BuyCoffee.deploy();
  await buyCoffee.deployed();
  console.log("BuyCoffee deployed to:", buyCoffee.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
