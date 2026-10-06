@php
use Illuminate\Support\Str;
@endphp

@extends('master.main')

@section('title', 'Home')

@section('content')

    {{--@include('includes.search')--}}

    <div class="row">
        <div class="col-md-3 col-sm-12" style="margin-top:2.3em">
            @include('includes.categories')
            <div class="row mt-3">
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            Official Mirrors
                        </div>
                        <div class="card-body text-center">
                            @foreach(config('marketplace.mirrors') as $mirror)
                                <a href="{{ $mirror }}" style="text-decoration:none;">{{ $mirror }}</a>
                            @endforeach
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-9 col-sm-12 mt-3">
            <div class="row">
                <div class="col">
                    <h1 class="col-10">Welcome to {{ config('app.name') }}</h1>
                    <hr>
                </div>
            </div>

            <div class="row">
                <div class="col">
                    Your family's future begins here. Whether your goal is to free your future children from genetic illnesses or to give them the natural advantages you wish you'd had, we can help. Browse our selection of high-quality samples and know that your future is secure with The Vault.
                </div>
            </div>

            <div class="row mt-5">
                <div class="col-md-4">
                    <h4>
                        <img src="{{ asset('icons/fontawesome-free-6.7.2-web/svgs/solid/wallet.svg') }}" alt="Walletless" class="text-info" style="width: 24px; height: 24px; vertical-align: middle;">
                        Walletless
                    </h4>
                    <p>
                        Exit scams are impossible because we don't hold your coins. All transactions are walletless, meaning your crypto goes directly to the vendor's wallet, but remains frozen until signed by our escrow service.
                    </p>
                </div>

                <div class="col-md-4">
                    <h4>
                        <img src="{{ asset('icons/fontawesome-free-6.7.2-web/svgs/solid/user-shield.svg') }}" alt="Escrow" class="text-info" style="width: 24px; height: 24px; vertical-align: middle;">
                        Escrow
                    </h4>
                    <p>
                        Don't trust your money to strangers. All transactions on The Vault are multi-sig and require approval from the renown Revolutionary Agorist Cadre (RAC). RAC escrow services ensure that you are 100% satisfied with the delivery of your sample.
                    </p>
                </div>

                <div class="col-md-4">
                    <h4>
                        <img src="{{ asset('icons/fontawesome-free-6.7.2-web/svgs/solid/coins.svg') }}" alt="JGX" class="text-info" style="width: 24px; height: 24px; vertical-align: middle;">
                        Multiple Coins
                    </h4>
                    <p>
                        We support both Galtcoin (JGX) and Galtcoin Lite (JGL).
                    </p>
                </div>
            </div>

             <div class="row">
                <div class="col">
                    <hr>
                </div>
            </div>

            @isModuleEnabled('FeaturedProducts')
                @include('featuredproducts::frontpagedisplay')
            @endisModuleEnabled

            <div class="row mt-4">
                <div class="col-md-4">
                    <h4>
                        Top Suppliers
                    </h4>
                    <hr>
                    @foreach(\App\Vendor::topVendors() as $vendor)
                        <table class="table table-borderless table-hover">
                            <tr>
                                <td>
                                    <a href="{{ route('vendor.show', $vendor->id) }}" style="text-decoration: none; color:#212529">
                                        {{ optional($vendor->user)->username ?? 'Unknown User' }} <!-- Safely access the username -->
                                    </a>
                                </td>
                                <td class="text-right">
                                    <span class="btn btn-sm @if($vendor->experience >= 0) btn-primary @else btn-danger @endif active" style="cursor:default">
                                        Level {{ $vendor->getLevel() ?? 'N/A' }} <!-- Directly access experience -->
                                    </span>
                                </td>
                            </tr>
                        </table>
                    @endforeach
                </div>

                <div class="col-md-4">
                    <h4>
                        Featured Product
                    </h4>
                    <hr>

					@php
						$featuredProduct = \App\Product::find('9fb57a9a-ecff-11ef-9872-00163e5e6c16');
					@endphp

					@if($featuredProduct)
					<div class="card mb-4">
						<div class="card-header">Only 3 left!</div>
						<div class="card-body">
							<div class="row">
								<div class="col-md-4">
									<img src="{{ asset('storage/' . $featuredProduct->frontImage()->image) }}" 
										 alt="{{ $featuredProduct->name }}" 
										 class="img-fluid mb-2">
								</div>
								<div class="col-md-8">
									<h5>{{ $featuredProduct->name }}</h5>
									<p>{{ \Illuminate\Support\Str::limit($featuredProduct->description, 100) }}</p>
									<a href="{{ route('product.show', $featuredProduct) }}" class="btn btn-primary btn-sm">
										View Product
									</a>
								</div>
							</div>
						</div>
					</div>
					@endif
                </div>

				<div class="col-md-4">
					<h4>
						Rising Vendors
					</h4>
					<hr>
					@foreach(\App\Vendor::with('user')->risingVendors()->get() as $vendor) <!-- Use the query scope -->
						<table class="table table-borderless table-hover">
							<tr>
								<td>
									<a href="{{ route('vendor.show', $vendor) }}" style="text-decoration: none; color:#212529">
										{{ optional($vendor->user)->username ?? 'Unknown User' }}
									</a>
								</td>
								<td class="text-right">
									<span class="btn btn-sm @if($vendor->experience >= 0) btn-primary @else btn-danger @endif active" style="cursor:default">
										Level {{ optional($vendor)->getLevel() ?? 'N/A' }}
									</span>
								</td>
							</tr>
						</table>
					@endforeach
				</div>

            </div>
            <div class="row mt-3">
				<div class="col">
					<hr>
					<p class="text-center">
						<strong>Copyright © 2025, Libre Agora, LLC. </strong>This demo site is a proof of concept and is intended for entertainment purposes only. The information provided on this site is not intended as legal, financial, or medical advice. Libre Agora, LLC is not responsible for any actions taken based on the information presented on this site. All transactions and interactions are conducted at the user's own risk. Disputes are arbitrated by the Revolutionary Agorist Cadre.
					</p>
				</div>
			</div>

        </div>
    </div>

@stop
