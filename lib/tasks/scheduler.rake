task :welcome_mention => :environment do
  client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["ACCESS_TOKEN"])

  user = client.followers(ENV["ADMIN_ID"]).first
  creatodon = client.account(ENV["BOT_ID"]) 
  
  client.followers(user.id).each do |val|
    if val.acct != creatodon.acct && user.url =~ /gamelinks007.net/  then
      response = client.create_status("@#{user.acct}さん！\nCreatodonへようこそ！\n\nこのインスタンスは創作物全般(絵、小説、ゲームなどなど)を話すインスタンスです。\n一次、二次の区別なく創作に関する話をできたらと思っています\n\nお互いの活動内容なども共有できたらいいなと思います。\n普通にTwitter 代わりとして利用していただいても構いません\n")
      response = client.follow_by_uri(user.acct)
    end
  end
end
