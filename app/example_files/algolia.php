<?php
require(__DIR__."/vendor/autoload.php");
use Algolia\AlgoliaSearch\Api\SearchClient;

// Fetch sample dataset
$url = "https://dashboard.algolia.com/api/1/sample_datasets?type=movie";
$response = file_get_contents($url);
$movies = json_decode($response, true);

// Connect and authenticate with your Algolia app
$client = SearchClient::create('YOUR ID', 'YOUR SECRET');

// Save records in Algolia index
$client->saveObjects(
  "movies_index",

  movies
)

print('Done!');
