// SPDX-License-Identifier: AGPL
pragma solidity 0.8.9;
import "./SimpleBond.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

contract BondFactoryClone {
  address public immutable tokenImplementation;
  event BondCreated(address newBond);

  constructor() {
    tokenImplementation = address(new SimpleBond());
  }

  function createBond(
    address _owner,
    address _issuer,
    uint256 _maturityDate,
    uint256 _maxBondSupply,
    address _collateralAddress,
    uint256 _collateralizationRatio,
    address _borrowingAddress,
    uint256 _convertibilityRatio
  ) external returns (address clone) {
    clone = Clones.clone(tokenImplementation);
    SimpleBond(clone).initialize(
      _owner,
      _issuer,
      _maturityDate,
      _maxBondSupply,
      _collateralAddress,
      _collateralizationRatio,
      _borrowingAddress,
      _convertibilityRatio
    );
    emit BondCreated(clone);
  }
}