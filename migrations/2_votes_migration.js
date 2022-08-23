const Votes = artifacts.require('./Votes');

module.exports = function (deployer) {
    deployer.deploy(Votes);
  };