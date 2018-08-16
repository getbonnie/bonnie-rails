#
class Landing::BaseController < ApplicationController
  META_TAGS = {
    'title' => 'Pew',
    'description' => '',
    'keywords' => %w[pew],
    'charset' => 'utf-8',
    'viewport' => 'width=device-width, initial-scale=1',
    'icon' => [
      { 'href' => '/favicon-196x196.png', 'type' => 'image/png', 'sizes' => '196x196' },
      { 'href' => '/favicon-128x128.png', 'type' => 'image/png', 'sizes' => '128x128' },
      { 'href' => '/favicon-96x96.png', 'type' => 'image/png', 'sizes' => '96x96' },
      { 'href' => '/favicon-32x32.png', 'type' => 'image/png', 'sizes' => '32x32' },
      { 'href' => '/favicon-16x16.png', 'type' => 'image/png', 'sizes' => '16x16' },
      { 'rel' => 'apple-touch-icon', 'href' => '/apple-touch-icon.png' },
      { 'rel' => 'apple-touch-icon-precomposed', 'sizes' => '57x57', 'href' => '/apple-touch-icon-57x57.png' },
      { 'rel' => 'apple-touch-icon-precomposed', 'sizes' => '114x114', 'href' => '/apple-touch-icon-114x114.png' },
      { 'rel' => 'apple-touch-icon-precomposed', 'sizes' => '72x72', 'href' => '/apple-touch-icon-72x72.png' },
      { 'rel' => 'apple-touch-icon-precomposed', 'sizes' => '144x144', 'href' => '/apple-touch-icon-144x144.png' },
      { 'rel' => 'apple-touch-icon-precomposed', 'sizes' => '60x60', 'href' => '/apple-touch-icon-60x60.png' },
      { 'rel' => 'apple-touch-icon-precomposed', 'sizes' => '120x120', 'href' => '/apple-touch-icon-120x120.png' },
      { 'rel' => 'apple-touch-icon-precomposed', 'sizes' => '76x76', 'href' => '/apple-touch-icon-76x76.png' },
      { 'rel' => 'apple-touch-icon-precomposed', 'sizes' => '152x152', 'href' => '/apple-touch-icon-152x152.png' }
    ],
    'application-name' => 'Pew',
    'msapplication-TileColor' => '#32e4c6',
    'msapplication-square70x70logo' => '/mstile-70x70.png',
    'msapplication-square150x150logo' => '/mstile-150x150.png',
    'msapplication-wide310x150logo' => '/mstile-310x150.png',
    'msapplication-square310x310logo' => '/mstile-310x310.png',
    'google-site-verification' => 'fsG1DKqXZ9wvmkRGPIch6x7c4aTAU_0iZCWu0gL3kho',
    'fb:app_id' => '289683661390900',
    'og' => {
      'title' => 'Pew',
      'type' => 'website',
      'description' => '',
      'url' => Rails.application.credentials.dig(Rails.env.to_sym, :domain),
      'image' => [{
        '_' => "#{Rails.application.credentials.dig(Rails.env.to_sym, :domain)}/tile-facebook.png",
        'width' => 1200,
        'height' => 627
      }]
    },
    'twitter' => {
      'card' => 'summary',
      'site' => '@pewapp',
      'description' => '',
      'image' => {
        '_' => "#{Rails.application.credentials.dig(Rails.env.to_sym, :domain)}/tile.png",
        'width' => 558,
        'height' => 558
      }
    }
  }.freeze

  def default_meta_tags
    META_TAGS
  end
end
