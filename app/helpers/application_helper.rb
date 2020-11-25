# frozen_string_literal: true
# rubocop:disable all

module ApplicationHelper
  def default_meta_tags
    {
      site: 'プロつく！',
      title: 'プロつく！ プログラミングチームを作ろう！',
      reverse: true,
      separator: ' | ',
      description:
        'プロつく！はプログラミング仲間を探している人同士を結びつけるマッチングサービスです。「プログラミングの独学で挫折しそう」、
        「プログラミングスクールにいきたいけどお金がない」と悩んでいるそこのあなた！プロつくで仲間を集め、チームで支え合う環境を作ってみませんか？',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url('protuku_favicon.png') },
        { href: image_url('protuku_favicon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        site_name: 'プロつく！',
        title: 'プロつく！ プログラミングチームを作ろう！',
        description:
        'プロつく！はプログラミング仲間を探している人同士を結びつけるマッチングサービスです。「プログラミングの独学で挫折しそう」、
        「プログラミングスクールにいきたいけどお金がない」と悩んでいるそこのあなた！プロつくで仲間を集め、チームで支え合う環境を作ってみませんか？',
        type: 'website',
        url: request.original_url,
        image: image_url('protuku_ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@Kiyo_Karl2'
      }
    }
  end
end
