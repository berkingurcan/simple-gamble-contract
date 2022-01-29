
const hre = require("hardhat");

async function main() {

  const SimpleGamble = await hre.ethers.getContractFactory("SimpleGamble");
  const simpleGamble = await SimpleGamble.deploy();

  await simpleGamble.deployed();

  console.log("SimpleGample deployed to:", simpleGamble.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
