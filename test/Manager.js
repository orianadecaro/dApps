const Manager = artifacts.require("Manager");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("manager", function (/* accounts */) {
  it("should assert true", async function () {
    await manager.deployed();
    return assert.isTrue(true);
  });
});
