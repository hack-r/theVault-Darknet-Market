<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Algolia\AlgoliaSearch\SearchClient;

class SyncAlgolia extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'sync:algolia';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Sync data from MariaDB to Algolia';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $appId = env('ALGOLIA_APP_ID');
        $apiKey = env('ALGOLIA_SECRET'); // or ALGOLIA_API_KEY if that’s what you use
        $indexName = 'products'; // the name of your index

        if (!$appId || !$apiKey) {
            $this->error('Algolia credentials are missing in .env');
            return 1;
        }

        $client = SearchClient::create($appId, $apiKey);
        $index = $client->initIndex($indexName);

        // Retrieve data via query.
        // Example: Getting products from your MariaDB table
        $products = DB::table('products')->get();

        // Convert the collection to an array of records with an "objectID"
        $records = $products->map(function ($product) {
            // Algolia requires an "objectID", so ensure you convert your unique id (e.g., 'id')
            return (array) $product + ['objectID' => $product->id];
        })->toArray();

        // Use the Algolia client to save the objects
        try {
            $index->saveObjects($records);
            $this->info('Data synced to Algolia successfully.');
        } catch (\Exception $e) {
            $this->error('Error syncing to Algolia: ' . $e->getMessage());
        }

        return 0;
    }
}
