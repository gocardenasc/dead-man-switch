const hre = require("hardhat");
require("dotenv").config();

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const DeadManSwitch = await hre.ethers.getContractFactory("DeadManSwitch");
  const deadManSwitch = await DeadManSwitch.deploy(process.env.BENEFICIARY);

  await deadManSwitch.deployed();

  console.log("DeadManSwitch deployed to:", deadManSwitch.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
