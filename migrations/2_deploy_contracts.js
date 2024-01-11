var ProteinCoin = artifacts.require("ProteinCoin");

module.exports = function (deployer) {
  deployer.deploy(ProteinCoin, "ProteinCoin", "PC", "100000000000000000000000");
};
