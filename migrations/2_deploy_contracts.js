var HealthCoin = artifacts.require("HealthCoin");


module.exports = function(deployer) {
   deployer.deploy(HealthCoin,'HealthCoin','HC','100000000000000000000000');
}
