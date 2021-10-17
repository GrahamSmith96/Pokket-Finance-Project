import { ethers } from "hardhat";

async function main() {
   //todo: fill in the deployment code here to deploy ComplexGame, SimpleGame,
   //Please consider upgradability and access control if possible, could change the Corresponding Contract if needed
   const SimpleGame = await ethers.getContractFactory("SimpleGame");
   const ComplexGame = await.ethers.getContractFactory("ComplexGame");
   const instance1 = await upgrades.deployProxy(SimpleGame);
   const instance2 = await upgrade.deployProxy(ComplexGame);
   await instance1.deployed();
   await instance2.deployed();
 
   console.log(instance1.address, instance2.address);
}

/* Since we want the contract to be upgradeable, both SimpleGame and ComplexGame are deployed as proxies with
a corresponding implementation address. To upgrade the contract to gameV2, simply input the proxy address along
with the gameV2 contract into the upgrade function to obtain an upgraded contract that preserves all of the functions
and state variables of the previous version. This will work when upgrading from SimpleGame to ComplexGame where SimpleGame is
gameV1 and ComplexGame is gameV2.

TO DO: Place the address of your proxy for gameV1 here!
const proxyAddress = (address of the proxy for gameV1); 

async function main() {
  const gameV2 = await ethers.getContractFactory("gameV2");
  const upgraded = await upgrades.upgradeProxy(proxyAddress, gameV2);
}

*/
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
