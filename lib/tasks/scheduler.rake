task :welcome_mention => :environment do
  client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

  new_user = client.followers(ENV["ADMIN_ID"]).first
  user = User.find_by_id_name("#{new_user.acct}")

    if user == nil && new_user.url =~ /gamelinks007.net/ then
        response = client.create_status("@#{new_user.acct}さん！\nCreatodonへようこそ！\n\nこのインスタンスは創作物全般(絵、小説、ゲームなどなど)を話すインスタンスです。\n一次、二次の区別なく創作に関する話をできたらと思っています\n\nお互いの活動内容なども共有できたらいいなと思います。\n普通にTwitter 代わりとして利用していただいても構いません\n")
        response = client.follow_by_uri(new_user.acct)
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
  stream = Mastodon::Streaming::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

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

task :mention_test => :environment do
  

end
