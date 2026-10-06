<?php

namespace App;

use App\Marketplace\Payment\FinalizeEarlyPayment;
use App\Traits\Experience;
use App\Traits\Uuids;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Arr; // Import Arr for array_random

class Vendor extends User
{
    use Uuids;
    use Experience;

    protected $table = 'vendors';
    protected $keyType = 'string';
    protected $primaryKey = 'id';
    protected $fillable = ['id', 'vendor_level', 'about', 'created_at', 'updated_at'];

    // ... (other methods)

    /**
     * Checks if vendor is trusted (set in admin panel)
     *
     * @return bool
     */
    public function isTrusted(): bool
    {
        if ($this->trusted) {
            return true;
        }
        $lvl = $this->getLevel();
        $positive = $this->countFeedbackByType('positive');
        $neutral = $this->countFeedbackByType('neutral');
        $negative = $this->countFeedbackByType('negative');
        $total = $positive + $negative + $neutral;

        if ($total == 0 || $lvl == 1 || $positive == 0) {
            return false;
        }

        $percentage = round(($positive / $total) * 100);
        if ($lvl >= config('marketplace.trusted_vendor.min_lvl') &&
            $total >= config('marketplace.trusted_vendor.min_feedbacks') &&
            $percentage >= config('marketplace.trusted_vendor.percentage_of_feedback_positive')
        ) {
            return true;
        }

        return false;
    }

    /**
     * Checks if vendor should have DWC tag
     *
     * @return bool
     */
    public function isDwc(): bool
    {
        return $this->countFeedbackByType('negative') > config('marketplace.vendor_dwc_tag_count');
    }

    /**
     * Returns rounded avg rate of the feedback, half rounded on down
     * 4.1 => 4
     * 4.67 => 4.5
     *
     * @param $type
     * @return float
     */
    public function roundAvgRate($type)
    {
        $avgRateNumeric = (float)$this->avgRate($type);
        return floor($avgRateNumeric * 2) / 2;
    }

    /**
     * If there is profile bg, return it, if not set random bg
     */
    public function getProfileBg()
    {
        if ($this->profilebg == null) {
            $this->profilebg = Arr::random(config('vendor.profile_bgs')); // Use Arr::random
            $this->save();
        }

        return $this->profilebg;
    }

    /**
     * Vendors with most sales all time
     * @return mixed
     */
    public static function topVendors()
    {
        // Cache the result for the duration set in
        $cacheDuration = config('marketplace.front_page_cache.top_vendors');

        return Cache::remember(
            'top_vendors_frontpage',
            $cacheDuration,
            function () {
                return self::with('user')
                    ->withCount(['sales as purchases_count'])
                    ->orderByDesc('purchases_count')
                    ->limit(3)
                    ->get();
            }
        );
    }

    /**
     * Vendors with most sales in last 7 days
     * @return mixed
     */
    public function scopeRisingVendors($query)
    {
        return $query->where('created_at', '>=', Carbon::now()->subDays(7))
            ->withCount('sales as purchases_count')
            ->orderByDesc('purchases_count')
            ->limit(5);
    }

    public function getId()
    {
        return $this->id;
    }

    /**
     * Can Vendor use FE
     *
     * @return bool
     */
    public function canUseFe()
    {
        return $this->can_use_fe == 1 && FinalizeEarlyPayment::isEnabled();
    }

    /**
     * Check if vendor can use specific product type
     *
     * @param string $type
     *
     * @return bool
     */
    public function canUseType(string $type)
    {
        if ($type == 'fe') {
            return $this->canUseFe();
        }
        return true;
    }
}
