// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface ERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

/**
 * @title Parimutuel Protocol Contract
 * @dev smart contract for parimutuel contests
 *      only accept HXRO tokens in this version
 */
contract Parimutuel is Context {
    using SafeMath for uint256;

    /// @notice unique contract id, auto-increment
    uint256 public currentPoolId = 1;
    uint256 public maxBuckets = 2;
    /// @notice MATIC ERC20 token address
    address public currency = 0x94082fe34E939EDd3FDE466Ea4a58cD5bFCF3048;
    ERC20 token = ERC20(currency);
    /// @notice administrator address
    address public admin;

    /**
     * Entries
     */
    /// @notice Entries: poolId => sender => bucketId => amount
    mapping (uint256 => mapping (address => mapping (uint256 => uint256))) public entry;
    /// @notice Bucket size: poolId => bucketId => amount (total)
    mapping (uint256 => mapping (uint256 => uint256)) public bucketSize;
    /// @notice Bucket size: poolId => bucketId => address => amount (total)
    mapping (uint256 => mapping (uint256 => mapping (address => uint256))) public bucketSizePerAddress;
    /// @notice Pool size: poolId => amount (total)
    mapping (uint256 => uint256) public poolSize;
    /// @notice address in each bucket: poolId => bucketId => dynamic address array
    /// @dev this is expensive but needed to settle on-chain
    mapping (uint256 => mapping (uint256 => address[])) public bucketAddresses;

    /**
     * Pools
     */
    /// @notice Is pool live? poolId => boolean
    mapping (uint256 => bool) public live;
    /// @notice Is pool settled? poolId => boolean
    mapping (uint256 => bool) public settled;

    /// @notice event for entry logged
    event Received(uint256 poolId, address sender, uint256 bucketId, uint256 amount);
    /// @notice poolId with winning bucketId with the total poolSize
    event Settled(uint256 poolId, uint256 bucketId, uint256 poolSize);
    /// @dev DEBUG event
    event DEBUG(string message);

    modifier isAdmin() {
        require(
            _msgSender() == admin,
            "Sender not authorized."
        );
        _;
    }

    constructor() {
        /// @dev set creator as admin
        admin = _msgSender();
        /// @dev auto initiate first pool
        live[currentPoolId] = true;
    }

    function createPool() isAdmin public {
        currentPoolId = SafeMath.add(currentPoolId, 1);
        live[currentPoolId] = true;
    }

    function settlePool(uint256 _poolId, uint256 _winningBucketId) isAdmin public {
        require(_winningBucketId < maxBuckets && _winningBucketId >= 0, "Invalid bucketId");
        /// @dev Pool winner distribution
        for (uint256 i=0; i < bucketAddresses[_poolId][_winningBucketId].length; i++) {
            token.transferFrom(
                address(this),
                bucketAddresses[_poolId][_winningBucketId][i],
                SafeMath.div(bucketSizePerAddress[_poolId][_winningBucketId][bucketAddresses[_poolId][_winningBucketId][i]], poolSize[_poolId])
            );
        }
        /// @dev Disable pool
        live[_poolId] = false;
        /// @dev Delete all bucket addresses
        for (uint256 j=0; j < maxBuckets; j++) {
            delete bucketAddresses[_poolId][j];
        }
        emit Settled(_poolId, _winningBucketId, poolSize[_poolId]);
    }

    function enter(uint256 _poolId, uint256 _bucketId, uint256 _amount) public {
        require(live[_poolId] == true && settled[_poolId] == false, "Invalid pool id");
        require(_bucketId < maxBuckets && _bucketId >= 0, "Invalid bucketId");
        emit DEBUG("pool is valid");
        require(token.balanceOf(_msgSender()) >= _amount, "Insufficient balance");
        /// @dev user needs to approve the contract address explicitly
        require(token.transferFrom(_msgSender(), address(this), _amount), "Payment transfer failed");
        /// @dev add address for new users
        if (entry[_poolId][_msgSender()][_bucketId] == 0 && _amount > 0) {
            bucketAddresses[_poolId][_bucketId].push(_msgSender());
        }
        /// @dev log entry
        entry[_poolId][_msgSender()][_bucketId] = SafeMath.add(entry[_poolId][_msgSender()][_bucketId], _amount);
        /// @dev log bucketSize
        bucketSize[_poolId][_bucketId] = SafeMath.add(bucketSize[_poolId][_bucketId], _amount);
        /// @dev log bucketSize per address
        bucketSizePerAddress[_poolId][_bucketId][_msgSender()] = SafeMath.add(bucketSizePerAddress[_poolId][_bucketId][_msgSender()], _amount);
        /// @dev log poolSize
        poolSize[_poolId] = SafeMath.add(poolSize[_poolId], _amount);
        emit Received(_poolId, _msgSender(), _bucketId, _amount);
    }
}
