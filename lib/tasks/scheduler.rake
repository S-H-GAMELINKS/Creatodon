task :welcome_mention => :environment do
  client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

  user = client.followers(1).first

  if user.url =~ /gamelinks007.net/ && !(client.follow(user.id).following?) then
    response = client.create_status("@#{user.acct}さん！\nCreatodonへようこそ！\n\nこのインスタンスは創作物全般(絵、小説、ゲームなどなど)を話すインスタンスです。\n一次、二次の区別なく創作に関する話をできたらと思っています\n\nお互いの活動内容なども共有できたらいいなと思います。\n普通にTwitter 代わりとして利用していただいても構いません\n")
    
    response = client.follow_by_uri(user.acct)
  end
end
