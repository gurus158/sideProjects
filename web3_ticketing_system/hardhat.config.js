require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  setting:{
    optimizer:{
      enabled:true,
      runs:200,
    }
  },
  networks:{
    mumbai:{
      url:process.env.MUMBAI_RPC,
      accounts:[process.env.MUMBAI_PK]
    }
  },
  etherscan: {
    apiKey: process.env.MUMBAISCAN_K,
  },
};
