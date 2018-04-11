require 'mastodon'

task :welcome_mention => :environment do
  client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

  new_user = client.followers(ENV["ADMIN_ID"]).first
  user = User.find_by_id_name("#{new_user.acct}")

    if user == nil && new_user.url =~ /gamelinks007.net/ then
        response = client.create_status("@#{new_user.acct}さん！\nCreatodonへようこそ！\n\nこのインスタンスは創作物全般(絵、小説、ゲームなどなど)を話すインスタンスです。\n一次、二次の区別なく創作に関する話をできたらと思っています\n\nお互いの活動内容なども共有できたらいいなと思います。\n普通にTwitter 代わりとして利用していただいても構いません\n")
        response = client.follow_by_uri(new_user.acct)
        response = client.create_status("@#{new_user.acct}さん！\nCreatodonでは以下の独自サービスを使用することが可能です！\n\nブラウザからのご利用では、インスタンスのユーザーさんが描かれたウチの子を使ったカスタムテーマを使うことが可能です！\n「ユーザー設定」をご確認ください！\n\n #創作 などのハッシュタグを定期的に拡散してくれるCreativeBoosterがいますので、呟かれた作品などに #創作 などをつけていただければと思います！\n詳しくは、「このインスタンスについて」をご確認ください！\n\n Creatodonユーザーの皆様のイラストなどを投稿できるCreatodon Folioというサービスも展開しています！\nこちらのURLよりアクセスできます！\nhttps://creatodon-folio.herokuapp.com \n\n #クトゥルフ神話 でクトゥルフ神話の呪文がランダムに呟いた内容に追加されます！クトゥルフ神話発狂プレイをしたい方はぜひご利用ください！\n\n")
        User.create(:id_name => "#{new_user.acct}")
    end
end

task :follow_local => :environment do
  client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

  client.followers(ENV["ADMIN_ID"]).each do |user|
    if user.url =~ /gamelinks007.net/ then
      url = user.acct
      response = client.follow_by_uri(url)
    end
  end
end

task :toot_info => :environment do
  client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

  @toot = Toot.find(rand(Toot.count) + 1)
  
  response = client.create_status("#{@toot.toot}")
end

task :mention => :environment do
  client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

  client.public_timeline(:local => true, :limit => 10).each do |toot|
    if toot.content =~ /@#{client.account(ENV["BOT_ID"]).acct}/ && toot.content =~ /歌って！/ then
      client.create_status("@#{toot.account.acct} さん\n でいじ～でいじ～ \n ぎぶみ～　ゆあ　あんさぁ　どぅ！\n")
    end
  end

  client.public_timeline(:limit => 1000).each do |toot|
    if toot.content =~ /#{client.account(ENV["BOT_ID"]).acct}@gamelinks007.net/ && toot.content =~ /歌って！/ then
      client.create_status("@#{toot.account.acct} さん\n でいじ～でいじ～ \n ぎぶみ～　ゆあ　あんさぁ　どぅ！\n")
    end
  end
end

task :mention_streaming => :environment do
  stream = Mastodon::Streaming::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

  stream.user() do |toot|
    if toot.content =~ /歌って！/ then
      client.create_status("@#{toot.account.acct} さん\n でいじ～でいじ～ \n ぎぶみ～　ゆあ　あんさぁ　どぅ！\n")
    end
  end
end

task :streaming => :environment do
  stream = Mastodon::Streaming::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

  stream.user() do |toot|
    puts toot.content
  end
end
