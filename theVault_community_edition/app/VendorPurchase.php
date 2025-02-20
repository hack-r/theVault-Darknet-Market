<?php

namespace App;

use App\Traits\Uuids;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Arr; // Import Arr for array_random
use Illuminate\Support\Facades\Route; // Import Route for currentRouteName
use Illuminate\Support\Facades\Cache; // Import Cache for remember

/**
 * Address of the coin
 *
 * Class VendorPurchase
 * @package App
 */
class VendorPurchase extends Model
{
    use Uuids;
    protected $keyType = 'string';
    protected $primaryKey = 'id';
    public $incrementing = false;

    /**
     * Relationship with the user
     */
    public function user()
    {
        return $this->belongsTo(\App\User::class);
    }

    /**
     * Returns the balance of the deposit address
     *
     * @return float
     * @throws \Exception
     */
    public function getBalance()
    {
        $coinServiceClass = config('coins.coin_list.' . $this->coin);
        $coinService = new $coinServiceClass();

        // Send request for balance of the address
        return $coinService->getBalance(['address' => $this->address]);
    }

    /**
     * Return formatted number of balance of the address
     *
     * @return string
     */
    public function getBalanceAttribute()
    {
        try {
            $balanceAddress = $this->getBalance();
        } catch (\Exception $e) {
            // inform admin
            Log::warning("Request for balance of the '$this->address', coin '$this->coin' failed because:");
            Log::warning($e->getMessage());
            return 'Unavailable';
        }
        return number_format($balanceAddress, 8);
    }

    /**
     * Returns how much needs to be paid to the address
     *
     * @return float
     */
    public function getTargetBalance()
    {
        $coinServiceClass = config('coins.coin_list.' . $this->coin);
        $coinService = new $coinServiceClass();

        $vendorFeeUsd = config('marketplace.vendor_fee');
        return $coinService->usdToCoin($vendorFeeUsd);
    }

    /**
     * Returns formatted number how much needs to be paid
     *
     * @return string
     */
    public function getTargetAttribute()
    {
        return number_format($this->getTargetBalance(), 8);
    }

    /**
     * Returns true if there are enough funds on this coin address
     *
     * @return bool
     */
    public function isEnough()
    {
        try {
            $coinServiceClass = config('coins.coin_list.' . $this->coin);
            $coinService = new $coinServiceClass();

            $vendorFeeUsd = config('marketplace.vendor_fee');
            $vendorFeeCoin = $coinService->usdToCoin($vendorFeeUsd);

            // returns true if the balance is bigger than it should be paid
            return $this->getBalance() >= $vendorFeeCoin;
        } catch (\Exception $e) {
            Log::warning($e->getMessage());
            return false;
        }
    }

    /**
     * String how long was passed since adding address
     *
     * @return string
     */
    public function getAddedAgoAttribute()
    {
        return Carbon::parse($this->created_at)->diffForHumans();
    }

    /**
     * Unload all funds to market address
     *
     * @return bool
     */
    public function unloadFunds()
    {
        try {
            $coinServiceClass = config('coins.coin_list.' . $this->coin);
            $coinService = new $coinServiceClass();

            $marketCoinAddresses = config('coins.market_addresses.' . $this->coin);
            // pick one from the array
            $marketCoinAddress = Arr::random($marketCoinAddresses);

            // send to market address
            $coinService->sendToAddress($marketCoinAddress, $this->getBalance());

            // Return true if funds were successfully unloaded
            return true;
        } catch (\Exception $e) {
            Log::warning($e);
            return false; // Return false if there was an error
        }
    }
}
